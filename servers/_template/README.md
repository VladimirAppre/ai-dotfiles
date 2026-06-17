# Server: <server-name>

> Rename this folder to the server's name/alias (e.g. `prod-api`, `staging`, `dev-1`).
> README.md is tracked in git — never put secrets here.
> Secrets go in `.env` (gitignored) — see `.env.example` for required variables.

---

## Identity

| | |
|---|---|
| Name / alias | |
| Hostname / IP | (use alias from `~/.ssh/config`, not bare IP) |
| Provider | (Hetzner / DigitalOcean / bare metal / etc.) |
| Region | |
| Purpose | (e.g. production API, staging, monitoring) |

---

## Access

| | |
|---|---|
| SSH user | |
| SSH key | `~/.ssh/<key-name>` |
| SSH alias | (entry in `~/.ssh/config`) |
| Sudo | yes / no |

**Connect:**
```bash
ssh <alias-from-ssh-config>
```

---

## Stack

| Component | Version | Managed by |
|-----------|---------|------------|
| OS | Ubuntu XX.XX | |
| Web server | nginx / caddy / none | systemd |
| Runtime | Node vXX / Python / etc. | |
| Database | | systemd |
| Process manager | systemd / pm2 / none | |

---

## Key Paths

| Purpose | Path |
|---------|------|
| App root | |
| Nginx config | `/etc/nginx/sites-available/<name>` |
| Logs | |
| Env file | (gitignored — see `.env.example`) |

---

## Firewall Rules

```bash
sudo ufw status verbose
```

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |

---

## Maintenance

**Update system:**
```bash
sudo apt update && sudo apt upgrade -y
```

**Check services:**
```bash
systemctl list-units --type=service --state=running
```

**Check logs:**
```bash
journalctl -f
journalctl -u <service> --since "1 hour ago"
```

---

## Notes

Any quirks, known issues, or important context about this server.
