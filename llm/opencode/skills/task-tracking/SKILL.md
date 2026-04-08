# Task Tracking Skill

## Overview

The task tracking system provides persistent, structured tracking of work items across agent sessions. It enables:

- **Progress tracking** through explicit task states (To Do → In Progress → Done)
- **Context preservation** across conversations via linked sessions
- **Prioritization** with status-based work queues
- **Searchability** to find relevant tasks by text or status

Tasks are tied to a `source_id` (session/workspace path) for persistence and organization.

---

## Tool Reference

### 1. `tasks_setup`
Initialize task tracking for a workspace.

```json
{
  "workspace": "/path/to/project",
  "source_path": "/home/ddimitrov/.agents/skills/task-tracking"
}
```

**When to use:** First time enabling task tracking in a workspace. Returns a `source_id` used by all other tools.

---

### 2. `tasks_add`
Create new tasks.

```json
{
  "source_id": "abc123",
  "texts": ["Implement user authentication", "Write unit tests for auth module"],
  "status": "To Do",
  "index": 0
}
```

**Parameters:**
- `texts` (required): Array of task descriptions
- `status`: `"To Do"` (default), `"In Progress"`, `"Backlog"`, `"Done"`, `"Reminders"`, `"Notes"`
- `index`: Position in queue (0 = top, omit = bottom)
- `source_id` (required): From `tasks_setup`

**Returns:** Task IDs for reference.

---

### 3. `tasks_update`
Update task status or position.

```json
{
  "source_id": "abc123",
  "ids": ["task-id-1", "task-id-2"],
  "status": "Done",
  "index": 0
}
```

**Parameters:**
- `ids` (required): Array of task IDs to update
- `status`: Move to new status (e.g., `"In Progress"`, `"Done"`)
- `index`: New position within status queue

**Behavior:** Updating a task to `"In Progress"` automatically moves other tasks to `"To Do"`.

---

### 4. `tasks_search`
Find tasks by text or status.

```json
{
  "source_id": "abc123",
  "statuses": ["To Do", "In Progress"],
  "terms": ["authentication", "bug fix"],
  "limit": 20
}
```

**Parameters:**
- `terms`: Search text (OR logic, case-insensitive)
- `statuses`: Filter by status array
- `ids`: Find specific task IDs
- `limit`: Max results (default 2000)

---

### 5. `tasks_summary`
Get overview of all tasks.

```json
{
  "source_id": "abc123"
}
```

**Returns:** Count per status + current `In Progress` tasks.

---

## Workflow Patterns

### Creating Tasks from Conversation Agreements

When the user agrees to a plan or decision, capture it as a task immediately:

```
USER: Let's add rate limiting to the API.
AGENT: "tasks_add" {
  "source_id": "<current>",
  "texts": ["Implement API rate limiting (100 req/min)"],
  "status": "To Do",
  "index": 0
}
```

**Why:** Creates a paper trail of commitments and prevents agreed items from being forgotten.

---

### Breaking Down Complex Work

Use structured task creation for multi-step work:

```json
{
  "source_id": "<current>",
  "texts": [
    "Design: Define data model for rate limiting",
    "Backend: Implement rate limit middleware",
    "Tests: Add integration tests for rate limiting",
    "Docs: Document rate limit configuration"
  ],
  "status": "To Do",
  "index": 0
}
```

**Tip:** Order tasks in execution order. Mark first task `In Progress`, rest as `To Do`.

---

### Tracking Progress Through a Session

**Starting work:**
```json
{"ids": ["<task-id>"], "status": "In Progress"}
```

**Completing work:**
```json
{"ids": ["<task-id>"], "status": "Done"}
```

**Pattern:** Only one task should be `In Progress` at a time. Completing an `In Progress` task automatically promotes the next `To Do` task.

---

### Maintaining Context Across Sessions

1. **At session start:** Search for unfinished work
```json
{"statuses": ["To Do", "In Progress"]}
```

2. **At session end:** Ensure critical items are captured
```json
{"texts": ["Review PR feedback"], "status": "Reminders"}
```

3. **Session linking:** Use consistent `source_id` per project workspace

---

## Best Practices

### When to Create a Task vs. Memory

| Create a TASK | Store in MEMORY |
|--------------|-----------------|
| Actionable work item | Background context |
| Has clear completion state | Reference information |
| Requires follow-up | Non-blocking notes |
| Multiple steps involved | One-off observations |

**Rule of thumb:** If it needs a checkbox and someone will ask "is X done?", it's a task.

---

### How to Link Tasks to Sessions

Each `source_id` represents a persistent workspace context:

```
Workspace A (project-X)  →  source_id: "proj-x-session-1"
Workspace B (project-Y)  →  source_id: "proj-y-session-1"
```

**Best practice:** 
- Use `tasks_setup` once per workspace/project
- Reuse the returned `source_id` for all task operations in that project
- Store the `source_id` in your working context for the session

---

### Using Priority Effectively

**Work queue positions:**
- `index: 0` = Top priority (do next)
- `index: 1-3` = High priority (do soon)
- No index = Normal priority (backlog)

**Status semantics:**
- `"Reminders"` - Agent instructions that persist
- `"Notes"` - Non-actionable information
- `"Backlog"` - Future work, not current focus
- `"To Do"` - Committed work
- `"In Progress"` - Currently executing
- `"Done"` - Completed (searchable but not active)

---

## Examples

### Scenario: User asks to implement a feature

```json
{
  "source_id": "<current>",
  "texts": [
    "Implement user profile endpoint GET /api/users/:id",
    "Add request validation middleware",
    "Write OpenAPI docs for user profile"
  ],
  "status": "To Do",
  "index": 0
}
```

Then immediately start work:
```json
{
  "source_id": "<current>",
  "ids": ["<returned-task-id>"],
  "status": "In Progress"
}
```

---

### Scenario: User provides feedback on completed work

```json
{
  "source_id": "<current>",
  "texts": ["Address PR feedback: simplify error handling"],
  "status": "To Do",
  "index": 0
}
```

---

### Scenario: Finding blocked work

```json
{
  "source_id": "<current>",
  "statuses": ["In Progress"],
  "limit": 5
}
```

---

### Scenario: Session wrap-up

Check what's left:
```json
{"source_id": "<current>", "statuses": ["To Do", "In Progress"]}
```

Ensure important follow-ups are captured:
```json
{
  "source_id": "<current>",
  "texts": ["Tomorrow: Review user's PR comments"],
  "status": "Reminders"
}
```

---

## Session Integration

Tasks persist via their `source_id` which is tied to a workspace path. To maintain continuity:

1. **First interaction in a project:**
   ```
   tasks_setup(workspace="/path/to/project", source_path="...")
   → Returns source_id
   ```

2. **Store `source_id`** in your active context for the session

3. **All subsequent operations** pass `source_id` to maintain linkage

4. **Cross-session retrieval:**
   ```
   tasks_search(source_id="<stored>", statuses=["To Do", "In Progress"])
   ```

**Note:** Without `source_id`, tasks are not persisted across sessions. Always establish the source linkage early in any project workflow.

---

## Quick Reference

| Goal | Tool | Key Params |
|------|------|------------|
| Start tracking | `tasks_setup` | workspace, source_path |
| Add tasks | `tasks_add` | source_id, texts[], status |
| Mark done | `tasks_update` | source_id, ids[], status: "Done" |
| See queue | `tasks_summary` | source_id |
| Find task | `tasks_search` | source_id, terms[], statuses[] |
| Reorder | `tasks_update` | source_id, ids[], index |
