---
name: memory
description: Comprehensive memory management for persistent conversation context. Use when storing user preferences, remembering research findings, maintaining cross-session context, tracking conversation conclusions, or any task requiring memory of past interactions.
license: MIT
---

# Memory Management Skill

The memory system provides **persistent conversation context** that survives across sessions. It augments RAG by storing structured memories with importance scoring and deduplication.

---

## Overview

| Concept | Purpose | Lifespan |
|---------|---------|----------|
| **Sessions** | Container for a conversation thread | Persistent until explicitly deleted |
| **Memories** | Individual pieces of stored context | Persistent |

### Roles

| Role | When to Use | Example |
|------|-------------|---------|
| `user` | User-provided information, preferences | "User prefers TypeScript" |
| `assistant` | Agent conclusions, synthesized findings | "Bug is in auth module" |
| `system` | Summaries, cross-session context | "Summary of 50 exchanges" |

### Importance Scoring (0.0-1.0)

- **0.8-1.0**: Critical (preferences, key decisions)
- **0.5-0.7**: Normal info (conversation turns)
- **0.2-0.4**: Minor details, auto-generated

---

## Tools Summary

| Tool | Purpose |
|------|---------|
| `create_session` | Start new session |
| `list_sessions` | List user's sessions |
| `get_session` | Get session details |
| `delete_session` | Delete session |
| `add_memory` | Store context |
| `list_memories` | List session memories |
| `search_memories` | Search memories |
| `get_memory_context` | Get contextual memories |
| `delete_memory` | Remove memory |
| `deduplicate_memories` | Find/merge duplicates |
| `unified_search` | Search all sources |

---

## Detailed References

For detailed content, see:
- [Patterns](PATTERNS.md) - Memory patterns and RAG integration
- [Best Practices](BEST_PRACTICES.md) - When to store, privacy, importance guidelines
- [References](REFERENCES.md) - Complete tool documentation
- [Examples](EXAMPLES.md) - Practical scenarios
