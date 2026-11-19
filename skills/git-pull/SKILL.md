---
name: git-pull
description: Intelligent session memory recall: pulls latest updates from your private Git Second Brain repository, provides full index overview (no keyword) or executes deep keyword/phrase matching across titles, tags, and full Markdown body text to hydrate active agent context.
---

# Git Pull Skill (Git Second Brain Intelligent Memory Recall)

## Objective
Synchronize the local memory repository with your private Git Second Brain repository and either provide a global structured briefing of recent sessions (Mode A — No Keyword) or perform deep keyword/phrase matching across filenames, titles, tags, and full Markdown body content (Mode B — Keyword/Phrase Provided) to recover historical context into active agent memory.

## Target Repository & Directory Resolution
The Second Brain repository stores your persistent cross-session memory. The skill automatically resolves the local repository path in the following order:
1. Environment variable: `$SECOND_BRAIN_PATH`
2. Default path: `~/second-brain`
3. Fallback path: `~/antigravity-BRAIN` (or user-configured path)

Verify the target repository points to your private brain repository:
- **Visibility:** Private
- **Target Branch:** `main`
- **Target Remote:** `origin` (e.g. `git@github.com:<username>/second-brain.git`)

## Strict Constraints
- Pull latest updates strictly from your private Second Brain repository.
- Never query or pull session logs from project-specific code repositories.
- Always perform deep retrieval across `sessions/` and `artifacts/`.

## Strict Execution Protocol

When `/git-pull [optional keyword or phrase]` is triggered, execute these steps:

### Step 1: Sync Latest Remote Memory
Run git pull inside the local Second Brain repository to ensure changes from other devices or sessions are present:
```bash
git -C "$BRAIN_PATH" pull origin main
```

### Step 2: Route by Input Mode

#### Mode A — No Keyword Provided (`/git-pull`):
1. Read `$BRAIN_PATH/README.md` and the 5 most recent files in `$BRAIN_PATH/sessions/`.
2. Present a clean, structured briefing of recent sessions, active projects, and key topics:
   - **Recent Sessions Table:** Date, Session ID, Title, and relative file path.
   - **Executive Story Snippet:** The core problem solved and user intent for recent sessions.
   - **Key Decisions:** Major architectural choices, repos, and milestones.
3. Prompt the user with options on where they would like to resume or continue.

#### Mode B — Keyword or Phrase Provided (`/git-pull <query>`):
1. Perform a case-insensitive full-text search across all markdown files in `$BRAIN_PATH/sessions/` and `$BRAIN_PATH/artifacts/` (searching filenames, `# Title`, `Tags`, `Session Story`, `Workflow`, and `Searchable Context` body text).
2. Rank matching files by relevance:
   - **Highest weight:** Exact phrase or title/tag match (+100 for title, +80 for tags, +50 for filename/story/notes).
   - **Medium weight:** Multiple individual keyword occurrences inside `Session Story & User Intent` or `Searchable Context & Notes` (+10 per word match).
   - **Tie-breaker:** Most recent timestamp (newer sessions rank higher when scores match).
3. Read the complete Markdown contents of the top 1–3 matching session files.
4. Ingest that context directly into your active working memory.
5. Give the user a clear summary of what was recalled:
   - **Recalled Session Title & Date**
   - **User Intent & Story Reconstructed**
   - **Key Technical Decisions & Repositories**
   - **Relevant Notes & Context**
6. Proceed seamlessly with the user's ongoing request using the recalled context.
