# Code Review Examples

Five practical review scenarios demonstrating the workflow.

---

## Example 1: Security Review - User Authentication

**Scenario:** Review authentication code for vulnerabilities.

```bash
# Find authentication-related files
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*auth*.ts", "query": "password|login|authenticate|token"}

# Check for password handling
tree-sitter-analyzer_search_content: {"roots": ["src/auth/"], "query": "bcrypt|hash|salt", "include_globs": ["*.ts", "*.js"]}

# Extract the auth implementation
tree-sitter-analyzer_extract_code_section: {"file_path": "src/auth/login.ts", "start_line": 1, "end_line": 100}
```

**Code found:**
```typescript
async function authenticate(email: string, password: string) {
  const user = await db.query(
    `SELECT * FROM users WHERE email = '${email}'`
  );
  
  if (user.password === password) {
    return generateToken(user);
  }
}
```

**Review findings:**

```
## Category: Security

### 🚨 CRITICAL: SQL Injection Vulnerability
**File:** `src/auth/login.ts`  
**Lines:** 10-15

**Problem:** User email is directly interpolated into SQL query.

**Code:**
```typescript
db.query(`SELECT * FROM users WHERE email = '${email}'`)
```

**Impact:** An attacker can inject SQL via the email parameter:
- Email: `' OR '1'='1` returns all users
- Could extract sensitive data, modify records, or drop tables

**Fix:**
```typescript
const user = await db.query(
  'SELECT * FROM users WHERE email = $1',
  [email]
);
```

**Severity:** 🚨 Blocking

---

### 🚨 CRITICAL: Plaintext Password Comparison
**File:** `src/auth/login.ts`  
**Lines:** 16-18

**Problem:** Passwords are stored and compared in plaintext.

**Code:**
```typescript
if (user.password === password) {
```

**Impact:** If database is compromised, all passwords are exposed. Also vulnerable to timing attacks.

**Fix:**
```typescript
import bcrypt from 'bcrypt';

const isValid = await bcrypt.compare(password, user.password_hash);
if (isValid) {
  return generateToken(user);
}
```

**Severity:** 🚨 Blocking - both issues must be fixed before merge.
```

---

## Example 2: Performance Review - Database Queries

**Scenario:** Review a data export feature for performance issues.

```bash
# Find export-related code
tree-sitter-analyzer_find_and_grep: {"roots": ["src/"], "pattern": "*export*.py", "query": "def.*export|for.*in.*query|SELECT|FROM"}

# Analyze structure
tree-sitter-analyzer_analyze_code_structure: {"file_path": "src/services/report_exporter.py", "format_type": "full"}
```

**Code found:**
```python
def export_orders(start_date, end_date):
    orders = Order.query.all()
    results = []
    
    for order in orders:
        if start_date <= order.created_at <= end_date:
            items = OrderItem.query.filter_by(order_id=order.id).all()
            order_data = {
                'id': order.id,
                'customer': order.customer.name,
                'items': [item.product.name for item in items],
                'total': sum(item.price for item in items)
            }
            results.append(order_data)
    
    return results
```

**Review findings:**

```
## Category: Performance

### 🚨 CRITICAL: N+1 Query Pattern
**File:** `src/services/report_exporter.py`  
**Lines:** 3-20

**Problem:** For each order, two additional queries are executed (OrderItem and customer).

**Code:**
```python
for order in orders:
    items = OrderItem.query.filter_by(order_id=order.id).all()
    order.customer.name  # Triggers lazy load
```

**Impact:** For 1000 orders, this executes 2000+ queries. Export will timeout.

**Fix:**
```python
def export_orders(start_date, end_date):
    orders = Order.query\
        .filter(Order.created_at.between(start_date, end_date))\
        .options(
            joinedload(Order.customer),
            joinedload(Order.items).joinedload(OrderItem.product)
        )\
        .all()
    
    results = [{
        'id': order.id,
        'customer': order.customer.name,
        'items': [item.product.name for item in order.items],
        'total': sum(item.price for item in order.items)
    } for order in orders]
    
    return results
```

**Severity:** 🚨 Blocking - Fix verified: now executes 1 query instead of 2000+.
```

---

## Example 3: Correctness Review - Business Logic

**Scenario:** Review discount calculation logic for edge cases.

```bash
# Find discount calculation
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "discount|calculate.*price|subtotal", "include_globs": ["*.ts", "*.js"]}

# Extract the pricing logic
tree-sitter-analyzer_extract_code_section: {"file_path": "src/pricing/calculator.ts", "start_line": 50, "end_line": 120}
```

**Code found:**
```typescript
function calculateDiscount(subtotal: number, discountPercent: number): number {
  return subtotal * (discountPercent / 100);
}

function applyDiscount(subtotal: number, discount: number): number {
  return subtotal - discount;
}

// Usage
const discount = calculateDiscount(cart.subtotal, 20);
const total = applyDiscount(cart.subtotal, discount);
```

**Review findings:**

```
## Category: Correctness

### ⚠️ MAJOR: Floating Point Precision Error
**File:** `src/pricing/calculator.ts`  
**Lines:** 1-10

**Problem:** Currency calculations using floating point can result in rounding errors.

**Code:**
```typescript
const discount = subtotal * (discountPercent / 100);
```

**Impact:** For large transactions, penny rounding errors accumulate.
- $99.99 * 0.1 = $9.999, not $10.00
- Over thousands of orders, discrepancies appear

**Fix:**
```typescript
function calculateDiscount(subtotal: number, discountPercent: number): number {
  // Convert to cents, calculate, convert back
  const subtotalCents = Math.round(subtotal * 100);
  const discountCents = Math.round(subtotalCents * discountPercent / 100);
  return discountCents / 100;
}
```

**Alternative:** Use a decimal library like `decimal.js` for precise currency math.

**Severity:** ⚠️ Major
```

---

## Example 4: Architecture Review - Code Organization

**Scenario:** Review a service class that seems to have too many responsibilities.

```bash
# Analyze the class structure
tree-sitter-analyzer_analyze_code_structure: {"file_path": "src/services/OrderService.ts", "format_type": "full"}

# Check complexity
tree-sitter-analyzer_check_code_scale: {"file_path": "src/services/OrderService.ts", "include_complexity": true, "include_guidance": true}
```

**Code found:**
```typescript
class OrderService {
  async createOrder() { /* ... */ }
  async cancelOrder() { /* ... */ }
  async refundOrder() { /* ... */ }
  
  async sendEmailConfirmation() { /* sends email */ }
  async generateInvoicePDF() { /* creates PDF */ }
  async uploadToS3() { /* uploads file */ }
  async logToAnalytics() { /* tracks event */ }
  
  async getFromDatabase() { /* raw SQL */ }
  async saveToDatabase() { /* raw SQL */ }
  async createSchema() { /* DDL */ }
}
```

**Review findings:**

```
## Category: Architecture

### ⚠️ MAJOR: God Class - Multiple Responsibilities
**File:** `src/services/OrderService.ts`  
**Lines:** 1-50

**Problem:** OrderService handles business logic AND infrastructure concerns.

**Violations:**
1. **SRP** - Should only handle order business logic
2. **Infrastructure mixing** - Email, S3, Analytics should be separate services
3. **Database abstraction leak** - Raw SQL in service layer

**Current structure:**
```typescript
class OrderService {
  async createOrder() { /* business logic */ }
  async sendEmailConfirmation() { /* email service */ }
  async uploadToS3() { /* storage service */ }
  async getFromDatabase() { /* repository */ }
}
```

**Suggested refactor:**
```typescript
// Services - handle business logic only
class OrderService {
  constructor(
    private orderRepository: OrderRepository,
    private emailService: EmailService,
    private storageService: StorageService,
    private analytics: AnalyticsService
  ) {}
  
  async createOrder(dto: CreateOrderDTO): Promise<Order> {
    const order = await this.orderRepository.create(dto);
    await this.emailService.sendConfirmation(order);
    await this.analytics.track('order_created');
    return order;
  }
}

// Infrastructure - handle external concerns
class EmailService { sendConfirmation() { /* ... */ } }
class StorageService { upload() { /* ... */ } }
class OrderRepository { /* SQL/ORM queries */ }
```

**Rationale:** 
- Each class has one reason to change
- Easier to test (inject mocks)
- Follows Dependency Inversion (high-level doesn't depend on low-level)

**Severity:** ⚠️ Major
```

---

## Example 5: Quick Security Audit

**Scenario:** Quick audit for common security issues in a PR.

```bash
# Set project path
tree-sitter-analyzer_set_project_path: {"project_path": "/path/to/project"}

# Check for hardcoded secrets
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "password.*=.*['\"]|secret.*=.*['\"]|api[_-]?key.*=.*['\"]", "case": "insensitive", "include_globs": ["*.ts", "*.js", "*.py"], "summary_only": true}

# Check for SQL concatenation
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "\\.format\\(.*SELECT|\\.format\\(.*INSERT|\\+.*WHERE", "include_globs": ["*.py"], "group_by_file": true}

# Check for eval usage
tree-sitter-analyzer_search_content: {"roots": ["src/"], "query": "eval\\(|new Function\\(|exec\\(|\\.replace\\(.*\\/", "include_globs": ["*.ts", "*.js"], "summary_only": true}
```

**Summary template:**

```
## Security Audit Summary

### Files Reviewed: 5
### Issues Found: 3

| Severity | Issue | File | Status |
|----------|-------|------|--------|
| 🚨 Blocking | SQL injection risk | `users.py:42` | Must fix |
| 🚨 Blocking | Hardcoded API key | `config.py:5` | Must fix |
| ⚠️ Major | eval() usage | `parser.js:23` | Should remove |

### Recommendations:
1. Use parameterized queries exclusively
2. Move secrets to environment variables
3. Replace eval() with safer alternatives (JSON.parse for JSON)
```
