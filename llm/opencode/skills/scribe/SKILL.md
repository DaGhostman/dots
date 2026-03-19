---
name: Scribe
description: A RAG-powered note & bookkeeper for memory management, knowledge graph construction, and session-based documentation.
license: MIT
compatibility: opencode
---

# Scribe Skill

## What I Do

- **Create and manage conversation sessions** - Organize discussions into isolated, timestamped sessions with unique identifiers
- **Add structured memories** - Capture key points with rich metadata (tags, categories, priority, relationships)
- **Search and retrieve past memories** - Find relevant information across all sessions using semantic and keyword search
- **Build and maintain knowledge graphs** - Map relationships between entities, concepts, and decisions
- **Export knowledge** - Package memories and graphs for external tools or backup

## When to Use Me

### ✅ Session-Based Note-Taking
Long conversations, meetings, and discussions where you need to capture key decisions, track action items, and maintain a searchable record.

**Example:** Weekly team syncs, 1:1s, design reviews, planning sessions

### ✅ Building Personal/Team Knowledge Bases
Creating institutional memory to capture technical decisions, architectural patterns, and domain knowledge.

**Example:** Architecture decision records (ADRs), onboarding documentation, API design docs

### ✅ Capturing Technical Decisions
Structured decision tracking with metadata (who, when, why, alternatives considered) and relationship mapping.

**Example:** Technology stack choices, migration strategies, security decisions

### ✅ Regular Memory Consolidation
Periodic review to deduplicate memories, merge related concepts, and maintain knowledge base health.

## When NOT to Use Me

### ❌ Real-Time Transcription
Use dedicated speech-to-text tools for verbatim transcripts. I focus on **structured summaries**, not word-for-word recording.

### ❌ Simple To-Do Lists
Use task management tools (Jira, Trello, GitHub Issues) for pure task tracking. I capture **context and rationale** alongside action items.

### ❌ One-Off Notes
If you only need to remember something once, a simple note-taking app works better. I shine when building a **searchable knowledge base** over time.

### ❌ Sensitive/Confidential Information
I'm not designed for handling highly sensitive data. Use encrypted, access-controlled systems for confidential information.

### ❌ Replacing Version Control
Code, configuration files, and technical specifications should live in version control (Git). I capture **discussions about** code, not the code itself.

## RAG Operations

See [REFERENCES](REFERENCES.md) for complete API documentation.

## Workflows

See [WORKFLOWS](WORKFLOWS.md) for step-by-step examples.

## Best Practices

See [BEST_PRACTICES](BEST_PRACTICES.md) for guidelines.

## Quick Reference

### Key Tools
- `create_session()` - start new conversation sessions
- `add_memory()` - store structured memories
- `search_memories()` - retrieve past information
- `end_session()` - finalize session with summary
- `build_knowledge_graph()` - construct entity relationships
- `export_knowledge()` - package memories for external use
- `deduplicate_memories()` - identify and merge duplicates
- `consolidate_memories()` - group and summarize by category

### Memory Categories
- `technical_decision` - Technology and architecture decisions
- `action_item` - Tasks with owners and due dates
- `discussion` - Technical discussions and debates
- `idea` - New ideas and proposals
- `lesson_learned` - Lessons from experiments or incidents
- `meeting_notes` - Meeting summaries and outcomes
- `alternatives` - Options considered for decisions
- `implementation_plan` - Step-by-step implementation details

### Priority Levels
- `high` - Critical decisions, urgent actions
- `medium` - Important but not urgent
- `low` - Nice to know, future reference

### Session Naming Convention
Format: `YYYYMMDD_type_topic`

Examples:
- `20240319_meeting_architecture_review`
- `20240319_decision_event_sourcing`

### Daily Workflow
1. Create session at start of meeting/discussion
2. Add memories throughout the session
3. End session with summary and action items
4. Export notes if needed

### Weekly Workflow
1. Review and deduplicate memories
2. Consolidate by category
3. Update knowledge graph
4. Export weekly summary

---

**Remember:** The power of Scribe is in **consistency** and **rich metadata**. Tag everything well, and your knowledge base will become an invaluable resource over time.
