# Practical Scenarios

## Scenario 1: Onboarding a New Project

```
1. Create session for the project:
   create_session(name="project-onboarding", description="New project context")

2. Search for existing memories about this project:
   search_memories(query="project X architecture")

3. Add project-specific context as memories:
   add_memory(session_id="...", role="system", content="Project X is a Node.js REST API using Express")
   add_memory(session_id="...", role="system", content="Database is PostgreSQL with Prisma ORM")
   add_memory(session_id="...", role="assistant", content="Key endpoints: /users, /products, /orders")

4. Add user preferences discovered during onboarding:
   add_memory(session_id="...", role="user", importance=0.8, content="User prefers unit tests over integration tests")
   add_memory(session_id="...", role="user", importance=0.7, content="User wants detailed error messages in API responses")
```

## Scenario 2: Maintaining User Preferences

```
User: "I prefer if you explain your reasoning before writing code"

→ add_memory(session_id="...", role="user", importance=0.9,
     content="User wants explanations before implementing code")

User: "Actually, I also prefer short responses, not too much detail"

→ add_memory(session_id="...", role="user", importance=0.8,
     content="User prefers concise responses over detailed explanations")

Later, when generating responses:
→ get_memory_context(session_id="...", query="user communication preferences")
→ Finds the above memories, applies them
```

## Scenario 3: Remembering Research Findings

```
1. During analysis of a bug:
   add_memory(session_id="...", role="assistant", importance=0.8,
     content="Bug in userService.getUser() - returns undefined for users created before 2024")

2. After root cause analysis:
   add_memory(session_id="...", role="assistant", importance=0.9,
     content="Root cause: timezone handling bug in date-fns usage, affects dates before epoch")

3. After fix is implemented:
   add_memory(session_id="...", role="system", importance=0.6,
     content="Bug fix deployed: updated date-fns to v2.30.0, patched timezone handling")

4. Next session can search "userService bug" and find all context
```

## Scenario 4: Multi-Session Research

```
Session 1 (Research Phase):
→ add_memory(session_id="...", role="assistant", content="Initial approach: use Redis for caching")
→ add_memory(session_id="...", role="assistant", content="Concern: Redis adds deployment complexity")

Session 2 (Evaluation Phase):
→ search_memories(query="caching approach")
→ Gets Session 1 memories
→ add_memory(session_id="...", role="assistant", content="Evaluated alternatives: in-memory (too simple), Memcached (less features than Redis)")

Session 3 (Decision):
→ get_memory_context(query="caching decision")
→ Retrieves all research from Sessions 1 & 2
→ add_memory(session_id="...", role="system", importance=0.9,
     content="Decision: Use Redis. Trade-off: complexity vs. features. Approved by user.")
```

## Scenario 5: Context Loading at Session Start

```
At start of new session:

1. list_sessions to find relevant sessions:
   list_sessions(user_id="user-123")

2. For the most relevant session:
   get_session(session_id="abc-123")
   
3. Load key context:
   get_memory_context(session_id="abc-123", query="current project status")
   
4. Add session marker:
   add_memory(session_id="abc-123", role="system", content="Continuing work on Project X. Last session discussed authentication.")

5. Work on tasks with full context
```

## Scenario 6: Memory Cleanup

```
Before ending a productive session:

1. Check for duplicates:
   deduplicate_memories(session_id="...", threshold=0.85, dry_run=true)
   
2. Review duplicate groups in response

3. If satisfied, apply merge:
   deduplicate_memories(session_id="...", threshold=0.85, strategy="merge", dry_run=false)
   
4. Add session summary:
   add_memory(session_id="...", role="system", content="Session summary: Completed auth module, identified 3 bugs in userService, all documented.")
```
