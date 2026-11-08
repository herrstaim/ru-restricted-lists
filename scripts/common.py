"""Общие функции для скриптов сборки."""
import ipaddress
import re
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
UA = {"User-Agent": "ru-restricted-lists/1.0"}
DOMAIN_RE = re.compile(
    r"^(?=.{4,253}$)(?:[a-z0-9_](?:[a-z0-9_-]{0,61}[a-z0-9])?\.)+(?:[a-z]{2,63}|xn--[a-z0-9-]{1,59})$"
)


def load_config():
    return yaml.safe_load((ROOT / "sources" / "services.yaml").read_text(encoding="utf-8"))


class FetchError(Exception):
    pass


def fetch(url, retries=3, timeout=60, soft=False):
    """Текст страницы. 404 -> None. Прочие ошибки: soft -> None, иначе FetchError
    (сборка падает, и в release остаётся предыдущая рабочая версия)."""
    last = None
    for attempt in range(retries):
        try:
            req = urllib.request.Request(url, headers=UA)
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                return resp.read().decode("utf-8", "replace")
        except urllib.error.HTTPError as e:
            if e.code == 404:
                return None
            last = e
        except Exception as e:  # таймаут, DNS, обрыв
            last = e
        time.sleep(5 * (attempt + 1))
    if soft:
        print(f"WARN: {url}: {last}", file=sys.stderr)
        return None
    raise FetchError(f"{url}: {last}")


def norm_domain(raw):
    d = str(raw).strip().lower().rstrip(".")
    for prefix in ("*.", "+.", "."):
        if d.startswith(prefix):
            d = d[len(prefix):]
    if not d.isascii():
        try:
            d = d.encode("idna").decode("ascii")
        except UnicodeError:
            return None
    return d if DOMAIN_RE.match(d) else None


def covered(domain, suffixes):
    """True, если домен совпадает с одним из суффиксов или является его поддоменом."""
    parts = domain.split(".")
    return any(".".join(parts[i:]) in suffixes for i in range(len(parts) - 1))


def minimize(domains):
    """Убирает поддомены, уже покрытые родительским доменом из того же списка."""
    out = set()
    for d in sorted(domains, key=lambda x: (x.count("."), x)):
        if not covered(d, out):
            out.add(d)
    return sorted(out)


def split_ips(cidrs, warn=print):
    v4, v6 = [], []
    for c in cidrs:
        try:
            net = ipaddress.ip_network(str(c).strip(), strict=False)
        except ValueError:
            warn(f"некорректная подсеть {c!r}")
            continue
        min_len = 8 if net.version == 4 else 16
        if not net.is_global or net.prefixlen < min_len:
            warn(f"подсеть {net} пропущена (не публичная или слишком широкая)")
            continue
        (v4 if net.version == 4 else v6).append(net)
    return list(ipaddress.collapse_addresses(v4)), list(ipaddress.collapse_addresses(v6))
