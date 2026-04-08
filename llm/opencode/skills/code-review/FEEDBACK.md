# Feedback Patterns

## Phrasing Review Comments

### Starting Phrases

- "Consider..."
- "It might be better to..."
- "What do you think about..."
- "This could be simplified by..."
- "I suggest..."

### Flagging Issues

- "This looks like a bug: ..."
- "There's a potential issue here: ..."
- "This could cause [problem]: ..."
- "I'm concerned about..."

### Asking for Clarification

- "Can you help me understand why..."
- "What's the reasoning behind..."
- "Is there a specific reason for..."

### Praising Good Work

- "Nice approach using..."
- "This is clean because..."
- "Good catch on the edge case!"

---

## Comment Templates

### Bug Report

```
### Issue: [Brief description]

**File:** `path/to/file`  
**Lines:** X-Y

**Problem:** [What the bug is]

**Suggested fix:** [How to fix it]

**Severity:** [Blocking/Major/Minor]
```

### Suggestion

```
### Suggestion: [Brief description]

**File:** `path/to/file`  
**Lines:** X-Y

**Current:** [Current code]

**Proposed:** [Alternative code]

**Rationale:** [Why this is better]
```

### Question

```
### Question: [What you're asking]

**File:** `path/to/file`  
**Lines:** X-Y

[Explanation of what you're trying to understand]

Is there a reason for...?
```

---

## Prioritization Guide

| When to use... | Example |
|----------------|---------|
| 🚨 Blocking | Security vulnerabilities, crashes, broken builds |
| ⚠️ Major | Logic bugs, data corruption risk, significant performance issues |
| 📝 Minor | Style improvements, small optimizations, documentation |
| 💡 Suggestion | "It might be nice to..." - not blocking, nice to have |

---

## Detailed Issue Template

```
## Category: [Security/Correctness/Performance/etc]

### 🚨/⚠️/📝/💡 [Issue Title]
**File:** `path/to/file`  
**Lines:** X-Y

**Problem:** [What the issue is]

**Code:**
```language
// problematic code
```

**Impact:** [Why this matters - be specific about consequences]

**Fix:**
```language
// fixed code
```

**Severity:** [Blocking/Major/Minor/Suggestion]

**Additional context:** [Optional - alternative approaches, related issues, etc]
```
