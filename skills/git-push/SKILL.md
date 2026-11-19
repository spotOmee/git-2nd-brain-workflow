---
name: git-push
description: Intelligent session memory sync: captures full session narrative from Message #1 to final result, extracts descriptive 4-8 word title/tags, writes rich Markdown session record, updates README.md index, and pushes to your private Git Second Brain repository.
---

# Git Push Skill (Git Second Brain Full-Session Narrative Sync)

## Objective
Capture the **entire session narrative** from the very first user prompt to the final result—including the user's intent, story, workflows, repositories created or modified, and tools used—before staging, committing, and pushing to your private Git Second Brain repository.

## Target Repository & Directory Resolution
The Second Brain repository stores your persistent cross-session memory. The skill automatically resolves the local repository path in the following order:
1. Environment variable: `$SECOND_BRAIN_PATH`
2. Default path: `~/second-brain`
3. Fallback path: `~/antigravity-BRAIN` (or user-defined brain directory)

Verify the target repository points to your private brain repository:
- **Visibility:** Private
- **Target Branch:** `main`
- **Target Remote:** `origin` (e.g. `git@github.com:<username>/second-brain.git`)

## Strict Constraints
- **DO NOT** initialize a new repository inside existing projects.
- **DO NOT** push session memories to public repositories or project code repositories.
- Target remote must always remain your dedicated private Second Brain repository.
- Never commit empty metadata stubs or `Untitled Session`.
- Enforce the integrity gate: session records must exceed 500 bytes and contain all 4 required narrative sections before git operations.

## Strict Execution Protocol (In Order)

When `/git-push` is triggered, execute these steps **strictly in order**:

### Step 1: Read & Reconstruct the Complete Session Arc
Scan the **entire conversation transcript from Message #1 to the current turn** (do NOT summarize only the most recent tool call or prompt).

Reconstruct the full narrative arc:
- **User Intent & Starting Point:** What initial problem, task, or vision did the user start with?
- **Chronological Workflow & Actions:** Step-by-step narrative of what was investigated, created, debugged, refactored, or deployed.
- **Key Decisions, Tools & Repositories:** Exact repository names, file paths, commands, libraries, and architectural decisions.
- **Final Outcome & Next Steps:** What is fully functional now, and what items (if any) remain for future sessions.

### Step 2: Generate Descriptive Title & Rich Markdown File
- **Title:** Generate a clear, human-readable 4–8 word title representing the entire session (never use `Untitled Session`).
- **Sanitized Filename:** Keep alphanumeric characters, spaces, hyphens, and underscores. Replace spaces with underscores.
- **File Path:** `sessions/YYYYMMDD_<short_session_id>_<Sanitized_Title>.md` (inside your Brain repository).
- **Required Markdown Structure:**
  ```markdown
  # <Descriptive Session Title>
  - **Conversation ID:** `<full_session_id>`
  - **Timestamp:** `<ISO_8601_UTC>`
  - **Tags:** `<comma-separated searchable keywords, repo names, tools, concepts>`

  ## Session Story & User Intent
  <2–3 paragraphs written in clear narrative form explaining what the user wanted to achieve from the beginning of the chat, the journey of steps taken, and why each decision was made.>

  ## Complete Chronological Workflow
  1. **Initial Setup / Input:** <What first started the session or user prompt>
  2. **Core Execution:** <Major actions performed—code written, repos created, tests executed>
  3. **Finalization:** <How the session concluded and verified deliverables>

  ## Key Milestones, Repos & Technical Decisions
  - **Repositories / Artifacts:** <List exact files, GitHub repos, or skills touched>
  - **Architecture / Decisions:** <Key technical choices, configurations, design patterns>

  ## Searchable Context & Notes
  <Detailed plain-English notes covering specific tools, prompts, error fixes, and concepts discussed so future `/git-pull <keyword>` queries match accurately.>
  ```

#### Handling Associated Artifacts
If the session generated markdown artifacts or architecture diagrams in the agent's brain artifact directory (e.g. `<appDataDir>/brain/<conversation-id>/`), copy them to `artifacts/<short_session_id>/` in your Second Brain repository and link them under an `## Associated Artifacts` section:
```markdown
## Associated Artifacts
- [`<artifact_file>.md`](../artifacts/<short_session_id>/<artifact_file>.md)
```

### Step 3: Verify Local File Integrity Before Git Operations (Integrity Gate)
Confirm all of the following criteria before executing any git command:
1. The `.md` file exists on disk and is completely flushed.
2. File size is **strictly greater than 500 bytes** (`> 500 bytes`).
3. All four required sections are present and non-empty:
   - `## Session Story & User Intent`
   - `## Complete Chronological Workflow`
   - `## Key Milestones, Repos & Technical Decisions`
   - `## Searchable Context & Notes`

If any check fails, abort immediately, correct the file content, and re-verify.

### Step 4: Update `README.md` Index & Push to GitHub
1. **Update Master Index (`README.md`):**
   - Prepend the new session entry to the `Recent Sessions` table:
     ```markdown
     | <YYYY-MM-DD HH:MM:SS> | `<short_session_id>` | <Descriptive Title> | [<filename>.md](sessions/<filename>.md) |
     ```
   - Increment the `- **Total Synced Sessions**:` counter.
   - Update the `- **Last Synced**:` UTC timestamp.

2. **Commit and Push:**
   Execute inside the Second Brain repository directory:
   ```bash
   git pull --rebase origin main
   git add sessions/ artifacts/ README.md
   git commit -m "sync(brain): <Descriptive Session Title> (<short_session_id>)"
   git push origin main
   ```

3. **Confirmation Output:**
   Print a clean, structured confirmation to the user:
   - **Title:** `<Descriptive Session Title>`
   - **Session ID:** `<short_session_id>`
   - **Tags:** `<Tags>`
   - **File Path:** `sessions/<filename>.md`
   - **Commit SHA:** `<commit_sha>`
