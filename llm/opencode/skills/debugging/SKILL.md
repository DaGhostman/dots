---
name: debugging
description: Systematic debugging methodology for locating, isolating, and fixing bugs across codebases.
license: MIT
---

# Debugging Skill

A systematic approach to finding and fixing bugs. Follow this methodology rigorously—avoid guesswork, verify assumptions, and fix the root cause.

## Overview

**Core Principle**: Debugging is deduction, not guesswork. Every bug leaves traces—follow them methodically.

```
Issue Reported
     │
     ▼
Reproduce → Gather Context → Form Hypothesis → Test → Fix → Verify
     │                           │
     └───────────────────────────┘
        Iterate if needed
```

## Golden Rules

1. Never assume the bug is where you think it is
2. Always reproduce before debugging
3. Change one thing at a time
4. Verify your fix doesn't break other things

## Quick Reference

### Debugging Workflow (Details: [WORKFLOWS.md](WORKFLOWS.md))

| Step | Action | Key Activities |
|------|--------|----------------|
| 1 | Reproduce | Find minimal case, document steps |
| 2 | Gather Context | trace_data_flow, find_references, get_call_graph |
| 3 | Form Hypothesis | Rank by likelihood, testability, impact |
| 4 | Test Systematically | Binary search, instrument, isolate |
| 5 | Fix & Verify | Minimal fix, run tests, add regression |

### Tools Reference (Details: [TOOLS.md](TOOLS.md))

| Tool | Purpose |
|------|---------|
| `trace_data_flow` | Follow data from input to failure point |
| `find_references` | Locate all usages of problematic element |
| `get_call_graph` | Map execution path to understand how you got there |
| `search_code` | Find similar patterns that might have the same bug |

### Common Patterns (Details: [PATTERNS.md](PATTERNS.md))

- **Null/undefined**: Missing checks, assumed valid data → Add defensive access, validate at boundaries
- **Race conditions**: Unawaited async, shared mutable state → Ensure proper async handling
- **Memory leaks**: Unremoved listeners, unbounded caches → Find retained refs, use WeakMap/LRU
- **API violations**: Unvalidated external data → Validate shapes at boundaries

### Error Classification (Details: [ERRORS.md](ERRORS.md))

| Symptom | Likely Category | First Actions |
|---------|-----------------|---------------|
| Crash with stack trace | Synchronous error | Read trace, find origin line |
| Intermittent failures | Race condition | Add logging, check async paths |
| Memory grows unbounded | Memory leak | Heap profiling, find retained refs |
| Wrong output | Logic error | Trace data, verify assumptions |

### Practical Examples (Details: [EXAMPLES.md](EXAMPLES.md))

1. Mysterious Null Error - OAuth users missing 'id' field
2. Flaky Test - Race between test setup and execution
3. Memory Leak - WebSocket handlers not cleaned up
