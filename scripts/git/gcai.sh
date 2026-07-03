#!/usr/bin/env bash
# gcai — AI-powered interactive git commit via Claude Code CLI
# Usage: gcai [extra context]

set -euo pipefail

# ── Guards ────────────────────────────────────────────────────────────────────

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	echo "gcai: not inside a git repository" >&2
	exit 1
fi

if ! command -v claude &>/dev/null; then
	echo "gcai: claude CLI not found. Run: npm install -g @anthropic-ai/claude-code" >&2
	exit 1
fi

# ── Staged check ──────────────────────────────────────────────────────────────

if git diff --cached --quiet; then
	echo "gcai: nothing staged."
	read -r -p "Stage all changes? [y/N] " stage_all
	if [[ "$stage_all" =~ ^[Yy]$ ]]; then
		git add -A
	else
		echo "Aborted. Stage your changes and re-run." >&2
		exit 1
	fi
fi

# ── Branch-based prefix logic ─────────────────────────────────────────────────

branch=$(git rev-parse --abbrev-ref HEAD)

# Match Jira-style ticket: FCWC-1234 (or any ALL_CAPS prefix like PROJECT-123)
if [[ "$branch" =~ ^([A-Z]+-[0-9]+) ]]; then
	ticket="${BASH_REMATCH[1]}"
	style_instruction="Prefix the commit message with the Jira ticket '${ticket}: '. Example: '${ticket}: fix null pointer in auth middleware'. Do NOT use conventional commit prefixes (feat:, fix:, etc.) — just the ticket prefix."
else
	ticket=""
	style_instruction="Use conventional commits format: feat:, fix:, refactor:, docs:, chore:, test:, etc."
fi

# ── Build prompt ──────────────────────────────────────────────────────────────

extra_context="${1:-}"

diff_stat=$(git diff --cached --stat)
diff_body=$(git diff --cached)

prompt="You are helping write a git commit message.

BRANCH: ${branch}
STYLE: ${style_instruction} Keep the subject line under 72 characters. Add a short body if the change needs explanation.

STAGED FILES:
${diff_stat}

DIFF:
${diff_body}
${extra_context:+
EXTRA CONTEXT FROM DEVELOPER:
${extra_context}}

Output ONLY the commit message — no explanation, no markdown, no code fences.
First line: subject (≤72 chars).
Optionally a blank line followed by a short body.
Nothing else."

# ── Show diff summary to user ─────────────────────────────────────────────────

echo ""
echo "┌─ Staged changes ───────────────────────────────────────────────────────"
git diff --cached --stat | sed 's/^/│ /'
echo "└────────────────────────────────────────────────────────────────────────"
if [[ -n "$ticket" ]]; then
	echo "  Branch: ${branch}  →  using ticket prefix: ${ticket}"
else
	echo "  Branch: ${branch}  →  using conventional commits"
fi
echo ""

# ── Call Claude ───────────────────────────────────────────────────────────────

echo "Generating commit message..."
commit_msg=$(claude -p "$prompt" 2>/dev/null)

if [[ -z "$commit_msg" ]]; then
	echo "gcai: Claude returned an empty message." >&2
	exit 1
fi

# ── Interactive confirm ───────────────────────────────────────────────────────

echo ""
echo "┌─ Proposed commit ──────────────────────────────────────────────────────"
echo "$commit_msg" | sed 's/^/│ /'
echo "└────────────────────────────────────────────────────────────────────────"
echo ""
echo "  [c] commit    [e] edit    [r] regenerate    [q] quit"
echo ""

while true; do
	read -r -p "  › " choice
	case "$choice" in
	c | C | "")
		git commit -m "$commit_msg"
		echo ""
		echo "✓ Committed."
		break
		;;
	e | E)
		# Drop into $EDITOR for manual edit
		tmp=$(mktemp)
		echo "$commit_msg" >"$tmp"
		"${EDITOR:-vim}" "$tmp"
		commit_msg=$(cat "$tmp")
		rm -f "$tmp"
		git commit -m "$commit_msg"
		echo ""
		echo "✓ Committed (edited)."
		break
		;;
	r | R)
		echo "Regenerating..."
		commit_msg=$(claude -p "$prompt" 2>/dev/null)
		echo ""
		echo "┌─ Proposed commit ──────────────────────────────────────────────────────"
		echo "$commit_msg" | sed 's/^/│ /'
		echo "└────────────────────────────────────────────────────────────────────────"
		echo ""
		echo "  [c] commit    [e] edit    [r] regenerate    [q] quit"
		echo ""
		;;
	q | Q)
		echo "Aborted." >&2
		exit 1
		;;
	*)
		echo "  Unknown option. Use c / e / r / q"
		;;
	esac
done
