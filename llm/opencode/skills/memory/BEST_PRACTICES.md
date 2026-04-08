# Best Practices

## When to Store vs. Discard

**Store in Memory:**
- User preferences and stated requirements
- Key decisions and their rationale
- Conclusions reached during analysis
- Project-specific context (tech stack, architecture)
- Cross-session continuity (where we left off)
- Important findings that might be forgotten

**Don't Store:**
- Routine observations that will be obvious later
- Low-stakes preferences that can be re-elicited
- Information that belongs in documentation
- Sensitive data (use caution with PII)

## Memory vs. Task Tracking

| Use MEMORY | Use TASK TRACKING |
|------------|-------------------|
| Background context | Actionable work items |
| Reference information | Has clear completion state |
| Non-blocking notes | Requires follow-up |
| Preferences, findings | Implementation tasks |
| "User prefers X" | "Implement feature X" |

**Rule of thumb:** If someone would ask "is this done?", it's a task. If it's context for future work, it's memory.

## Privacy Considerations

1. **No PII in memories**: Avoid storing names, emails, personal details unless explicitly necessary
2. **Session isolation**: Use separate sessions for different projects/users
3. **Delete on request**: Users can request memory deletion

## Importance Guidelines

| Importance | When to Use | Example |
|------------|-------------|---------|
| 0.9-1.0 | Critical, never forget | "User's API key format", "Primary architecture decision" |
| 0.7-0.8 | Important, high retrieval priority | User preferences, key findings |
| 0.5-0.6 | Normal conversation content | Regular exchanges, regular findings |
| 0.3-0.4 | Minor, deduplication candidates | Routine observations |
| < 0.3 | Ephemeral, likely to be deduplicated | Very minor context |

## Quick Start Checklist

When starting a new project session:

```
□ Create or find session: create_session / list_sessions
□ Load relevant context: get_memory_context
□ Search for past findings: search_memories
□ Add project setup memories: add_memory (role: system, importance: 0.7+)
□ Note user preferences: add_memory (role: user, importance: 0.8+)

During work:
□ Store key conclusions: add_memory (role: assistant, importance: 0.7+)

Before ending:
□ Add session summary: add_memory (role: system)
□ Check for duplicates: deduplicate_memories (with dry_run=true)
□ Clean up if satisfied: deduplicate_memories (with dry_run=false)
```
