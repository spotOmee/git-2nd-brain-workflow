# 🧠 Git Second Brain Workflow

> Turn a private GitHub repository into permanent, structured, cross-session memory for AI coding agents (Antigravity CLI, OpenCode, Claude Code, Cursor, and Termux/PRoot).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Git Memory](https://img.shields.io/badge/Memory-Zero--Storage--Bloat-brightgreen.svg)](#)
[![Workflow](https://img.shields.io/badge/Workflow-git--push%20%7C%20git--pull-orange.svg)](#)

---

## 💡 The Problem: AI Coding Agent Context Amnesia

Terminal and CLI coding agents are extraordinarily capable, but suffer from a fatal flaw: **every time a session ends or terminal restarts, all memory evaporates**.

- **Lost Architectural Context:** Agents forget *why* specific architectural decisions, refactors, or fixes were chosen.
- **Wasted Tokens & Time:** Developers spend 15–30 minutes repeatedly explaining background context, project setups, and past debugging sessions.
- **Fragmented Environments:** Switching between a desktop, laptop, or mobile environment (e.g. Android Termux/PRoot) leaves your agent completely blind to previous progress.

---

## ⚡ The Solution: Git Second Brain

The **Git Second Brain Workflow** decouples session memory from ephemeral agent processes by storing persistent, human-readable, structured Markdown records in a private GitHub repository (`second-brain` or `antigravity-BRAIN`).

```mermaid
flowchart LR
    A["Active Terminal Session"] -- "/git-push" --> B["Structured Session Record (.md)"]
    B --> C["Private GitHub Brain Repo"]
    C -- "/git-pull &lt;keyword&gt;" --> D["New Agent Session (Instant Hydration)"]
```

- **`/git-push`**: Captures the entire conversation arc from Message #1 into a rich 4-section Markdown document (> 500 bytes), copies artifacts, updates the master `README.md` index table, and pushes to GitHub.
- **`/git-pull`**: Synchronizes remote changes and either provides a clean overview of recent sessions (Mode A) or performs deep keyword ranking (Mode B) to hydrate active memory in seconds.
- **Zero Storage Bloat:** Markdown files maintain a tiny disk footprint while shallow fetches (`--depth 1`) eliminate massive Git history overhead on mobile and low-storage machines.

---

## 📂 Repository Structure

```
git-2nd-brain-workflow/
├── README.md                   # System blueprint & documentation
├── skills/
│   ├── git-push/
│   │   └── SKILL.md            # Reusable /git-push skill definition
│   └── git-pull/
│       └── SKILL.md            # Reusable /git-pull skill definition
└── docs/
    ├── git-push-explained.md   # Deep dive into session narrative export & indexing
    └── git-pull-explained.md   # Deep dive into keyword recall & memory hydration
```

---

## ⚖️ Workflow Comparison: `/git-push` vs `/git-pull`

| Feature | `/git-push` | `/git-pull` |
| :--- | :--- | :--- |
| **Primary Purpose** | Session memory serialization & export | Session memory recall & context hydration |
| **When to Use** | At end of task, before quitting, or after major milestones | At start of conversation or when switching topics |
| **Input Arguments** | None (reads full conversation history automatically) | Optional query/keyword (e.g., `/git-pull apk-build`) |
| **Integrity Gate** | File exists, `> 500 bytes`, all 4 sections non-empty | Pulls remote, ranks top 1–3 matches, ingests full content |
| **Remote Action** | Staged, committed with semantic message, pushed | `git pull origin main` to synchronize multi-device edits |
| **Triggers** | `/git-push`, `/git push`, `save session to brain` | `/git-pull`, `/git pull`, `/git-pull <keyword>` |

---

## 🚀 The `/git-push` Component

The `/git-push` skill extracts the full narrative arc from your active conversation and commits it to your private Second Brain repository.

### How to Trigger:
- `/git-push`
- `/git push`
- `save session to brain`
- `sync session narrative to second brain`

### The 4 Required Sections (Integrity Gate):
Every exported session is required to exceed 500 bytes and contain all four populated sections:
1. `## Session Story & User Intent`: 2–3 narrative paragraphs explaining what the user set out to do and why decisions were made.
2. `## Complete Chronological Workflow`: Step-by-step breakdown of actions taken.
3. `## Key Milestones, Repos & Technical Decisions`: Concrete repository names, commit SHAs, file paths, and architectural choices.
4. `## Searchable Context & Notes`: Keywords, tools, commands, and concepts engineered for accurate `/git-pull <keyword>` recall.

### Automatic Master Indexing
When `/git-push` executes, it automatically updates the `README.md` table in your private brain repository:
```markdown
| Date | Session ID | Title | File |
| :--- | :--- | :--- | :--- |
| 2026-11-19 11:25:00 | `fb2dcfc3` | Install GitHub Actions Build APK Global Skill | [20261119_fb2dcfc3_Install_GitHub_Actions_Build_APK_Global_Skill.md](sessions/20261119_fb2dcfc3_Install_GitHub_Actions_Build_APK_Global_Skill.md) |
```

For the complete technical breakdown, read [docs/git-push-explained.md](docs/git-push-explained.md).

---

## 🔄 The `/git-pull` Component

The `/git-pull` skill queries your private Second Brain repository, pulls recent commits made across all devices, and hydrates active agent context.

### How to Trigger:
- `/git-pull` (Mode A: Overview of recent sessions)
- `/git-pull <keyword>` or `/git-pull <phrase>` (Mode B: Deep keyword search & ranking)
- `recall past session on <topic>`

### Mode A: Overview (No Keyword)
- Pulls latest remote commits (`git pull origin main`).
- Reads `README.md` and the 5 most recent files in `sessions/`.
- Summarizes recent projects, active tasks, and milestones.

### Mode B: Deep Keyword Recall (`/git-pull <query>`)
- Searches across `sessions/` and `artifacts/`.
- Ranks matches using weighted relevance (+100 title match, +80 tag match, +50 story/notes match, +10 per keyword occurrence, recency tie-breaker).
- Ingests top 1–3 matching markdown files into active agent memory.
- Summarizes recalled milestones and continues the user's ongoing prompt without friction.

For the complete technical breakdown, read [docs/git-pull-explained.md](docs/git-pull-explained.md).

---

## 📄 License
MIT License. Free to use, adapt, and share.
