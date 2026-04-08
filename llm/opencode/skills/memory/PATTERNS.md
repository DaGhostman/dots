# Memory Patterns

## Pattern A: Storing Conversation Conclusions

After making a decision or reaching a finding, store it with high importance:

```
AGENT: Based on my analysis, the authentication issue is in the JWT validation middleware.
→ add_memory with role="assistant", importance=0.8, content="JWT validation middleware is the root cause of auth failures"
```

**Why:** Future sessions can search "authentication issues" and find this conclusion.

## Pattern B: Remembering User Preferences

Capture explicit and inferred preferences:

```
USER: I always use ESLint with the Airbnb config
→ add_memory with role="user", importance=0.9, content="User uses ESLint with Airbnb config"

USER: Please use arrow functions
→ add_memory with role="user", importance=0.7, content="User prefers arrow functions over regular functions"
```

**Why:** Subsequent sessions can apply these preferences without re-asking.

## Pattern C: Building Context Across Sessions

At session start, load relevant context:

```
1. list_sessions to find existing sessions for this project
2. search_memories with project-related query
3. add_memory to store what was learned in this session before ending
```

**Why:** Each session contributes to a growing knowledge base.

## Pattern D: Deduplication

Find and merge duplicate memories:

```
1. Run deduplicate_memories with dry_run=true to find duplicates
2. Review duplicate groups
3. Run deduplicate_memories with dry_run=false to merge
```

**Why:** Repeated discussions may generate similar memories. Deduplication keeps the consolidated view.

---

# RAG Integration

Memory and RAG complement each other:

| System | Purpose | Retention |
|--------|---------|-----------|
| **Memory** | Structured, role-typed, importance-scored | Long-term, persistent |
| **RAG Documents** | Unstructured content, code, docs | Long-term, indexed |
| **Context Window** | Immediate conversation | Ephemeral |

## How Memory Augments Generation

```
1. User query arrives

2. get_memory_context(session_id, query) → memories relevant to query

3. rag_search_documents(query) → document chunks

4. Combine:
   - Memory provides user preferences, past conclusions
   - RAG provides documentation, code context

5. Generate response with combined context
```

Or use `unified_search` to search all sources at once.

## Context Window Strategy

For large context windows, prioritize:

1. **Most recent memories** (get_memory_context includes these automatically)
2. **High-importance memories** (importance >= 0.7)
3. **Relevant document chunks** (RAG search)

Lower-importance memories can be deduplicated or omitted.

## Memory vs. Knowledge Base

| Memory | Knowledge Base |
|--------|----------------|
| Conversation-derived | Manually curated |
| Role-typed (user/assistant/system) | Type-typed (fact/FAQ/procedure) |
| Session-bound | Global |
| Deduplication | No deduplication |

**Use Memory for:** Preferences stated in conversation, conclusions reached during research, context that emerged organically.

**Use Knowledge Base for:** Explicitly provided facts, FAQs, documented procedures.
