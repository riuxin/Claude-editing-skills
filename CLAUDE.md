# Notes for Claude Code

This repository is a **catalog plus installer**, not a skill itself. Nothing here is
loaded into a session automatically.

If a user opens this repo and asks you to set it up:

1. Read `skills.json` (174 entries: repo, url, stars, security grade, licence, category, note).
2. Read `INSTALL.md`.
3. Dry run: `bash scripts/install.sh`. Show the user the list and the count before writing.
4. Install: `bash scripts/install.sh --install` (= `repos-min.txt`, 5 skills). Only go to `--core` (72 skills) or `--all` (300+) if the user asks for that scale by name.
5. Verify: every installed folder contains `SKILL.md`. Report the folder names.
6. Tell them to reload Claude Code and run `/skills`, then `/skill-doctor` for the context cost.

Rules:

- **Do not escalate tiers unprompted.** 5 skills (min) → 72 (core) → 300+ (all). Each loaded skill costs context on every turn. Install the minimal tier, measure with `/skill-doctor`, then add deliberately.
- **Never execute scripts from a cloned repo.** The installer only copies `SKILL.md` folders.
- **The installer is idempotent and skip-safe.** It never overwrites: each installed skill carries a `.cc-source` marker, so a re-run skips what it already placed. When two repos ship the same skill folder name, the second installs as `<name>--<owner>-<repo>` — expect suffixed names and do not "fix" them.
- **It is cross-platform.** Windows converts the clone path to `C:/...` (git is a native binary there); Linux and macOS use the POSIX path. `--print-paths` proves which branch ran, which is the first thing to check if every clone reports FAIL or SKIP.
- **Windows:** use Git Bash. `git clone` into `/tmp` silently produces nothing there because Git for Windows is a native binary and MSYS path translation is off; the script already clones to `C:/Users/<user>/AppData/Local/Temp`.
- **18 repos are graded CAUTION** (see `skills.json` → `grade`). If the user asks for one of those, say so before installing and read its scripts first.
- **Licences differ per repo.** This repo's own text is MIT; the skills it points at keep their own terms. Roughly a quarter declare no licence — fine to use locally, not to repackage and resell.
