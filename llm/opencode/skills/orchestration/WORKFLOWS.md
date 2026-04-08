# Example Workflows

## New Phase Architecture

```
Phase 1 (Planner)
      │
      ▼
Phase 2 (Architect)
      │
      ▼
Phase 3-4 (Orchestrator - delegation & integration)
```

---

## Complex Feature Implementation

**Scenario:** Add real-time notifications to an existing web app

```
PHASE 1: PLANNING
─────────────────────────────────────────────────────────────────
Planner:
  - Analyze feature request
  - Identify technical requirements
  - Create task breakdown with task IDs
  - Assign priorities

  Output: task-1-001 through task-1-NN
  └─ Backend tasks (WebSocket handler, notification service)
  └─ Frontend tasks (WebSocket hook, notification state)
  └─ API tasks (notification event types)
  └─ Testing tasks (unit, integration, e2e)


PHASE 2: ARCHITECT
─────────────────────────────────────────────────────────────────
Architect:
  - Review task breakdown from Planner
  - Design system architecture
  - Create component diagrams, data flows
  - Define API contracts
  - Review: Orchestrator reviews, approves/revises

  Output: task-2-001 (Architecture design)


PHASE 3: DELEGATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator delegates to Specialists (direct):

  @developer-backend:
    TASK-ID: task-3-001
    TASK: Implement WebSocket handler
    DEPENDS-ON: [task-2-001]

  @developer-frontend:
    TASK-ID: task-3-002
    TASK: Implement WebSocket hook and notification state
    DEPENDS-ON: [task-2-001]

  @testing:
    TASK-ID: task-3-003
    TASK: Write integration tests for notification flow
    DEPENDS-ON: [task-3-001, task-3-002]


PHASE 4: INTEGRATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator:
  - Aggregate all findings
  - Create prioritized issue list
  - Assign fixes
  - Verify fixes
  - Final integration test
  - Document decision log

  Output: task-4-001 (Final integration)
```

---

## Code Review with Multiple Concerns

**Scenario:** Large refactor touching auth, database, and API layers

```
PHASE 1: PLANNING
─────────────────────────────────────────────────────────────────
Planner:
  - Define review scope
  - Create task list with task IDs
  - Assign priorities

  task-1-001: Security review scope
  task-1-002: Performance review scope
  task-1-003: API compatibility review scope
  task-1-004: Code quality review scope


PHASE 2: ARCHITECT
─────────────────────────────────────────────────────────────────
Architect (if needed for complex decisions):
  - Review architectural implications
  - Validate approach with business constraints
  - Identify cross-cutting concerns


PHASE 3: DELEGATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator delegates to specialists (direct, no executor):

@security:
  TASK-ID: task-3-001
  TASK: Review auth changes for vulnerabilities
  FOCUS: OWASP Top 10, auth bypass, token handling

@performance:
  TASK-ID: task-3-002
  TASK: Review database changes for query efficiency
  FOCUS: N+1 queries, missing indexes, query plans

@api:
  TASK-ID: task-3-003
  TASK: Review API changes for backward compatibility
  FOCUS: Breaking changes, deprecation notices, versioning

@code-quality:
  TASK-ID: task-3-004
  TASK: General code quality review
  FOCUS: Error handling, logging, testability


PHASE 4: INTEGRATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator creates unified issue list:

  Critical:
    - [SEC-1] SQL injection in search query
    - [API-1] Breaking change to /users endpoint
  High:
    - [PERF-1] N+1 query in list view
    - [SEC-2] Missing rate limiting on auth endpoints
  ...

  Assign fixes, verify, approve final PR
```

---

## Research Task with Verification

**Scenario:** Evaluate third-party authentication provider for enterprise use

```
PHASE 1: PLANNING
─────────────────────────────────────────────────────────────────
Planner:
  - Define research criteria
  - Assign research tasks

  task-1-001: Technical capabilities research
  task-1-002: Pricing research
  task-1-003: Security certifications research
  task-1-004: User sentiment research


PHASE 2: ARCHITECT
─────────────────────────────────────────────────────────────────
Architect:
  - Define evaluation criteria weights
  - Validate research approach


PHASE 3: DELEGATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator delegates to specialists (direct):

@researcher:
  TASK-ID: task-3-001
  TASK: Research technical capabilities (Auth0 vs Okta vs Cognito)
  SOURCES: Official docs, comparison sites

  TASK-ID: task-3-002
  TASK: Research enterprise pricing tiers
  SOURCES: Pricing pages, sales inquiries, forums

@security:
  TASK-ID: task-3-003
  TASK: Verify security certifications and compliance
  SOURCES: Trust pages, certification databases

@researcher:
  TASK-ID: task-3-004
  TASK: Research real-world user experiences
  SOURCES: G2, Capterra, Reddit, Stack Overflow


PHASE 4: INTEGRATION (Orchestrator)
─────────────────────────────────────────────────────────────────
Orchestrator creates evaluation matrix:

  | Criteria          | Auth0 | Okta  | Cognito |
  |-------------------|-------|-------|---------|
  | Enterprise SSO     | ✓     | ✓     | Partial |
  | Pricing           | $$    | $$$   | $       |
  | SOC2              | ✓     | ✓     | ✓       |
  | User Sentiment    | 4.2   | 4.5   | 3.8     |

  Synthesize recommendation with rationale:
    - For enterprise with complex SSO needs: Okta
    - For startup with budget constraints: Cognito
    - For balanced needs: Auth0
```

---

## Escalation Workflow Example

**Scenario:** Agent encounters technical blocker during implementation

```
PHASE 3: DELEGATION (in progress)
─────────────────────────────────────────────────────────────────
@developer:
  TASK-ID: task-3-010
  TASK: Implement caching layer
  STATUS: blocked

  ESCALATION: technical
  DESCRIPTION: Two viable caching strategies with tradeoffs
    - Strategy A: Redis (simpler, external dependency)
    - Strategy B: In-memory (faster, not distributed)
  ATTEMPTS: 2

┌─────────────────────────────────────────────────────────────────┐
│                     ESCALATION ROUTING                          │
├─────────────────────────────────────────────────────────────────┤
│  Issue Type: Technical                                          │
│  Route to: Architect (Phase 2 handler)                          │
│                                                                 │
│  Architect receives:                                            │
│    TASK-ID: task-3-010                                          │
│    ISSUE: Caching strategy decision                            │
│    OPTIONS: [A] Redis [B] In-memory                             │
│                                                                 │
│  Architect analysis:                                            │
│    - Evaluate tradeoffs against requirements                   │
│    - Consider scalability needs                                 │
│    - Assess team expertise                                      │
│                                                                 │
│  Architect recommendation:                                       │
│    recommendation: choose Redis (Strategy A)                    │
│    reason: Enterprise scale needs distributed cache            │
│    priority: high                                               │
│                                                                 │
│  Orchestrator receives recommendation, approves:               │
│    DECISION: Strategy A (Redis)                                 │
│    TASK-UPDATE: task-3-010 unblocked                            │
└─────────────────────────────────────────────────────────────────┘

  @developer continues with approved approach
```

---

## Risk Escalation Workflow Example

**Scenario:** Agent identifies potential compliance risk

```
PHASE 3: DELEGATION (in progress)
─────────────────────────────────────────────────────────────────
@developer:
  TASK-ID: task-3-015
  TASK: Implement data export feature
  STATUS: risk-identified

  ESCALATION: risk
  DESCRIPTION: Proposed solution may violate data retention policy
  ATTEMPTS: 1

┌─────────────────────────────────────────────────────────────────┐
│                     RISK ESCALATION ROUTING                     │
├─────────────────────────────────────────────────────────────────┤
│  Issue Type: Risk                                               │
│  Route to: Red-team                                              │
│                                                                 │
│  Red-team receives:                                             │
│    TASK-ID: task-3-015                                          │
│    ISSUE: Data retention compliance                            │
│                                                                 │
│  Red-team assessment:                                           │
│    - Identified compliance gap: data retention policy           │
│    - Risk level: medium-high                                    │
│    - Recommendation: Add legal review step                     │
│                                                                 │
│  Red-team output:                                               │
│    recommendation: add task for legal review                    │
│    reason: Data handling requires compliance sign-off          │
│    priority: high                                              │
│                                                                 │
│  Orchestrator receives:                                         │
│    DECISION: Accept recommendation                              │
│    ACTION: Create task-3-016 for legal review                   │
│    TASK-3-015 blocked until task-3-016 complete                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Three-Attempt Auto-Resolution Example

**Scenario:** Planner attempts to resolve blocker but exhausts auto-resolution

```
┌─────────────────────────────────────────────────────────────────┐
│                   AUTO-RESOLUTION ATTEMPTS                       │
├─────────────────────────────────────────────────────────────────┤
│  Issue: Missing API specification for auth endpoints            │
│  Route to: Planner                                               │
│                                                                 │
│  ATTEMPT 1:                                                     │
│    Planner action: Check existing API docs                      │
│    Result: Not found                                            │
│    Status: unresolved                                           │
│                                                                 │
│  ATTEMPT 2:                                                     │
│    Planner action: Generate spec from code inspection           │
│    Result: Partial spec, missing edge cases                      │
│    Status: unresolved                                           │
│                                                                 │
│  ATTEMPT 3:                                                     │
│    Planner action: Request clarification from @developer       │
│    Result: Developer unavailable until tomorrow                 │
│    Status: unresolved                                           │
│                                                                 │
│  OUTCOME: HUMAN FALLBACK REQUIRED                               │
│                                                                 │
│  HUMAN ESCALATION REQUIRED                                      │
│  TASK-ID: task-1-005                                            │
│  ISSUE: Cannot proceed - auth API spec incomplete               │
│  ATTEMPTS MADE: 3                                                │
│  HANDLERS CONSULTED: [Planner]                                  │
│  STAKEHOLDER INPUT NEEDED: Provide auth API specification       │
└─────────────────────────────────────────────────────────────────┘
```

(End of file - total 240 lines)
