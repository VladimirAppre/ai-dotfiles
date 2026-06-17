# Architecture Decisions

> Log non-obvious decisions here: what was decided, why, and what alternatives were rejected.
> Format: Date | Decision | Why | Alternatives considered

---

| Date | Decision | Why | Alternatives |
|------|----------|-----|--------------|
| 2026-06-17 | Local is macOS-only; Linux kept only for remote server admin | Local machine is always a Mac — Ubuntu Desktop support was dead weight. Servers are still Linux, so `platforms/ubuntu-server` + `servers/` stay | Keep full cross-platform local support (rejected: unused, adds noise to every doc) |
| 2026-06-17 | [Karpathy's 4 engineering principles](https://github.com/multica-ai/andrej-karpathy-skills/) folded into CLAUDE.md | Universal good-behavior rules (think first, simplicity, surgical, goal-driven) that the workflow now references instead of duplicating | Keep them in a separate repo/file (rejected: split source, drift, extra file to load) |
| 2026-06-17 | No global ~/.claude rule injection — project is opened directly | terminal-setup is a standalone toolbox entered when needed, not rules bound to other projects | Symlink dotfiles → ~/.claude/CLAUDE.md (rejected by user: don't bind to other projects) / Claude Code plugin (overkill for personal setup) |
| 2026-06-17 | Split into reusable core + on-demand sysadmin module | Core (principles, 3-phase workflow, tasks/checkpoints) is universal and could travel to any project; sysadmin rules (SYSTEM.md, servers, safety) stay dormant in `modules/sysadmin.md` until terminal/server work — no dead weight in code projects. 3-phase protocol stays in core (user: needed in general, not only sysadmin). Self-Verification folded into principle #3 (it was its operationalization). | Keep everything in one CLAUDE.md (rejected: sysadmin noise always loaded) / sysadmin as a Skill (deferred: plain module file is simpler, works in Claude + Cursor) |
| 2026-05-25 | CLAUDE.md as canonical rule source; sync script for Cursor | One file to edit; script propagates changes to `.cursor/rules/main.mdc` automatically | Maintain both files manually (drift risk) / symlinks (git-unfriendly) |
| 2026-05-25 | SYSTEM.md for environment state | AI reads it at session start — no re-discovery needed, saves tokens and time | Let AI explore system each time (slow, inconsistent, error-prone) |
| 2026-05-25 | English for docs/rules, Russian for conversation | English works across all LLMs and machines; Russian is user preference for chat | All Russian (breaks compatibility with non-Russian LLMs) |
| 2026-05-25 | Memory files stored in `~/.claude/projects/.../memory/` (not in git) | Memory is machine-local and can contain sensitive context; not for sharing | In git (creates privacy/security risk; different machines have different state) |
| 2026-05-25 | 4-phase workflow protocol for complex tasks | User explicitly requires: analysis → confirm → re-analysis → confirm → implement | Jumping straight to implementation (rejected: user has had bad experiences with unconfirmed changes) |
| 2026-05-25 | SYSTEM.md gitignored (local only), no machines/ hierarchy | Each machine only knows itself; no cross-machine data sharing; simpler flat structure | machines/<hostname>/system.md per machine in git (rejected: unnecessary coupling, mild privacy concern) |
