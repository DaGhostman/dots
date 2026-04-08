---
name: orchestration
description: Coordinate multiple specialized agents to accomplish complex tasks efficiently.
license: MIT
---

# Multi-Agent Orchestration

## Core Pattern

```
Orchestrator → Delegates to Specialists → Aggregates Results → Verifies → Delivers
```

## When to Orchestrate

| Use Orchestration | Avoid Orchestration |
|-------------------|-------------------|
| Multiple distinct skill sets needed | Simple atomic task |
| Independent work to parallelize | Overhead exceeds benefit |
| Quality requires independent verification | All knowledge in context |
| Complex task benefits from specialized focus | Time-critical single-path |

## Agent Types

| Agent | When to Use | Output |
|-------|-------------|--------|
| **planner** | Breaking down complex/multi-step tasks | Task breakdown, execution order, dependencies |
| **architect** | System design, technology choices | Design docs, component relationships, trade-offs |
| **developer** | Implementation, code writing | Working code, tests, documentation |
| **reviewer** | Code review, verification, bug finding | Issues list, suggestions, approval/rejection |
| **explorer** | Codebase research, finding patterns | Code locations, usage examples, relationships |
| **researcher** | External information, documentation | Summarized findings, references, facts |

## Delegation Selection Guide

```
Need understanding of existing code? → explorer
Need a plan? → planner
Need a design? → architect
Need implementation? → developer
Need verification? → reviewer
Need external knowledge? → researcher
```

## Effective Delegation Prompt

```
CONTEXT: [What the parent task is trying to accomplish]
ROLE: [Who this agent is]
TASK: [Specific request - concrete and actionable]
INPUT: [What materials/documents to work with]
CONSTRAINTS: [Requirements, standards, boundaries]
OUTPUT FORMAT: [How results should be structured]
QUESTIONS TO ANSWER: [Numbered list of specific questions]
```

## Loop Types

- **Check-in**: Regular status updates (every 3-5 turns)
- **Escalation**: Blockers get resolved by orchestrator
- **Revision**: Output refinement before acceptance
- **Validation**: Verify feasibility before proceeding

## Quality Principles

- Each subtask has explicit acceptance criteria
- Output format agreed before delegation
- Reviewer independent of developer
- Conflicts resolved with documented rationale

## Golden Rules

1. Delegate the "what", not the "how"
2. Trust but verify critical outputs
3. Over-communicate structure when in doubt
4. Aggregate with synthesis, not just collection
5. Document decisions for future reference

## Reference Materials

- [Delegation Patterns](./PATTERNS.md) - When to delegate, prompt structure, aggregation
- [Feedback Loops](./FEEDBACK.md) - Communication patterns, loop types, conflict resolution
- [Quality Assurance](./QUALITY.md) - Verification strategies, QA checklist
- [Example Workflows](./WORKFLOWS.md) - Complex feature, code review, research workflows
- [Anti-Patterns](./ANTI_PATTERNS.md) - What not to do and how to fix
