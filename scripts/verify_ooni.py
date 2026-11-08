#!/usr/bin/env python3
"""Проверка доступности из России по данным OONI (web_connectivity за 14 дней).
OONI видит блокировки на стороне провайдеров (РКН), но НЕ геоблок со стороны самих сервисов."""
import json
import urllib.parse
from datetime import date, timedelta

from common import ROOT, fetch, load_config


def verdict(m, share):
    if m < 10:
        return "мало данных"
    if share >= 0.5:
        return "блокируется"
    if share >= 0.15:
        return "частично"
    return "доступен"


def main():
    until = date.today()
    since = until - timedelta(days=14)
    rows = []
    for svc in load_config()["services"]:
        for dom in svc.get("probe", []):
            q = urllib.parse.urlencode({"probe_cc": "RU", "test_name": "web_connectivity", "domain": dom,
                                        "since": since.isoformat(), "until": until.isoformat()})
            text = fetch(f"https://api.ooni.io/api/v1/aggregation?{q}", timeout=120, soft=True)
            try:
                res = json.loads(text)["result"] if text else {}
            except (ValueError, KeyError, TypeError):
                res = {}
            m = res.get("measurement_count", 0) - res.get("failure_count", 0)
            bad = res.get("anomaly_count", 0) + res.get("confirmed_count", 0)
            share = bad / m if m > 0 else 0
            rows.append(f"| {svc['id']} | {svc.get('restriction', '')} | {dom} | {max(m, 0)} | {share:.0%} | {verdict(m, share)} |")
    out = [f"# OONI, Россия: {since} — {until}", "",
           "Для сервисов с геоблоком (ChatGPT, Claude, Gemini) результат «доступен» — норма: OONI видит только блокировки провайдеров.",
           "", "| Сервис | Тип | Домен | Измерений | Аномалий | Вывод |", "|---|---|---|---|---|---|", *rows]
    path = ROOT / "reports" / "ooni.md"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(out) + "\n", encoding="utf-8")
    print("\n".join(out))


if __name__ == "__main__":
    main()
