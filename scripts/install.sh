#!/usr/bin/env bash
# install.sh — install Claude Code video/content skills listed in this repo.
#
#   bash scripts/install.sh                      # dry run against repos-core.txt
#   bash scripts/install.sh --install            # install repos-core.txt
#   bash scripts/install.sh --install --all      # install repos.txt (the full stack)
#   bash scripts/install.sh --install remotion-dev/skills bangtutorial/bang-motion
#   CLAUDE_SKILLS_DIR=/somewhere bash scripts/install.sh --install
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
LIST="$ROOT/repos-core.txt"

for a in "$@"; do
  case "$a" in
    --install) MODE="install" ;;
    --dry)     MODE="dry" ;;
    --all)     LIST="$ROOT/repos.txt" ;;
    --file)    LIST="" ;;   # consumed below
    -h|--help) sed -n '2,24p' "$0"; exit 0 ;;
  esac
done

# optional: --file <path>
prev=""
for a in "$@"; do
  if [ "$prev" = "--file" ]; then LIST="$a"; fi
  prev="$a"
done

WORK_MSYS="$HOME/AppData/Local/Temp/cc-skill-clone"
WORK_WIN="$(cygpath -m "$HOME" 2>/dev/null || echo "C:/Users/$(whoami)")/AppData/Local/Temp/cc-skill-clone"
mkdir -p "$WORK_MSYS"; rm -rf "$WORK_MSYS"/* 2>/dev/null

# explicit repos on the command line override the list file
REPOS=()
for a in "$@"; do
  case "$a" in --*) continue ;; esac
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
echo

mkdir -p "$DEST"
installed=0; skipped=0; failed=0

place() {  # place <src_dir> <skill_name> <repo>
  local sdir="$1" sname="$2" repo="$3"
  if [ -e "$DEST/$sname" ]; then
    echo "EXISTS   $sname"; skipped=$((skipped+1)); return
  fi
  if [ "$MODE" = "install" ]; then
    cp -r "$sdir" "$DEST/$sname" && rm -rf "$DEST/$sname/.git"
    if [ -f "$DEST/$sname/SKILL.md" ]; then
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
  done < <(find "$src" -maxdepth 4 -name SKILL.md \
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
