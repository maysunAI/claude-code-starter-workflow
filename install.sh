#!/usr/bin/env bash
# Starter workflow kit installer (Mac / Linux / Windows Git Bash)
# Usage:
#   bash install.sh                      # install to the user level ~/.claude (shared by all projects), downloads the lite kit
#   bash install.sh --project            # install into the current directory (./CLAUDE.md and ./.claude/)
#   bash install.sh --zip kit.zip        # use a local zip (for the full kit, sign in in the browser and download the zip first)
#   bash install.sh --dry-run            # only show what would be done, write nothing
#   bash install.sh --target /tmp/x      # choose the install directory (use it to try an install in a temp folder first)
# Rule: existing files are NEVER overwritten - the kit version is saved as <file name>.kit-new for you to compare and merge.
#       settings.json is never written; only settings.kit-example.json is created for reference.
set -euo pipefail

URL="https://workflow.maysuns.uk/en/kit/workflow-starter-lite.zip"
MODE="user"; ZIP=""; DRY=0; TARGET=""
while [ $# -gt 0 ]; do
  case "$1" in
    --project) MODE="project" ;;
    --user) MODE="user" ;;
    --zip) ZIP="${2:?--zip needs a path}"; shift ;;
    --dry-run) DRY=1 ;;
    --target) TARGET="${2:?--target needs a path}"; shift ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
if [ -z "$ZIP" ]; then
  echo "Downloading kit: $URL"
  curl -fsSL "$URL" -o "$TMP/kit.zip"
  ZIP="$TMP/kit.zip"
fi
command -v unzip >/dev/null || { echo "The unzip command is required"; exit 1; }
unzip -q "$ZIP" -d "$TMP/x"
ROOT="$(find "$TMP/x" -mindepth 1 -maxdepth 1 -type d | head -n1)"
[ -n "$ROOT" ] || { echo "No kit folder in the zip"; exit 1; }

if [ -n "$TARGET" ]; then MODE="target"; DEST="$TARGET"; CLAUDE_DIR="$TARGET"
elif [ "$MODE" = "project" ]; then DEST="$PWD"; CLAUDE_DIR="$DEST/.claude"; else DEST="$HOME/.claude"; CLAUDE_DIR="$DEST"; fi
DRYTXT=""; [ "$DRY" = 1 ] && DRYTXT=" (dry run)"
echo "Mode: $MODE   Target: $DEST$DRYTXT"

new=0; skipped=0
put() {  # put source-file target-file
  local src="$1" dst="$2"
  if [ -e "$dst" ]; then
    echo "  Skip (exists) $dst -> kit version saved as $dst.kit-new$DRYTXT"
    [ "$DRY" = 1 ] || cp "$src" "$dst.kit-new"
    skipped=$((skipped+1))
  else
    echo "  Create $dst$DRYTXT"
    if [ "$DRY" != 1 ]; then mkdir -p "$(dirname "$dst")"; cp "$src" "$dst"; fi
    new=$((new+1))
  fi
}

# 1) rules / commands / skills under .claude
while IFS= read -r f; do
  rel="${f#"$ROOT/.claude/"}"
  case "$rel" in
    settings.example.json) put "$f" "$CLAUDE_DIR/settings.kit-example.json" ;;  # never touch settings.json
    *) put "$f" "$CLAUDE_DIR/$rel" ;;
  esac
done < <(find "$ROOT/.claude" -type f | sort)

# 2) CLAUDE.md: project mode puts it in the project root; user mode only saves a template and does not take over your global CLAUDE.md
if [ -f "$ROOT/CLAUDE.md" ]; then
  if [ "$MODE" = "project" ]; then put "$ROOT/CLAUDE.md" "$DEST/CLAUDE.md"; else put "$ROOT/CLAUDE.md" "$DEST/CLAUDE.kit-template.md"; fi
fi

echo "Done: created $new, skipped $skipped (already existed; kit versions saved as .kit-new)."
echo "Next: open Claude Code and try /status; then replace the [bracketed] parts of the CLAUDE.md template with your own content."
