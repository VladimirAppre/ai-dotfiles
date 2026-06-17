# Memory File Template

Use this to create memory files in `~/.claude/projects/.../memory/`.
Memory files are local to each machine — not tracked in git.

---

## How to create a new memory file

1. Copy the frontmatter block below
2. Save as `~/.claude/projects/.../memory/<slug>.md`
3. Add a pointer in `MEMORY.md`: `- [Title](file.md) — one-line description`

---

## Frontmatter template

```
---
name: short-kebab-case-slug
description: One-line summary (used to decide relevance in future sessions)
metadata:
  type: user | feedback | project | reference
---
```

---

## Body structure by type

### `user` — who the user is
```
Role, preferences, technical background, communication style.
What to tailor: explanation depth, assumed knowledge, response format.
```

### `feedback` — guidance on approach
```
[The rule or correction]

**Why:** reason the user gave or incident that caused it
**How to apply:** when/where this guidance kicks in
```

### `project` — context about work in progress
```
[Fact or decision]

**Why:** motivation, constraint, or deadline
**How to apply:** how this shapes your suggestions
```

### `reference` — where to find things
```
[What it is and where]

Used when: [context in which to look this up]
```

---

## Linking memories
Use `[[other-slug]]` to link related memories. It's fine if the target doesn't exist yet.

---

## Memory index (MEMORY.md)
Each entry is one line under 150 chars:
```
- [Title](filename.md) — one-line hook describing what's inside
```
