# PROMPT-PLUGINS.md — install the Directory plugins as skills

Paste into Claude Code (or a Cowork session with shell access).

---

Install these 12 plugins from the Claude Directory as personal skills on this machine.

**Steps**

1. Clone the hub:

```bash
git clone https://github.com/riuxin/Claude-editing-skills.git
cd Claude-editing-skills
```

2. Dry run the list and show me the result before writing anything:

```bash
bash scripts/install.sh --file repos-plugins.txt
```

3. Install it:

```bash
bash scripts/install.sh --install --file repos-plugins.txt
```

4. Verify every folder you created has a `SKILL.md`, and that each contains a `.cc-source` file naming its repo:

```bash
for d in ~/.claude/skills/*/; do
  [ -f "$d/SKILL.md" ] || echo "NO SKILL.md: $d"
done
```

5. Report a table: skill folder | source repo | installed or skipped | needs an API key / local app.

**Rules**

- `repos-plugins.txt` contains: remotion-skills-marketplace, framecraft, VideoZero, Golpo, claude-video-vision, watch-video, claude-transcribe, VoxFlow, muapi-marketing-video, upload-post, adaptlypost, post-bridge. `eversince-ai/plugin` is listed in the Directory but its repo returns 404 — skip it and say so.
- These are **ungraded third-party repos**. Do not run any script they ship; the installer only copies `SKILL.md` folders.
- The installer is idempotent and never overwrites: existing folders are skipped, and a name collision from a different repo installs as `<name>--<owner>-<repo>`.
- If the user wants the plugin instead of a skill (namespaced command, bundled MCP servers), use:

```bash
claude plugin marketplace add <owner>/<repo>
claude plugin install <plugin>@<marketplace>
```

  Never install both routes for the same tool.
- Windows: use Git Bash. `git clone` into `/tmp` silently produces nothing there — the installer already clones to `C:/Users/<user>/AppData/Local/Temp`. `bash scripts/install.sh --print-paths` shows the path it chose.
- Afterwards the user must run `/skills` and `/skill-doctor` themselves; those are session commands.

**Why the extra depth matters:** these repos are marketplaces, so their skills sit at `plugins/<name>/skills/<skill>/SKILL.md` — five levels down. An installer capped at four levels finds nothing. This one searches six and skips `.claude/`, `evals/`, `examples/`, `tests/`, `demos/`, `docs/` so it never grabs a maintainer's internal workflow skills.
