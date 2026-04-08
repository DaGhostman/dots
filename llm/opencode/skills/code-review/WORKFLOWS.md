# Review Workflow

Follow this systematic process for thorough reviews.

---

## Review Steps

### Step 1: Context Gathering

1. **Understand the business requirement**
   - What problem does this solve?
   - What are the acceptance criteria?

2. **Set scope**
   - Which files are affected?
   - What's the impact (API, data, performance)?

3. **Check existing patterns**
   - Are there similar implementations to follow?
   - What's the existing architecture?

```bash
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*user*.ts", "query": "UserService|userRepository"}
```

### Step 2: Automated Analysis

1. **Run static analysis tools** (if available)
   - Type checkers (TypeScript, mypy)
   - Linters (ESLint, Pylint)
   - Security scanners (Semgrep, Bandit)

2. **Use code intelligence tools**
   - Check complexity metrics
   - Find dead code
   - Trace dependencies

### Step 3: Manual Review by Category

**For each category, follow the checklists:**

1. **Correctness** - Logic, edge cases, error handling
2. **Security** - Injection, auth, validation, secrets
3. **Performance** - N+1, indexes, algorithms
4. **Maintainability** - Clarity, naming, documentation
5. **Architecture** - Coupling, SOLID, design patterns

### Step 4: Document Findings

Structure your review comments using the template in SKILL.md.

### Step 5: Verify Fixes

When requested, re-review fixed code:

1. Check the fix addresses the issue
2. Ensure no new issues introduced
3. Verify edge cases are handled

---

## Common Issues Checklists

### Python

| Category | Check |
|----------|-------|
| **Correctness** | `==` vs `is`, mutable default arguments, closure over loop variable |
| **Security** | `pickle.loads`, `eval`, SQL parameters, secrets in os.environ |
| **Performance** | List comprehensions vs generators, `.append()` in loops |
| **Style** | snake_case naming, docstrings, type hints |
| **Imports** | Relative vs absolute imports, unused imports |

**Common bugs:**

```python
# BUG: Mutable default argument
def add_item(item, items=[]):  # DANGER: shares across calls
def add_item(item, items=None):  # FIX: use None

# BUG: Closure over loop variable
funcs = [lambda: x for x in range(10)]  # All return 9!
funcs = [lambda x=x: x for x in range(10)]  # FIX: capture default

# BUG: Using == for None
if user.profile == None:  # May fail if __eq__ overridden
if user.profile is None:  # FIX: use is
```

---

### JavaScript/TypeScript

| Category | Check |
|----------|-------|
| **Correctness** | `===` vs `==`, `this` binding, async/await errors |
| **Security** | `eval`, `dangerouslySetInnerHTML`, XSS in templates |
| **Performance** | Array mutations, object spread in loops |
| **Style** | camelCase, const by default, explicit types |
| **Imports** | Named vs default imports, unused imports |

**Common bugs:**

```javascript
// BUG: Equality coercion
if (value == null) { }  // Allows both null and undefined
if (value === null) { } // Strict - only null

// BUG: Unhandled promise rejection
async function() {
  fetchData(); // Missing await!
}

// BUG: Mutating props
function UserCard({ user }) {
  user.name = user.name.toUpperCase(); // DANGER: mutates prop
}

// FIX: Create new object
function UserCard({ user }) {
  const normalizedUser = { ...user, name: user.name.toUpperCase() };
}
```

---

### SQL

| Category | Check |
|----------|-------|
| **Security** | Parameterized queries, input validation |
| **Performance** | Index usage, JOIN vs subquery, LIMIT |
| **Correctness** | NULL handling, transaction boundaries |
| **Style** | Consistent formatting, meaningful aliases |

**Common issues:**

```sql
-- BUG: Missing index on WHERE column
SELECT * FROM orders WHERE customer_id = 123;
-- Add: CREATE INDEX idx_orders_customer ON orders(customer_id);

-- BUG: SELECT * in application code
SELECT * FROM users; -- Returns too much data
SELECT id, email FROM users; -- Better: specific columns

-- BUG: N+1 in application
SELECT * FROM orders; -- Then loop: SELECT * FROM items WHERE order_id = ?
-- Better: JOIN or batch fetch
```
