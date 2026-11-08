#!/usr/bin/env python3
"""Сборка: sources/services.yaml + внешние источники -> dist/."""
import json
import shutil
import sys
from collections import defaultdict

from common import ROOT, covered, fetch, load_config, minimize, norm_domain, split_ips

ITDOG = "https://raw.githubusercontent.com/itdoginfo/allow-domains/main"
V2FLY = "https://raw.githubusercontent.com/v2fly/domain-list-community/master/data"
RIPESTAT = "https://stat.ripe.net/data/announced-prefixes/data.json?sourceapp=ru-restricted-lists&resource=AS"

CFG = load_config()
SETTINGS = CFG.get("settings", {})
SHARED = {norm_domain(d) for d in CFG.get("shared_roots", [])}
GLOBAL_EXCLUDE = {norm_domain(d) for d in CFG.get("exclude", [])}
DIST = ROOT / "dist"
WARNINGS = []


def warn(msg):
    if msg not in WARNINGS:
        WARNINGS.append(msg)
        print("WARN:", msg, file=sys.stderr)


def new_acc():
    return {"domains": set(), "regexp": set(), "cidr": set()}


def get_text(url, label):
    text = fetch(url)
    if text is None:
        warn(f"{label}: файл не найден (404), источник пропущен")
    return text or ""


def add_plain(text, acc, label):
    for line in text.splitlines():
        line = line.split("#", 1)[0].strip()
        if not line:
            continue
        d = norm_domain(line)
        if d:
            acc["domains"].add(d)
        else:
            warn(f"{label}: пропущена строка {line!r}")


def add_cidr_text(text, acc):
    for line in text.splitlines():
        line = line.split("#", 1)[0].strip()
        if line:
            acc["cidr"].add(line)


def add_v2fly(name, acc, seen):
    if name in seen:
        return
    seen.add(name)
    for raw in get_text(f"{V2FLY}/{name}", f"v2fly:{name}").splitlines():
        line = raw.split("#", 1)[0].strip()
        if not line:
            continue
        token = line.split()[0]  # отбрасываем атрибуты вида @cn
        kind, sep, value = token.partition(":")
        if not sep:
            kind, value = "domain", token
        if kind == "include":
            add_v2fly(value, acc, seen)
        elif kind == "regexp":
            acc["regexp"].add(value)
        elif kind in ("domain", "full"):
            d = norm_domain(value)
            if d:
                acc["domains"].add(d)
        # keyword: пропускаем — слишком широкое совпадение


def add_asn(asn, acc):
    text = fetch(f"{RIPESTAT}{asn}", timeout=120)
    prefixes = json.loads(text or "{}").get("data", {}).get("prefixes", [])
    if not prefixes:
        warn(f"AS{asn}: RIPEstat не вернул префиксов")
    acc["cidr"].update(p["prefix"] for p in prefixes)


def add_upstream(spec, acc):
    kind, _, name = spec.partition(":")
    if kind == "itdog":
        add_plain(get_text(f"{ITDOG}/Services/{name}.lst", spec), acc, spec)
    elif kind == "itdog-cat":
        add_plain(get_text(f"{ITDOG}/Categories/{name}.lst", spec), acc, spec)
    elif kind == "itdog-ip4":
        add_cidr_text(get_text(f"{ITDOG}/Subnets/IPv4/{name}.lst", spec), acc)
    elif kind == "itdog-ip6":
        add_cidr_text(get_text(f"{ITDOG}/Subnets/IPv6/{name}.lst", spec), acc)
    elif kind == "v2fly":
        add_v2fly(name, acc, set())
    elif kind == "domains-url":
        add_plain(get_text(name, spec), acc, spec)
    elif kind == "cidr-url":
        add_cidr_text(get_text(name, spec), acc)
    else:
        raise ValueError(f"неизвестный тип источника: {spec}")


def write(rel, lines):
    path = DIST / rel
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + ("\n" if lines else ""), encoding="utf-8")


def emit(name, acc):
    inventory = sorted(acc["domains"])
    domains = minimize(acc["domains"])
    regexps = sorted(acc["regexp"])
    v4, v6 = split_ips(acc["cidr"], warn)
    s4, s6 = [str(n) for n in v4], [str(n) for n in v6]
    tag = f"rr-{name}"

    write(f"inventory/{name}.txt", inventory)  # полный перечень FQDN, без схлопывания
    write(f"domains/{name}.txt", domains)      # для роутера: поддомены схлопнуты в родителя
    write(f"ip/{name}-v4.txt", s4)
    write(f"ip/{name}-v6.txt", s6)

    # OpenWrt / dnsmasq
    write(f"dnsmasq/{name}-nftset.conf", [f"nftset=/{d}/4#inet#fw4#vpn_domains" for d in domains])
    write(f"dnsmasq/{name}-ipset.conf", [f"ipset=/{d}/vpn_domains" for d in domains])

    # sing-box (.srs компилируется в CI)
    rules, domain_rule = [], {}
    if domains:
        domain_rule["domain_suffix"] = domains
    if regexps:
        domain_rule["domain_regex"] = regexps
    if domain_rule:
        rules.append(domain_rule)
    if s4 or s6:
        rules.append({"ip_cidr": s4 + s6})
    if rules:
        version = SETTINGS.get("singbox_ruleset_version", 2)
        write(f"sing-box/{name}.json", [json.dumps({"version": version, "rules": rules}, indent=2)])

    # Mihomo / Clash Meta (behavior: classical)
    payload = ([f"DOMAIN-SUFFIX,{d}" for d in domains] + [f"DOMAIN-REGEX,{r}" for r in regexps]
               + [f"IP-CIDR,{c},no-resolve" for c in s4] + [f"IP-CIDR6,{c},no-resolve" for c in s6])
    write(f"mihomo/{name}.yaml", ["payload:"] + [f"  - {json.dumps(p)}" for p in payload])

    # Xray / v2ray: исходники для geosite.dat (собирается в CI)
    v2 = [f"domain:{d}" for d in domains] + [f"regexp:{r}" for r in regexps]
    if v2:
        write(f"v2fly-data/{name}", v2)

    # MikroTik RouterOS 7.6+
    fwd = SETTINGS.get("mikrotik_forward_to", "1.1.1.1")
    write(f"mikrotik/{name}-dns.rsc",
          [f'/ip dns static remove [find comment="{tag}"]', "/ip dns static"]
          + [f'add name={d} type=FWD forward-to={fwd} match-subdomain=yes '
             f'address-list=vpn_domains comment="{tag}"' for d in domains])
    ip_rsc = [f'/ip firewall address-list remove [find list=vpn_ip comment="{tag}"]', "/ip firewall address-list"]
    ip_rsc += [f'add list=vpn_ip address={c} comment="{tag}"' for c in s4]
    if s6:
        ip_rsc += [f'/ipv6 firewall address-list remove [find list=vpn_ip comment="{tag}"]', "/ipv6 firewall address-list"]
        ip_rsc += [f'add list=vpn_ip address={c} comment="{tag}"' for c in s6]
    write(f"mikrotik/{name}-ip.rsc", ip_rsc)

    # Keenetic (KeeneticOS 4.x): FQDN-группы + статические маршруты
    iface = SETTINGS.get("keenetic_interface", "Wireguard0")
    chunk = int(SETTINGS.get("keenetic_chunk", 250))
    short = name.replace("-", "_")[:24]
    cli = []
    for i in range(0, len(domains), chunk):
        group = f"rr_{short}_{i // chunk + 1}"
        cli += [f"object-group fqdn {group}"] + [f"include {d}" for d in domains[i:i + chunk]]
        cli += ["exit", f"dns-proxy route object-group {group} {iface} auto"]
    cli += [f"ip route {n.network_address} {n.netmask} {iface} auto" for n in v4]
    cli.append("system configuration save")
    write(f"keenetic/{name}-cli.txt", cli)

    return {"domains": len(domains), "fqdn": len(inventory), "regexp": len(regexps),
            "ipv4": len(s4), "ipv6": len(s6)}


def write_readme(summary):
    lines = ["# ru-restricted-lists — текущая сборка", "",
             "| Сервис | Компания | Группа | Ограничение | Проверен | Доменов | IPv4 | IPv6 |",
             "|---|---|---|---|---|---|---|---|"]
    for s in summary["services"]:
        lines.append(f"| {s['id']} | {s['company']} | {s['group']} | {s['restriction']} | "
                     f"{'да' if s['verified'] else 'нет'} | {s['domains']} | {s['ipv4']} | {s['ipv6']} |")
    lines += ["", "## Агрегаты", ""]
    lines += [f"- `{a['id']}`: {a['domains']} доменов, {a['ipv4']} IPv4, {a['ipv6']} IPv6" for a in summary["aggregates"]]
    if summary["warnings"]:
        lines += ["", "## Предупреждения", ""] + [f"- {w}" for w in summary["warnings"]]
    write("README.md", lines)


def main():
    shutil.rmtree(DIST, ignore_errors=True)
    aggregates = defaultdict(new_acc)
    summary = {"services": [], "aggregates": []}

    for svc in CFG["services"]:
        sid = svc["id"]
        acc = new_acc()
        for d in svc.get("domains", []):
            nd = norm_domain(d)
            if nd:
                acc["domains"].add(nd)
            else:
                warn(f"{sid}: некорректный домен {d!r}")
        acc["regexp"].update(svc.get("regexp", []))
        acc["cidr"].update(svc.get("cidr", []))
        for spec in svc.get("upstreams", []):
            add_upstream(spec, acc)
        for asn in svc.get("asn", []):
            add_asn(asn, acc)

        excluded = GLOBAL_EXCLUDE | {norm_domain(d) for d in svc.get("exclude", [])}
        for d in sorted(acc["domains"] & SHARED):
            warn(f"{sid}: {d} — общий корневой домен, убран (нужны конкретные поддомены)")
        acc["domains"] = {d for d in acc["domains"] if d not in SHARED and not covered(d, excluded)}

        stats = emit(sid, acc)
        summary["services"].append({
            "id": sid, "company": svc.get("company"), "group": svc.get("group", "other"),
            "restriction": svc.get("restriction"), "verified": bool(svc.get("verified", False)),
            "in_all": svc.get("in_all", True), **stats})

        targets = [f"group-{svc.get('group', 'other')}"]
        if svc.get("in_all", True):
            targets.append("all")
        for t in targets:
            for key in acc:
                aggregates[t][key] |= acc[key]

    for name in sorted(aggregates):
        summary["aggregates"].append({"id": name, **emit(name, aggregates[name])})

    total = next((a["domains"] for a in summary["aggregates"] if a["id"] == "all"), 0)
    if total < SETTINGS.get("min_total_domains", 200):
        sys.exit(f"ОШИБКА: в списке all всего {total} доменов — источники, похоже, сломаны. Публикация отменена.")

    summary["warnings"] = WARNINGS
    write("summary.json", [json.dumps(summary, ensure_ascii=False, indent=2)])
    write_readme(summary)
    print(f"Готово: all = {total} доменов, предупреждений: {len(WARNINGS)}")


if __name__ == "__main__":
    main()
