# INSTALL

Three ways in. Pick the one that matches who is doing the installing.

---

## 1. Claude installs them (recommended)

Paste this into Claude Code:

```text
Clone https://github.com/riuxin/Claude-editing-skills.git to a temp dir, cd into it, then:

1. Read skills.json.
2. Run: bash scripts/install.sh            (dry run — show me the list)
3. Then: bash scripts/install.sh --install
4. Verify every entry now has a SKILL.md under ~/.claude/skills.
5. Report: what installed, what was skipped, what needs an API key, and the total
   context cost from /skill-doctor.

Do not install repos.txt --all in the same pass. Starter stack only.
```

Claude needs: `git`, `bash`. Works on Linux, macOS and Windows (Git Bash).

The script picks the clone path by platform: on Windows it converts to a `C:/...` path
because Git for Windows is a native binary and cannot write to `/tmp` or `/c/...`; on
Linux and macOS the POSIX path is used as-is. `bash scripts/install.sh --print-paths`
shows which one it chose before anything is cloned.

---

## 2. You install them by hand

```bash
git clone https://github.com/riuxin/Claude-editing-skills.git
cd Claude-editing-skills

bash scripts/install.sh                  # dry run: prints every skill that would land
bash scripts/install.sh --install        # minimal tier — 5 skills
bash scripts/install.sh --install --core # core tier — 74 skills (measure with /skill-doctor)
bash scripts/install.sh --install --all  # everything (300+ skills — see the warning)
bash scripts/install.sh --install remotion-dev/skills bangtutorial/bang-motion
```

Custom target:

```bash
CLAUDE_SKILLS_DIR=~/work/skills bash scripts/install.sh --install
```

**Name collisions.** Several repos ship a skill with the same folder name (`edit-video`,
`captions`, the `hyperframes*` family). The installer keeps the first and installs the
later one as `<name>--<owner>-<repo>`, so nothing is silently lost. `--rename-conflicts`
does the same for folders that predate this behaviour. Every skill folder gets a
`.cc-source` marker recording which repo it came from, which is what makes re-runs safe.

What the script does, exactly:

1. `git clone --depth 1` each repo into `~/AppData/Local/Temp/cc-skill-clone` (or `/tmp` on Linux/macOS).
2. Decide what the skill is: a root `SKILL.md` means the whole repo is one skill; a `skills/*/SKILL.md` layout means each child folder is a skill; otherwise any `SKILL.md` not under `.claude/`, `evals/`, `examples/`, `tests/`, `demos/` or `docs/`.
3. Copy the folder into `~/.claude/skills/<name>/` as a real directory and refuse if that name already exists.
4. Never execute anything from the repo.

---

## 3. Plugin marketplaces (where the repo supports it)

Some repos ship `.claude-plugin/marketplace.json`. The installer prints a `NOTE` line for those; you can also do it natively:

```text
/plugin marketplace add <owner>/<repo>
/plugin install <plugin-name>@<marketplace-name>
/reload-plugins
```

Plugin skills are namespaced (`/plugin-name:skill-name`) and can ship agents, hooks and MCP servers. A personal skill cannot.

---

## Where skills live in Claude Code

| Type | Path | Scope |
|---|---|---|
| Personal | `~/.claude/skills/<name>/SKILL.md` | every project on this machine |
| Project | `<repo>/.claude/skills/<name>/SKILL.md` | that repo, commits with it |
| Plugin | managed by `/plugin` | wherever the plugin is enabled |

Commands inside a session: `/skills` (what's loaded), `/skill-doctor` (per-turn context cost and firing rate), `/reload-plugins` (after hooks or MCP changes).

---

## Backing out

```bash
ls ~/.claude/skills                 # see what you added
rm -rf ~/.claude/skills/<name>      # remove one
rm -rf ~/.claude/skills/<name> ~/.claude/skills/<other>   # remove several
```

Claude Code watches the directory: a removal takes effect in the running session without a restart. Anything installed by `/plugin` is removed with `/plugin uninstall <name>@<marketplace>`.

---

## Requirements per skill

Almost all of these need only:

| Tool | Check |
|---|---|
| ffmpeg | `ffmpeg -version` |
| node + npm | `node --version` |
| python 3.10+ | `python --version` |
| git | `git --version` |

These need credentials you supply yourself:

| Skills | What you need |
|---|---|
| HeyGen (`heygen-com/skills`, `AgriciDaniel/lipnardo`) | HeyGen API key |
| Higgsfield (`AKCodez/higgsfield-claude-skills`, `Samin12/thumbnail-engine`) | Higgsfield account |
| ElevenLabs / Seedance / Kling / MiniMax | Vendor API key |
| DaVinci Resolve (`lordhoell/davinci-resolve-mcp`) | Resolve Studio installed + its scripting API enabled |
| Premiere / After Effects | Adobe app installed + ExtendScript/MCP bridge |

---

## The one rule

Every loaded skill adds to the context of every turn whether or not it fires. Start with `repos-core.txt`, run `/skill-doctor`, and add from `repos.txt` deliberately — not all at once.
