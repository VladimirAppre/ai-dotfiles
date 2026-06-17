# macOS Platform Notes

> Common patterns for macOS system configuration.
> See `SYSTEM.md` for what's currently installed on this machine.

---

## System Preferences: defaults write

```bash
# Read all prefs for an app
defaults read com.apple.finder

# Read specific key
defaults read com.apple.dock autohide

# Write preference
defaults write com.apple.finder ShowHiddenFiles -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36

# Delete preference (reset to default)
defaults delete com.apple.finder ShowHiddenFiles

# Apply changes — restart the process
killall Finder
killall Dock
killall SystemUIServer
```

### Common defaults
| Command | Effect |
|---------|--------|
| `defaults write com.apple.finder ShowHiddenFiles -bool true` | Show hidden files |
| `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false` | Key repeat (for vim) |
| `defaults write com.apple.dock autohide -bool true` | Auto-hide dock |
| `defaults write com.apple.screencapture location ~/Desktop/Screenshots` | Screenshot folder |

---

## LaunchAgents & LaunchDaemons

| Path | Runs as | Use for |
|------|---------|---------|
| `~/Library/LaunchAgents/` | current user | User-level scheduled tasks |
| `/Library/LaunchAgents/` | current user (all users) | System-wide user agents |
| `/Library/LaunchDaemons/` | root | System services |

```bash
# Load/unload
launchctl load ~/Library/LaunchAgents/com.example.plist
launchctl unload ~/Library/LaunchAgents/com.example.plist

# Bootstrap (modern API, macOS 10.11+)
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.example.plist
launchctl bootout gui/$(id -u)/com.example

# Check status
launchctl list | grep example
launchctl print gui/$(id -u)/com.example

# Debug: view logs
log stream --predicate 'subsystem == "com.example"'
```

### Minimal plist template
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.myjob</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/bin/script.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>3600</integer>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```

---

## Shell Management

```bash
# List available shells
cat /etc/shells

# Change default shell
chsh -s /usr/local/bin/fish      # Switch to fish
chsh -s /bin/zsh                 # Switch back to zsh

# Current shell
echo $SHELL
```

---

## File Permissions

```bash
# SSH key permissions (required)
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/id_rsa_*        # Private keys
chmod 644 ~/.ssh/*.pub           # Public keys
chmod 600 ~/.ssh/config

# Make script executable
chmod +x script.sh

# Recursive permission fix
chmod -R 755 /path/to/directory
chown -R $(whoami) /path/to/directory
```

---

## SSH on macOS

```bash
# Add key to macOS Keychain (persists across reboots)
ssh-add --apple-use-keychain ~/.ssh/id_rsa_auth

# List loaded keys
ssh-add -l

# Test connection
ssh -T git@github.com
ssh -i ~/.ssh/VladimirAppre -T git@github.com

# SSH config: use host alias
ssh github.com-personal
```

---

## Process & System Info

```bash
# Find process using a port
lsof -i :3000
lsof -i :8080 | grep LISTEN

# Kill process on port
kill -9 $(lsof -t -i :3000)

# System info
system_profiler SPHardwareDataType    # Hardware details
sw_vers                               # macOS version
uname -m                              # Chip: arm64 or x86_64

# Disk usage
df -h
du -sh ~/Library/
```

---

## Important macOS Paths

| Path | Purpose |
|------|---------|
| `~/.zshrc` | Zsh config (loaded for interactive shells) |
| `~/.zprofile` | Zsh profile (loaded for login shells) |
| `~/.config/fish/config.fish` | Fish config |
| `~/.config/fish/functions/` | Fish functions |
| `~/Library/LaunchAgents/` | User-level services |
| `/Library/LaunchDaemons/` | System-level services |
| `~/Library/Preferences/` | App preferences (plist) |
| `~/Library/Application Support/` | App data |
| `~/Library/Logs/` | App logs |
| `/var/log/` | System logs |
