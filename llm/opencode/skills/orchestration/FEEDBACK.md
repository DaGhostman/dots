# Feedback Loops

## Communication Patterns

### Upward (to Orchestrator)

```
STATUS: In Progress | Blocked | Complete
TASK-ID: [Canonical task reference]
FINDINGS: Key discoveries
BLOCKERS: What needs resolution
RECOMMENDATION: [Optional: suggest delegation or escalation]
```

### Downward (to Subordinate Agents)

```
CLARIFICATION: Answers to questions
TASK-ID: [Which task this applies to]
REFINEMENT: Changes to requirements
VERDICT: Accept/Reject/Revise their output
```

---

## Phase-Based Feedback Loop

```
┌──────────────────────────────────────────────────────────────┐
│                      FEEDBACK FLOW                          │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Phase 1 (Planner)                                           │
│  ─────────────────                                           │
│  Agent → Planner: status, blockers, findings                │
│  Planner → Orchestrator: task breakdown, priorities         │
│                                                              │
│  Phase 2 (Architect)                                         │
│  ───────────────────                                         │
│  Agent → Architect: technical concerns, tradeoffs           │
│  Architect → Orchestrator: design decisions, risks          │
│                                                              │
│  Phase 3-4 (Orchestrator)                                    │
│  ───────────────────────                                     │
│  Orchestrator → Specialists: delegated tasks                │
│  Specialists → Orchestrator: results, recommendations       │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## Escalation Handling

### Escalation Types and Routing

| Issue Type | Routing | Auto-Resolution | Fallback |
|------------|---------|------------------|----------|
| **Blocker** | → Planner | Planner resolves | Human |
| **Technical** | → Architect | Architect resolves | Human |
| **Risk** | → Red-team | Red-team assesses | Human |
| **Resource** | → Orchestrator | Orchestrator resolves | Human |

### Escalation Flow

```
Agent identifies issue
        │
        ▼
┌─────────────────────────┐
│ Classify issue type     │
│ (blocker/technical/risk) │
└─────────────────────────┘
        │
        ▼
┌─────────────────────────┐
│ Route to appropriate    │
│ handler (Planner/Architect/Red-team)
└─────────────────────────┘
        │
        ▼
┌─────────────────────────┐
│ Auto-resolution attempt │
│ (max 3 attempts)         │
└─────────────────────────┘
        │
   ┌────┴────┐
   │         │
 success  fails after 3
   │         │
   ▼         ▼
 continue  Human fallback
```

### Escalation Message Format

```
ESCALATION: [blocker|technical|risk]
TASK-ID: [affected task]
DESCRIPTION: [What the issue is]
ATTEMPTS: [Number of auto-resolution attempts made]
RECOMMENDATION: [Suggested resolution or next action]
```

### Example Escalations

**Blocker Escalation:**
```
ESCALATION: blocker
TASK-ID: task-1-003
DESCRIPTION: Cannot proceed - dependency on auth module not ready
ATTEMPTS: 3
RECOMMENDATION: Await task-3-001 completion or proceed without auth for demo
```

**Technical Escalation:**
```
ESCALATION: technical
TASK-ID: task-2-005
DESCRIPTION: Two viable architecture patterns with tradeoffs
ATTEMPTS: 2
RECOMMENDATION: Choose Pattern A for simplicity, with migration path to B
```

**Risk Escalation:**
```
ESCALATION: risk
TASK-ID: task-3-010
DESCRIPTION: Proposed solution may violate data retention policy
ATTEMPTS: 1
RECOMMENDATION: Add legal review step before implementation
```

---

## Loop Types

### 1. Check-in Loops

Regular status updates during long-running tasks.

```
Every 3-5 turns: "Status update on [task-id]"
```

**Use when**: Long-running tasks, multiple parallel agents

### 2. Escalation Loops

Issues routed to appropriate handler for resolution.

```
Agent reports issue → Classify → Route to handler → Auto-resolve (3 max) → Human fallback
```

**Use when**: Agent encounters dependency, technical decision, or risk

### 3. Revision Loops

Output refinement for quality-critical deliverables.

```
Initial output → Review → Revisions → Final output
```

**Use when**: Quality-critical deliverables

### 4. Validation Loops

Verify feasibility before proceeding with major decisions.

```
Design → Validate feasibility → Implementation
```

**Use when**: Major decisions with downstream impact

---

## Suggestion Processing

### Receiving Suggestions

When other agents send recommendations to Orchestrator:

```
1. Acknowledge receipt
2. Validate format (has task-id, reason, priority)
3. Assess dependency implications
4. Decide: delegate | defer | decline
5. Respond with decision
```

### Suggestion Response Format

```
RECEIVED: [recommendation]
TASK-ID: [referenced task]
DECISION: [delegate|defer|decline]
REASON: [explanation if defer/decline]
ACTION: [if delegate: to which agent]
```

### Example Suggestion Processing

**Received:**
```
recommendation: delegate task-3-022 to @testing
reason: API changes need integration test coverage
priority: medium
dependencies: [task-3-018]
```

**Response:**
```
RECEIVED: recommendation for task-3-022
TASK-ID: task-3-022
DECISION: delegate
ACTION: Delegated to @testing with dependency context
```

---

## Handling Agent Conflicts

When agents disagree:

1. **Identify the conflict** clearly (capture task IDs)
2. **Get both perspectives** in writing
3. **Apply decision criteria**:
   - Which aligns with constraints?
   - Which has less risk?
   - Which is more maintainable?
   - What does specialist in that domain recommend?
4. **Decide and explain** rationale
5. **Document the decision** with task ID reference

---

## Human Fallback Triggers

Escalate to human when:

- Auto-resolution fails after 3 attempts
- Issue has business/legal implications
- Decision exceeds agent authority bounds
- Agent confidence is low on critical path

### Human Fallback Format

```
HUMAN ESCALATION REQUIRED
─────────────────────────
TASK-ID: [affected task]
ISSUE: [summary]
ATTEMPTS MADE: [number]
HANDLERS CONSULTED: [list]
STAKEHOLDER INPUT NEEDED: [what decision is required]
```

(End of file - total 173 lines)
