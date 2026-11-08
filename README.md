# ru-restricted-lists

Автообновляемые списки доменов и IP-подсетей крупных IT- и ИИ-сервисов, недоступных из России
(блокировки РКН, геоблок со стороны сервисов, замедление). Для выборочной маршрутизации через VPN на роутере.

- Источник истины: `sources/services.yaml`
- Сборка каждые 6 часов → ветка `release`
- По понедельникам: поиск новых поддоменов (crt.sh) и проверка по OONI → pull request

## Файлы в ветке release

| Формат | Путь |
|---|---|
| Список доменов | `domains/<имя>.txt` |
| Полный перечень FQDN | `inventory/<имя>.txt` |
| IP-подсети | `ip/<имя>-v4.txt`, `ip/<имя>-v6.txt` |
| OpenWrt dnsmasq | `dnsmasq/<имя>-nftset.conf`, `dnsmasq/<имя>-ipset.conf` |
| sing-box | `sing-box/<имя>.srs`, `sing-box/<имя>.json` |
| Mihomo / Clash Meta | `mihomo/<имя>.yaml` (behavior: classical) |
| Xray / v2ray | `xray/geosite-ru-restricted.dat` (категории = имена списков) |
| MikroTik | `mikrotik/<имя>-dns.rsc`, `mikrotik/<имя>-ip.rsc` |
| Keenetic | `keenetic/<имя>-cli.txt` |

`<имя>`: `all`, `group-ai`, `group-video`, `group-social`, `group-messengers`, `group-dev`,
`group-other`, `group-foreign` или id сервиса (`openai`, `telegram`, …).

Ссылка: `https://raw.githubusercontent.com/<USER>/<REPO>/release/<путь>`
