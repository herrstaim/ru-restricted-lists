#!/usr/bin/env python3
"""Поиск поддоменов через Certificate Transparency (crt.sh) по шаблонам из поля ct.
reports/inventory/<id>.txt  — все найденные хосты;
reports/candidates/<id>.txt — хосты, не покрытые доменами сервиса (проверить и добавить вручную)."""
import json
import time
import urllib.parse

from common import ROOT, covered, fetch, load_config, norm_domain

REPORTS = ROOT / "reports"


def crtsh(pattern):
    url = f"https://crt.sh/?q={urllib.parse.quote(pattern)}&output=json&exclude=expired"
    text = fetch(url, retries=3, timeout=180, soft=True)
    try:
        rows = json.loads(text) if text else []
    except ValueError:
        print(f"WARN: crt.sh вернул не JSON для {pattern}")
        return set()
    names = set()
    for row in rows:
        for name in row.get("name_value", "").splitlines():
            if "*" in name:
                continue
            d = norm_domain(name)
            if d:
                names.add(d)
    return names


def main():
    for svc in load_config()["services"]:
        patterns = svc.get("ct") or []
        if not patterns:
            continue
        known = {norm_domain(d) for d in svc.get("domains", [])}
        found = set()
        for p in patterns:
            found |= crtsh(p)
            time.sleep(5)
        if not found:
            print(f"{svc['id']}: crt.sh ничего не вернул, отчёт не обновляю")
            continue
        new = sorted(d for d in found if not covered(d, known))
        for sub, data in (("inventory", sorted(found)), ("candidates", new)):
            path = REPORTS / sub / f"{svc['id']}.txt"
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("\n".join(data) + ("\n" if data else ""), encoding="utf-8")
        print(f"{svc['id']}: найдено {len(found)}, новых кандидатов {len(new)}")


if __name__ == "__main__":
    main()
