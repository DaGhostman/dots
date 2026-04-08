# Anti-Patterns

## What NOT to Do

### 1. Over-Delegation (The "Meeting Scheduler")

```
Anti: Delegating trivial tasks that should be done directly
Cost: Coordination overhead exceeds task value
Example: Delegating "What files are in src?" to explorer agent
Fix: Do it directly; it's faster
```

### 2. Under-Delegation (The "Single Point of Failure")

```
Anti: Trying to do everything yourself despite expertise gaps
Cost: Suboptimal output, agent burnout
Example: Writing security-critical code without security review
Fix: Recognize when delegation adds value
```

### 3. Waterfall Delegation

```
Anti: Waiting for complete output before any parallel work
Cost: Serialized execution, no parallelism gains
Example: A researches → B researches → C implements (could be parallel)
Fix: Identify parallelizable phases upfront
```

### 4. Delegation Without Clear Outputs

```
Anti: "Look into X and get back to me"
Cost: Unfocused responses, rework, ambiguity
Example: No format, scope, or success criteria defined
Fix: Use structured prompt template every time
```

### 5. Ignoring Aggregated Conflicts

```
Anti: Two agents disagree, picking one without analysis
Cost: Lost perspective, unexamined assumptions
Example: "Just pick whichever approach you prefer"
Fix: Analyze conflicts, decide with rationale, document
```

### 6. Trust Without Verification

```
Anti: Accepting agent output without spot-checking
Cost: Errors propagate, quality issues
Example: Developer says "tests pass" but no verification
Fix: Always verify critical claims; spot-check routine ones
```

### 7. Monolithic Delegation

```
Anti: "Build the entire system" sent to one agent
Cost: Overwhelming context, diluted focus, inconsistent quality
Example: "Implement our new microservices architecture"
Fix: Break into focused components, delegate each separately
```

### 8. Feedback Avoidance

```
Anti: Skipping revision loops because of timeline pressure
Cost: Quality issues, technical debt
Example: "Ship it, we can fix in next sprint"
Fix: Distinguish critical vs nice-to-have revisions
```

---

## Quick Reference: Anti-Pattern Warning Signs

| Warning | Anti-Pattern |
|---------|--------------|
| "I'll just quickly do this myself" | Under-delegation |
| "Can you research X? No specific format" | Unclear delegation |
| "Let me check with everyone and get back to you" | No aggregation |
| "The specialist said it works" | Trust without verification |
| "All 47 files changed in one PR" | Monolithic delegation |
| "We don't have time for another review" | Feedback avoidance |
