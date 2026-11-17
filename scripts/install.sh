#!/usr/bin/env bash
# install.sh — install Claude Code video/content skills listed in this repo.
#
#   bash scripts/install.sh                      # dry run against repos-min.txt (5 skills)
#   bash scripts/install.sh --install            # install repos-min.txt
#   bash scripts/install.sh --install --core     # repos-core.txt (72 skills — real context cost)
#   bash scripts/install.sh --install --all      # repos.txt (the full stack, 300+ skills)
#   bash scripts/install.sh --install remotion-dev/skills bangtutorial/bang-motion
#   bash scripts/install.sh --rename-conflicts   # keep both copies when two repos ship the
#                                                # same skill name (e.g. edit-video)
#   bash scripts/install.sh --print-paths        # show platform + clone paths and exit
#   CLAUDE_SKILLS_DIR=/somewhere bash scripts/install.sh --install
#
# Works on Windows (Git Bash), macOS and Linux. On Windows the clone path is
# converted to C:/... because git is a native binary; elsewhere it is the POSIX path.
#
# Target: ~/.claude/skills/<skill-name>/SKILL.md  (personal skills: every project)
#
# What counts as a "skill", in order:
#   1. root SKILL.md      -> the whole repo is the skill; copy the repo
#   2. skills/*/SKILL.md  -> copy each child folder
#   3. any other SKILL.md -> copy its folder, skipping .claude/ evals/ examples/
#                            tests/ demos/ docs/ node_modules/
# Repos shipping .claude-plugin/marketplace.json also work via /plugin marketplace add.
#
# Design notes:
#  - Copies real directories, not symlinks, so skills stay Claude-Code-only.
#  - Skips anything already present: re-running is safe.
#  - Never executes repo scripts. It copies SKILL.md folders; you still read a skill
#    before invoking it. Everything here is MIT/Apache or no-licence-but-public —
#    check a repo's licence before redistributing what it produces.
#  - Windows/MSYS: git is a native Windows binary here, so /tmp is not a valid clone
#    target (it silently produces nothing). Clones go to a C:/ path instead.

set -u

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$HERE")"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
MODE="dry"
RENAME_CONFLICTS="0"
LIST="$ROOT/repos-min.txt"

for a in "$@"; do
  case "$a" in
    --install) MODE="install" ;;
    --dry)     MODE="dry" ;;
    --min)     LIST="$ROOT/repos-min.txt" ;;
    --core)    LIST="$ROOT/repos-core.txt" ;;
    --all)     LIST="$ROOT/repos.txt" ;;
    --rename-conflicts) RENAME_CONFLICTS="1" ;;
    --file)    LIST="" ;;   # consumed below
    -h|--help) sed -n '2,25p' "$0"; exit 0 ;;
  esac
done

# optional: --file <path>
prev=""
for a in "$@"; do
  if [ "$prev" = "--file" ]; then LIST="$a"; fi
  prev="$a"
done

WORK_MSYS="${SKILL_HUB_TMP:-$HOME/AppData/Local/Temp/cc-skill-clone}"
# Git for Windows is a native binary: it cannot write to an MSYS path like /c/... or /tmp.
# Everywhere else the POSIX path IS the real path, so both must be identical.
# CC_PLATFORM=posix|windows forces a branch (used to test the Linux path from Windows).
PLATFORM="${CC_PLATFORM:-auto}"
if [ "$PLATFORM" = "auto" ]; then
  case "$(uname -s 2>/dev/null)" in
    MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
    *)                    PLATFORM="posix" ;;
  esac
fi
if [ "$PLATFORM" = "windows" ] && command -v cygpath >/dev/null 2>&1; then
  WORK_WIN="$(cygpath -m "$WORK_MSYS")"
else
  WORK_WIN="$WORK_MSYS"
fi

if [ "${1:-}" = "--print-paths" ]; then
  echo "platform:  $PLATFORM"
  echo "WORK_MSYS: $WORK_MSYS"
  echo "WORK_WIN:  $WORK_WIN"
  echo "target:    $DEST"
  exit 0
fi

mkdir -p "$WORK_MSYS" && rm -rf "${WORK_MSYS:?}"/* 2>/dev/null

# explicit repos on the command line override the list file
REPOS=()
for a in "$@"; do
  case "$a" in --*) continue ;; esac
  a="${a%$'\r'}"
  [ "$a" = "$LIST" ] && continue
  if [[ "$a" == */* ]]; then REPOS+=("$a"); fi
done
if [ ${#REPOS[@]} -eq 0 ]; then
  [ -f "$LIST" ] || { echo "list not found: $LIST"; exit 1; }
  while IFS= read -r l; do
    l="${l%$'\r'}"
    case "$l" in ''|\#*) continue ;; esac
    REPOS+=("$l")
  done < "$LIST"
fi

echo "mode:   $MODE"
echo "list:   $(basename "$LIST" 2>/dev/null) (${#REPOS[@]} repos)"
echo "target: $DEST"
echo "clone:  $WORK_WIN  ($PLATFORM)"
echo

mkdir -p "$DEST"
installed=0; skipped=0; failed=0

place() {  # place <src_dir> <skill_name> <repo>
  local sdir="$1" sname="$2" repo="$3" origin alt
  if [ -e "$DEST/$sname" ]; then
    origin="$(cat "$DEST/$sname/.cc-source" 2>/dev/null || true)"
    if [ "$origin" = "$repo" ]; then
      echo "EXISTS   $sname (already installed from $repo)"
      skipped=$((skipped+1)); return
    fi
    # Same skill name from a different source: never overwrite, never drop.
    if [ -n "$origin" ] || [ "$RENAME_CONFLICTS" = "1" ]; then
      alt="$sname--$(echo "$repo" | tr '/' '-' | tr 'A-Z' 'a-z')"
      if [ -e "$DEST/$alt" ]; then
        echo "EXISTS   $alt"; skipped=$((skipped+1)); return
      fi
      echo "RENAME   $sname <- $repo  as  $alt  (name taken${origin:+ by $origin})"
      sname="$alt"
    else
      echo "EXISTS   $sname (installed before .cc-source markers existed; use --rename-conflicts to keep both)"
      skipped=$((skipped+1)); return
    fi
  fi
  if [ "$MODE" = "install" ]; then
    cp -r "$sdir" "$DEST/$sname" && rm -rf "$DEST/$sname/.git"
    if [ -f "$DEST/$sname/SKILL.md" ]; then
      printf '%s\n' "$repo" > "$DEST/$sname/.cc-source"
      echo "OK       $sname  <- $repo"; installed=$((installed+1))
    else
      echo "FAIL     $sname (no SKILL.md after copy)"; failed=$((failed+1))
    fi
  else
    echo "WOULD    $sname  <- $repo"; installed=$((installed+1))
  fi
}

for repo in "${REPOS[@]}"; do
  name="${repo##*/}"
  src="$WORK_MSYS/$name"
  if ! git clone --depth 1 --quiet "https://github.com/$repo.git" "$WORK_WIN/$name" 2>/dev/null; then
    echo "FAIL     $repo (clone failed — moved, renamed or private)"; failed=$((failed+1)); continue
  fi

  [ -f "$src/.claude-plugin/marketplace.json" ] && \
    echo "NOTE     $repo ships a plugin marketplace — /plugin marketplace add $repo works too"

  if [ -f "$src/SKILL.md" ]; then
    place "$src" "$(echo "$name" | tr 'A-Z' 'a-z')" "$repo"; continue
  fi

  if compgen -G "$src/skills/*/SKILL.md" > /dev/null; then
    for f in "$src"/skills/*/SKILL.md; do
      place "$(dirname "$f")" "$(basename "$(dirname "$f")" | tr 'A-Z' 'a-z')" "$repo"
    done
    continue
  fi

  found=0
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    found=1
    place "$(dirname "$f")" "$(basename "$(dirname "$f")" | tr 'A-Z' 'a-z' | tr -c 'a-z0-9._-' '-' | sed 's/-\+$//')" "$repo"
  done < <(find "$src" -maxdepth 6 -name SKILL.md \
             -not -path "*/.git/*" -not -path "*/node_modules/*" \
             -not -path "*/.claude/*" -not -path "*/evals/*" \
             -not -path "*/examples/*" -not -path "*/tests/*" \
             -not -path "*/demos/*" -not -path "*/docs/*" | sort)

  if [ "$found" = 0 ]; then
    echo "SKIP     $repo (no SKILL.md — an MCP server or app; wire it with claude mcp add)"
    skipped=$((skipped+1))
  fi
done

echo
echo "---- $MODE: $installed $([ "$MODE" = install ] && echo installed || echo would-install), $skipped skipped, $failed failed"
if [ "$MODE" = "dry" ]; then
  echo "Nothing written. Re-run with --install."
else
  echo "Next: open Claude Code, run /skills, then /skill-doctor for the per-turn context cost."
fi
