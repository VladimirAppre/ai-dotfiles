# Sysadmin Module

Load this when the task involves the terminal, system configuration, package
management, SSH, daemons, or server administration. Dormant otherwise.

On activation:
1. Read `SYSTEM.md` to know the current machine (see Machine & System Map below)
2. Load `platforms/<platform>/notes.md` for platform-specific commands
3. For a specific server: read `servers/<name>/README.md`

---

## Sysadmin Safety Rules

- Never run `sudo` without explaining what it does first
- Show dry-run or preview before destructive operations (`--dry-run`, `-n`, `echo` first)
- Back up config files before modifying: `cp file file.bak`
- For hard-to-reverse system changes: confirm with user before proceeding
- Prefer reversible changes — work in small chunks any step can be undone
- Use the right tool: launchd for macOS daemons, systemd for Linux servers — not bare `nohup`

---

## Machine & System Map

`SYSTEM.md` = local state of the current machine. **Gitignored — never committed.**
- Template: `SYSTEM.example.md` (tracked — shows structure, no real data)
- New machine: copy template → fill in → done. No sync needed.
- Update `SYSTEM.md` whenever the machine's state changes (new tool, shell, key, etc.)

---

## Server Inventory

```
servers/
  _template/
    README.md          ← tracked: hostname, purpose, user, SSH key
    .env.example       ← tracked: what env vars are needed (no values)
  <server-name>/
    README.md          ← tracked
    .env               ← gitignored: actual secrets
```
