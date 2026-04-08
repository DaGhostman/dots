# Code Review Categories

Detailed patterns and examples for each review focus area.

---

## 1. Correctness (Bugs & Edge Cases)

### What to Check
- **Logic errors** - Does code do what it's supposed to?
- **Off-by-one errors** - Array bounds, loop conditions, pagination
- **Null/undefined handling** - Are inputs validated before use?
- **Type coercion issues** - JavaScript truthy/falsy, Python `==` vs `is`
- **Race conditions** - Concurrent access to shared state
- **Error handling** - Are errors caught and handled appropriately?
- **Boundary conditions** - Empty inputs, maximum values, overflow

### Patterns to Search

```bash
# Missing null checks
tree-sitter-analyzer_search_content: query="\.value\.|\.length|\.toString\(\)", include_globs=["*.ts", "*.js"]

# Swallowed exceptions
tree-sitter-analyzer_search_content: query="catch.*\\{.*\\}|except.*pass", include_globs=["*.py"]
```

### Example Issues

```javascript
// BUG: Array bounds violation
function getItem(arr, index) {
  return arr[index + 1]; // Off-by-one: should be index
}

// BUG: Null reference
const name = user.profile.displayName; // profile might be null
const name = user?.profile?.displayName ?? 'Anonymous'; // Fixed

// BUG: Async without await
async function process() {
  fetchData(); // Promise ignored - should be await
  saveResult();
}
```

---

## 2. Security

### What to Check
- **Injection vulnerabilities** - SQL, NoSQL, OS, LDAP, XSS, Command injection
- **Authentication/Authorization** - Is auth properly enforced? Roles checked?
- **Input validation** - User inputs validated and sanitized?
- **Secrets management** - Credentials exposed in code?
- **Data exposure** - Sensitive fields redacted in logs/responses?
- **Cryptography** - Proper algorithms, secure random, key management

### Critical Patterns to Find

```bash
# SQL injection risk
tree-sitter-analyzer_search_content: query="SELECT.*\\+|INSERT.*\\+|executing.*template", include_globs=["*.py", "*.js"]

# Hardcoded secrets
tree-sitter-analyzer_search_content: query="password.*=|secret.*=|api[_-]?key.*=|token.*=.*['\\"]", case=insensitive

# Eval/code execution
tree-sitter-analyzer_search_content: query="eval\\(|new Function|exec\\(|system\\(", include_globs=["*.js", "*.py"]

# Path traversal
tree-sitter-analyzer_search_content: query="open\\(.*\\+|readFile\\(.*\\+", include_globs=["*.js", "*.py"]
```

### Security Checklist

| Category | Check | Search Pattern |
|----------|-------|----------------|
| SQL Injection | Parameterized queries only | `query|format.*%s\|format.*\{` |
| XSS | Output encoding | `innerHTML\|dangerouslySetInnerHTML` |
| Auth | Role checks present | `isAdmin\|hasPermission\|authorize` |
| Secrets | No hardcoded credentials | `password\|secret\|key.*=.*['"` |
| Paths | No user input in paths | `open\(.*\+.*request\|path\.join.*request` |
| Crypto | Proper algorithms | `md5\|sha1\|DES\|RC4` |

### Example Vulnerabilities

```javascript
// VULNERABLE: SQL injection
const query = `SELECT * FROM users WHERE id = ${userId}`;
db.query(query);

// SECURE: Parameterized query
const query = 'SELECT * FROM users WHERE id = $1';
db.query(query, [userId]);

// VULNERABLE: XSS
element.innerHTML = userInput;

// SECURE: Output encoding
element.textContent = userInput;

// VULNERABLE: Path traversal
const file = open('/uploads/' + filename);

// SECURE: Use whitelist
const file = open('/uploads/' + path.basename(filename));
```

---

## 3. Performance

### What to Check
- **N+1 queries** - Multiple database calls in loops
- **Missing indexes** - Slow queries on unindexed columns
- **Inefficient algorithms** - O(n²) when O(n) is possible
- **Memory leaks** - Unclosed connections, event listeners, caches
- **Unnecessary work** - Duplicate calculations, redundant iterations
- **Large data handling** - Pagination, streaming vs loading all in memory

### Patterns to Find

```bash
# N+1 queries - database calls in loops
tree-sitter-analyzer_find_and_grep: pattern="*.py", query="for.*in.*:|\\.filter\\(|\\.all\\(\\).*for"
tree-sitter-analyzer_find_and_grep: pattern="*.ts", query="forEach\\(|map\\(.*=.*await|\\.find\\(\\).*for"

# Missing pagination
tree-sitter-analyzer_search_content: query="\\.findAll\\(|\\.all\\(\\).*\\n.*for|\\.toArray\\(\\)", include_globs=["*.ts", "*.js"]

# Memory-intensive operations
tree-sitter-analyzer_search_content: query="JSON\\.stringify\\(.*large|\\.slice\\(0\\)|readFileSync", include_globs=["*.ts", "*.js", "*.py"]
```

### Performance Checklist

| Issue | Look For | Fix |
|-------|----------|-----|
| N+1 queries | Loops with DB calls | Batch queries, eager loading |
| Missing index | WHERE on unindexed cols | Add database index |
| O(n²) | Nested loops over same data | Hash maps, indexes |
| Memory leak | Unclosed streams, listeners | Proper cleanup, try/finally |
| Large payload | Returning full tables | Pagination, filtering |

### Example Issues

```python
# BUG: N+1 query
for user in users:
    print(user.profile.name)  # Each iteration hits DB!

# BETTER: Eager load
users = User.query.options(joinedload(User.profile)).all()
for user in users:
    print(user.profile.name)  # Single query
```

---

## 4. Maintainability

### What to Check
- **Code clarity** - Can you understand what/why/how from reading it?
- **Naming** - Descriptive and consistent?
- **Comments** - Necessary comments present? No commented-out code?
- **Documentation** - Public APIs documented? Complex logic explained?
- **Duplication** - Repeated code that should be extracted?
- **Function length** - Functions doing too much?
- **Dead code** - Unused imports, functions, variables?

### Patterns to Find

```bash
# Dead imports
tree-sitter-analyzer_search_content: query="^import.*{.*} from", include_globs=["*.ts", "*.js"]

# Long functions (flag for review)
tree-sitter-analyzer_check_code_scale: file_path="<file>", metrics_only=true

# TODO comments
tree-sitter-analyzer_search_content: query="TODO:|FIXME:|HACK:|XXX:", include_globs=["*.ts", "*.js", "*.py"]

# Magic numbers
tree-sitter-analyzer_search_content: query="[0-9]{3,}", include_globs=["*.ts", "*.js", "*.py"]
```

### Maintainability Checklist

| Aspect | Good | Bad |
|--------|------|-----|
| Function names | `getUserById`, `calculateTotal` | `get`, `process` |
| Variables | `maxRetries`, `createdAt` | `x`, `data`, `temp` |
| Comments | Explains WHY, not WHAT | `// increment i` |
| Functions | Single responsibility | 200-line functions |
| Constants | Named constants | `if (status === 1)` |
| Duplication | Extracted utility | Copy-pasted code |

### Example Issues

```python
# BAD: Magic numbers, unclear logic
def process(n):
    if n > 86400:
        return n // 60
    return n * 2

# BETTER: Self-documenting
SECONDS_PER_MINUTE = 60
MAX_SESSION_DURATION_SECONDS = 86400

def calculate_timeout(duration_seconds):
    if duration_seconds > MAX_SESSION_DURATION_SECONDS:
        return duration_seconds // SECONDS_PER_MINUTE
    return duration_seconds * 2
```

---

## 5. Architecture

### What to Check
- **Coupling** - Are modules tightly coupled to implementation details?
- **SOLID principles** - Single responsibility, Open/closed, Liskov substitution, Interface segregation, Dependency inversion
- **Dependency direction** - High-level modules shouldn't depend on low-level modules
- **Abstraction levels** - Mixing concerns (DB with business logic)
- **Error handling strategy** - Consistent across the codebase
- **API design** - Clean and intuitive interfaces?

### Patterns to Find

```bash
# God classes/files - too many responsibilities
tree-sitter-analyzer_check_code_scale: file_path="<file>", include_complexity=true

# Circular dependencies
tree-sitter-analyzer_find_and_grep: pattern="*.ts", query="from ['\\"]\.\./|from ['\\"]\.\/"
```

### SOLID Principles Checklist

| Principle | Check | Suggestion |
|-----------|-------|------------|
| **SRP** | Does this class/function have one reason to change? | Split if doing multiple things |
| **OCP** | Is code open for extension, closed for modification? | Use strategy pattern |
| **LSP** | Can subclasses replace parents without breaking? | Fix inheritance issues |
| **ISP** | Are interfaces small and focused? | Split fat interfaces |
| **DIP** | Do high-level modules depend on abstractions? | Inject dependencies |

### Example Issues

```typescript
// BAD: God class - too many responsibilities
class UserManager {
    validateUser() { ... }
    authenticateUser() { ... }
    sendEmail() { ... }
    generateReport() { ... }
    connectToDatabase() { ... }
}

// BETTER: Single responsibility
class UserValidator { validateUser() { ... } }
class UserAuthenticator { authenticateUser() { ... } }
class EmailService { sendEmail() { ... } }
class ReportGenerator { generateReport() { ... } }
```
