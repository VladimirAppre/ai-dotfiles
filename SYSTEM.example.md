# System Map — <HOSTNAME>

> LOCAL FILE — gitignored. Never commit SYSTEM.md.
> On a new machine: copy this to SYSTEM.md, fill in real values.

**platform:** macOS
**hostname:** <HOSTNAME>

---

## Machine Info

```bash
sw_vers              # macOS version
uname -m             # Chip: arm64 / x86_64
whoami
echo $HOME
```

| | |
|---|---|
| OS | |
| Chip | |
| Username | |
| Home | |

---

## Shell

```bash
echo $SHELL
zsh --version 2>/dev/null
fish --version 2>/dev/null
```

| Shell | Version | Binary | Config |
|-------|---------|--------|--------|
| | | | |

**Default login shell:**

---

## Package Manager

| | |
|---|---|
| Manager | |
| Version | |
| Location | |

---

## Node.js / Version Manager

```bash
nvm --version 2>/dev/null || echo "no nvm"
node --version 2>/dev/null
npm --version 2>/dev/null
nvm list 2>/dev/null
```

| | |
|---|---|
| Version manager | nvm / none |
| Active Node | |
| npm | |
| Installed versions | |

---

## Key Languages / Runtimes

```bash
python3 --version 2>/dev/null
go version 2>/dev/null
java -version 2>/dev/null
```

| Language | Version | Installed via |
|----------|---------|--------------|
| | | |

---

## SSH Keys

```bash
ls -la ~/.ssh/
cat ~/.ssh/config
```

| Key file | Identity | Target |
|----------|----------|--------|
| | | |

---

## Git (Global Config)

```bash
git config --global --list
```

| | |
|---|---|
| user.name | |
| user.email | |
| credential.helper | |

---

## Installed CLI Tools

```bash
for t in git vim nvim tmux fish zsh code cursor gh; do which $t 2>/dev/null; done
```

| Tool | Location | Notes |
|------|----------|-------|
| | | |

---

## PATH

```bash
echo $PATH | tr ':' '\n'
```

```
(paste here)
```

---

## Notes / Quirks

Corporate proxy, VPN, special mounts, anything non-standard.
