#!/usr/bin/env bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"

echo "==> Deploying Git Second Brain skills globally..."

SKILLS=("git-push" "git-pull")
ALIASES_PUSH=("git_push")
ALIASES_PULL=("git_pull")

# Ensure base directories exist
mkdir -p "$HOME/.agents/skills"
[ -d "$HOME/.gemini" ] && mkdir -p "$HOME/.gemini/skills"
[ -d "$HOME/.claude" ] && mkdir -p "$HOME/.claude/skills"

for SKILL in "${SKILLS[@]}"; do
  SRC_DIR="$REPO_ROOT/skills/$SKILL"
  TARGET="$HOME/.agents/skills/$SKILL"

  if [ -d "$SRC_DIR" ]; then
    echo "Linking $SKILL from $SRC_DIR -> $TARGET"
    ln -sfn "$SRC_DIR" "$TARGET"
    
    # Link across other agent discovery paths
    [ -d "$HOME/.gemini/skills" ] && ln -sfn "$SRC_DIR" "$HOME/.gemini/skills/$SKILL"
    [ -d "$HOME/.claude/skills" ] && ln -sfn "$SRC_DIR" "$HOME/.claude/skills/$SKILL"
  fi
done

# Setup aliases
if [ -d "$REPO_ROOT/skills/git-push" ]; then
  for A in "${ALIASES_PUSH[@]}"; do
    ln -sfn "$REPO_ROOT/skills/git-push" "$HOME/.agents/skills/$A"
    [ -d "$HOME/.gemini/skills" ] && ln -sfn "$REPO_ROOT/skills/git-push" "$HOME/.gemini/skills/$A"
    [ -d "$HOME/.claude/skills" ] && ln -sfn "$REPO_ROOT/skills/git-push" "$HOME/.claude/skills/$A"
  done
fi

if [ -d "$REPO_ROOT/skills/git-pull" ]; then
  for A in "${ALIASES_PULL[@]}"; do
    ln -sfn "$REPO_ROOT/skills/git-pull" "$HOME/.agents/skills/$A"
    [ -d "$HOME/.gemini/skills" ] && ln -sfn "$REPO_ROOT/skills/git-pull" "$HOME/.gemini/skills/$A"
    [ -d "$HOME/.claude/skills" ] && ln -sfn "$REPO_ROOT/skills/git-pull" "$HOME/.claude/skills/$A"
  done
fi

echo ""
echo "Deployment complete! Available skills:"
echo "  - /git-push  (Save active session narrative to private brain)"
echo "  - /git-pull  (Recur and hydrate past session context)"
