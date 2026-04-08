---
name: code-review
description: Comprehensive guide for performing effective code reviews. Use when asked to review code, critique implementations, audit code quality, check for bugs/security/performance issues, or assess architectural decisions.
license: MIT
allowed-tools:
  - tree-sitter-analyzer_set_project_path
  - tree-sitter-analyzer_list_files
  - tree-sitter-analyzer_search_content
  - tree-sitter-analyzer_find_and_grep
  - tree-sitter-analyzer_query_code
  - tree-sitter-analyzer_extract_code_section
  - tree-sitter-analyzer_analyze_code_structure
  - tree-sitter-analyzer_check_code_scale
---

# Code Review Skill

A thorough, competent, and pedantic code reviewer ensuring code correctness, security, performance, and maintainability.

---

## Core Principles

1. **Review the code, not the person** - Critique implementation, not developer's competence
2. **Be specific and actionable** - Point to exact lines, explain why, suggest alternatives
3. **Prioritize issues** - Distinguish blocking from suggestions
4. **Understand context** - Consider business requirements, existing patterns, constraints
5. **Verify before commenting** - Use code intelligence tools to confirm understanding

---

## Severity Levels

| Severity | Symbol | When to Use |
|----------|--------|-------------|
| **Blocking** | 🚨 | Must fix before merge - bugs, security vulnerabilities, broken builds |
| **Major** | ⚠️ | Should fix - significant issues that could cause problems |
| **Minor** | 📝 | Nice to fix - style, readability, small optimizations |
| **Suggestion** | 💡 | Optional improvements - consider for future iterations |

---

## Review Focus Areas

| Area | Key Checks |
|------|------------|
| **Correctness** | Logic errors, edge cases, null handling, error handling, race conditions |
| **Security** | Injection vulnerabilities, auth/authorization, input validation, secrets management |
| **Performance** | N+1 queries, missing indexes, inefficient algorithms, memory leaks |
| **Maintainability** | Code clarity, naming, comments, duplication, function length, dead code |
| **Architecture** | Coupling, SOLID principles, dependency direction, abstraction levels |

---

## Quick Reference Checklist

- [ ] **Correctness**: Logic sound, edge cases handled, null checked, errors caught
- [ ] **Security**: No injection, auth enforced, no hardcoded secrets, input validated
- [ ] **Performance**: No N+1, pagination used, no O(n²) algorithms
- [ ] **Maintainability**: Clear naming, no duplication, comments explain "why"
- [ ] **Architecture**: Follows patterns, SRP respected, dependencies managed
- [ ] **Testing**: New code tested, existing tests pass

---

## Detailed References

- **[CATEGORIES.md](CATEGORIES.md)** - Detailed categories with patterns and examples
- **[TOOLS.md](TOOLS.md)** - Code intelligence tool usage guide
- **[WORKFLOWS.md](WORKFLOWS.md)** - Review workflow and language-specific checklists
- **[FEEDBACK.md](FEEDBACK.md)** - Comment phrasing and templates
- **[EXAMPLES.md](EXAMPLES.md)** - 5 practical review scenarios

---

## Comment Structure Template

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

**Impact:** [Why this matters]

**Fix:**
```language
// fixed code
```

**Severity:** [Blocking/Major/Minor/Suggestion]
```
