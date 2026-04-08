# Delegation Patterns

## Delegation Architecture

### New Model (Direct Delegation)

```
┌─────────────────────────────────────────────────────────────────┐
│                         ORCHESTRATOR                             │
│                    (sole delegation authority)                  │
│                                                                 │
│  ┌─────────────┐    delegate     ┌─────────────────────────┐   │
│  │  Planner    │ ──────────────► │  Specialists            │   │
│  │  Phase 1    │                 │  (Security, Code-Intel, │   │
│  └─────────────┘                 │   Testing, etc.)        │   │
│  ┌─────────────┐    recommend    └─────────────────────────┘   │
│  │  Architect  │ ◄─────────────                               │
│  │  Phase 2    │                 ┌─────────────────────────┐   │
│  └─────────────┘    recommend    │  All Other Agents       │   │
│  ┌─────────────┐ ──────────────► │  (feedback/input only)  │   │
│  │  Red-team   │                 └─────────────────────────┘   │
│  │  (advisory) │                                                │
│  └─────────────┘                                                │
└─────────────────────────────────────────────────────────────────┘
```

**Key Change**: Orchestrator delegates directly to Specialists. No intermediate Executor.

---

## When to Delegate vs. Recommend

### Orchestrator Delegates When

- Task requires specialist execution (Security review, Code search, etc.)
- Task has clear deliverable/output
- Task can proceed independently

### All Agents Recommend When

- Identifying tasks that need delegation
- Suggesting prioritization changes
- Reporting blockers or risks
- Requesting human input

---

## Task ID Reference Pattern

### Canonical Task References

All delegated tasks use canonical task IDs for tracking:

```
task-{phase}-{sequence}
Examples:
  task-1-001  (Planner: first task)
  task-2-003  (Architect: third task)
  task-3-007  (Orchestrator delegated: seventh task)
```

### Using Task IDs in Communication

```
recommendation: delegate task-2-003 to @security
reason: Auth module requires OWASP Top 10 review
priority: high
dependencies: [task-1-001, task-1-002]
```

---

## How to Structure Delegation Prompts

### Template

```
CONTEXT: [What the parent task is trying to accomplish]
ROLE: [Who this agent is, e.g., "You are a security reviewer"]
TASK: [Specific request - be concrete and actionable]
TASK-ID: [Canonical task identifier]
INPUT: [What materials/documents to work with]
CONSTRAINTS: [Requirements, standards, boundaries]
OUTPUT FORMAT: [How results should be structured]
QUESTIONS TO ANSWER: [Numbered list of specific questions]
```

### Example - Delegating a Code Review

```
CONTEXT: We are building a user authentication system. This component handles login.
ROLE: You are a security-focused code reviewer.
TASK: Review the attached Login component for security vulnerabilities.
TASK-ID: task-3-015
INPUT: [file: auth/login.py]
CONSTRAINTS: Follow OWASP Top 10, no changes to code, report only
OUTPUT FORMAT: Numbered list of issues with severity (Critical/High/Medium/Low)
QUESTIONS TO ANSWER:
  1. What SQL injection risks exist?
  2. What password handling issues exist?
  3. What session management vulnerabilities exist?
```

---

## Delegation vs. Recommendation Protocol

### Recommendation Format

When an agent (other than Orchestrator) needs work done:

```
recommendation: delegate {task-id} to @agent-type
reason: [why this delegation is needed]
priority: [high|medium|low]
dependencies: [optional: list of dependent task IDs]
```

### Example Recommendations

```
recommendation: delegate task-3-020 to @code-intelligence
reason: Need to trace authentication flow through codebase
priority: high
dependencies: [task-1-005]
```

```
recommendation: delegate task-3-021 to @testing
reason: API changes require integration test coverage
priority: medium
dependencies: [task-3-018]
```

---

## How to Aggregate Results

### Aggregation Patterns

#### 1. Collection
- **Use when**: Results are already well-structured
- **Risk**: Inconsistencies between agent outputs
- **Method**: Gather all outputs, verify format consistency

#### 2. Synthesis
- **Use when**: Parts need to work together
- **Risk**: Loss of specialized nuance
- **Method**: Weave together findings into coherent whole

#### 3. Comparison
- **Use when**: Multiple agents reviewed same thing
- **Risk**: False equivalence of perspectives
- **Method**: Side-by-side analysis, highlight agreements/disagreements

#### 4. Priority Merge
- **Use when**: Issue lists from different angles
- **Risk**: Missing secondary concerns
- **Method**: Merge by priority level, preserve unique findings

### Phase-Based Aggregation

| Phase | Aggregator | Purpose |
|-------|------------|---------|
| 1 (Planner) | Planner | Synthesize findings into task breakdown |
| 2 (Architect) | Architect | Consolidate design decisions |
| 3-4 (Orchestrator) | Orchestrator | Final integration and delivery |

### Aggregation Checklist

- [ ] All delegated tasks completed?
- [ ] Task IDs referenced correctly?
- [ ] Results in agreed format?
- [ ] Conflicts between agents resolved?
- [ ] Gaps in coverage identified?
- [ ] Final output coherent and actionable?

---

## Delegation Flow Examples

### Direct Delegation Pattern

```
Orchestrator to Specialist:
─────────────────────────────────────────
TASK-ID: task-3-008
TASK: Perform security review of auth module
ROLE: Security specialist
INPUT: auth/login.py, auth/session.py
CONSTRAINTS: OWASP Top 10, report only, no changes
OUTPUT: Structured issue list
DEADLINE: Within 3 delegation turns
```

### Recommendation Response Pattern

```
Agent (e.g., Architect) to Orchestrator:
─────────────────────────────────────────
recommendation: delegate task-3-012 to @security
reason: Proposed auth design has not been reviewed for vulnerabilities
priority: high
dependencies: [task-2-001]

OR

recommendation: escalate task-2-003 to human
reason: Architectural decision with business implications beyond agent scope
priority: high
```

(End of file - total 175 lines)
