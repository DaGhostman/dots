# Debugging Workflow

## Step 1: Reproduce the Issue

**Goal**: Confirm the bug exists and understand its conditions.

- Find the minimal reproduction case
- Document exact steps to trigger the bug
- Note environment: OS, language version, dependencies, configuration
- Distinguish between symptoms and root causes

**Questions to answer**:
- Does it happen consistently or intermittently?
- Is there a specific input that triggers it?
- Does it happen in isolation or under load?

## Step 2: Gather Context

**Goal**: Build a complete picture of the failure.

Use these tools in parallel:

| Tool | Purpose |
|------|---------|
| `trace_data_flow` | Follow data from input to failure point |
| `find_references` | Locate all usages of the problematic element |
| `get_call_graph` | Map execution path to understand how you got there |
| `search_code` | Find similar patterns that might have the same bug |

**Collect**:
- Error messages (full stack traces)
- Logs leading up to the failure
- Relevant code sections
- Configuration/state at time of failure
- Recent changes (git log, diffs)

## Step 3: Form Hypotheses

**Goal**: Identify the most likely root causes.

Rank hypotheses by:
1. **Likelihood**: How probable is this cause given the evidence?
2. **Testability**: Can I confirm or refute this quickly?
3. **Impact**: If true, how much of the system does it affect?

**Typical hypothesis patterns**:
```
H1: Null/undefined passed where value expected
H2: Race condition in async code
H3: Wrong API contract assumed
H4: State corrupted earlier, failure is delayed symptom
```

## Step 4: Test Systematically

**Goal**: Confirm or reject hypotheses.

**Testing strategy**:
1. Start with cheapest/fastest tests
2. Add logging/instrumentation at hypothesis point
3. Isolate by disabling code paths
4. Compare with working state (git bisect if applicable)

**Verification techniques**:
- **Binary search**: Isolate half the code path, test, repeat
- **Differential testing**: Compare with known-good input
- **Instrumentation**: Add temporary logging at suspected failure point
- **Replay**: Use recorded inputs to reproduce

## Step 5: Fix and Verify

**Goal**: Apply minimal correct fix and confirm resolution.

**Fix criteria**:
- Addresses root cause, not just symptoms
- No new bugs introduced
- Handles edge cases the original missed

**Verification**:
1. Re-run reproduction case—should pass
2. Run existing tests
3. Check related functionality still works
4. Consider adding regression test

## Debugging Questions

Ask these questions in order when debugging:

### Reproducibility
- Can I reproduce this consistently?
- What's the minimal input to trigger it?
- Does it happen in isolation?

### Scope
- Where in the code does it fail?
- What's the call stack?
- What state exists at failure point?

### Data Flow
- Where did the data come from?
- Is the data valid at each step?
- Has the data been modified unexpectedly?

### Contracts
- What does the function expect?
- What does the caller expect?
- Do they match?

### Changes
- What changed recently?
- Does the bug coincide with any deployments?
- Can I bisect to a specific change?

### Environment
- Does it happen on all machines?
- Is there a version mismatch?
- Are there environment variables affecting behavior?
