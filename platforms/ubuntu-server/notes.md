# Ubuntu Server Platform Notes

> Common patterns for Ubuntu Server administration.
> For each new server: copy `servers/_template/` → `servers/<name>/`, fill in `README.md` (tracked) and create `.env` with real credentials (gitignored).

---

## Initial Server Setup Checklist

```bash
# 1. Update system
sudo apt update && sudo apt upgrade -y

# 2. Create non-root user with sudo
sudo adduser deploy
sudo usermod -aG sudo deploy

# 3. Copy SSH key to new user
sudo mkdir -p /home/deploy/.ssh
sudo cp ~/.ssh/authorized_keys /home/deploy/.ssh/
sudo chown -R deploy:deploy /home/deploy/.ssh
sudo chmod 700 /home/deploy/.ssh
sudo chmod 600 /home/deploy/.ssh/authorized_keys

# 4. Configure SSH (disable password auth)
sudo nano /etc/ssh/sshd_config
# Set: PasswordAuthentication no
# Set: PermitRootLogin no
sudo systemctl reload ssh

# 5. Configure firewall
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

---

## SSH Access

```bash
# Connect
ssh user@server-ip
ssh -i ~/.ssh/id_rsa_auth user@server

# Use host alias from ~/.ssh/config
ssh myserver

# Copy file to server
scp localfile user@server:/remote/path/
rsync -avz ./local/ user@server:/remote/

# Tunnel local port to remote
ssh -L 8080:localhost:3000 user@server   # Local :8080 → server :3000

# Keep alive
# In ~/.ssh/config:
# ServerAliveInterval 60
# ServerAliveCountMax 3
```

---

## Firewall (ufw)

```bash
sudo ufw status verbose
sudo ufw allow 22/tcp
sudo ufw allow 80,443/tcp
sudo ufw deny from <bad-ip>
sudo ufw delete allow 8080/tcp

# Rate limiting (protect SSH from brute force)
sudo ufw limit 22/tcp
```

---

## Services (systemd)

```bash
sudo systemctl status nginx
sudo systemctl restart nginx
sudo systemctl reload nginx              # Reload config (no downtime)
journalctl -u nginx -f                   # Follow logs

# Enable on boot
sudo systemctl enable nginx
```

---

## Nginx

```bash
# Install
sudo apt install nginx

# Config locations
/etc/nginx/nginx.conf                    # Main config
/etc/nginx/sites-available/             # Available site configs
/etc/nginx/sites-enabled/               # Active (symlinks to above)

# Add new site
sudo nano /etc/nginx/sites-available/mysite
sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/

# Test config & reload
sudo nginx -t
sudo systemctl reload nginx

# Logs
/var/log/nginx/access.log
/var/log/nginx/error.log
tail -f /var/log/nginx/error.log
```

### Minimal nginx config
```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## Certificates (Let's Encrypt / Certbot)

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d example.com
sudo certbot renew --dry-run             # Test auto-renewal
```

---

## Process Management

```bash
# Find process on port
sudo lsof -i :80
sudo ss -tulpn | grep :80

# Kill process
kill -9 <PID>
pkill -f "process-name"

# For persistent processes: use a systemd service unit (see Services section above)
# For one-off temporary background tasks only:
nohup ./script.sh &
# Or use tmux / screen

# Check resource usage
htop                                     # Interactive (apt install htop)
top
free -h                                  # Memory
df -h                                    # Disk
```

---

## Cron Jobs

```bash
# Edit user crontab
crontab -e

# System cron
sudo nano /etc/cron.d/myjob

# Format: min hour day month weekday command
0 2 * * * /home/deploy/backup.sh       # Every day at 2am
*/5 * * * * /home/deploy/check.sh      # Every 5 minutes

# View logs
grep CRON /var/log/syslog
```

---

## Logs

```bash
# System logs
journalctl -f                            # Follow all logs
journalctl -u <service> -f               # Service logs
journalctl --since "2 hours ago"
journalctl -p err                        # Errors only

# Traditional logs
tail -f /var/log/syslog
tail -f /var/log/auth.log               # SSH/auth activity
```

---

## Security Basics

```bash
# Check failed SSH login attempts
sudo grep "Failed password" /var/log/auth.log | tail -20

# Check who is logged in
who
w
last                                     # Login history

# Check open ports
sudo ss -tulpn
sudo netstat -tulpn

# Check sudo usage
sudo grep sudo /var/log/auth.log | tail -20

# Automatic security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
```

---

## Important Server Paths

| Path | Purpose |
|------|---------|
| `/etc/ssh/sshd_config` | SSH server config |
| `/etc/nginx/` | Nginx config |
| `/etc/systemd/system/` | System service units |
| `/var/log/` | System and app logs |
| `/var/www/` | Web root (convention) |
| `/etc/cron.d/` | System cron jobs |
| `/etc/hosts` | Local hostname resolution |
| `/etc/fstab` | Mount points |
| `/home/deploy/` | Deployment user home |
| `/tmp/` | Temp files (cleared on reboot) |
