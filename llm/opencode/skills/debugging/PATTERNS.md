# Common Bug Patterns

## Pattern 1: Null/Undefined Handling

**Symptom**: `TypeError: Cannot read property 'x' of null/undefined`

**Root causes**:
- Missing null checks before access
- Assumed API returned valid data
- Destructuring from potentially null source
- Promise resolving to undefined

**Debugging approach**:
1. Find the exact line throwing
2. trace_data_flow on the variable
3. Find where it should have been validated
4. Check if caller/callee contract is violated

**Fix patterns**:
```typescript
// Before (brittle)
const name = user.profile.displayName;

// After (defensive)
const name = user?.profile?.displayName ?? 'Anonymous';

// Or validate at boundary
function getDisplayName(user: User): string {
  if (!user?.profile?.displayName) {
    throw new ValidationError('User must have display name');
  }
  return user.profile.displayName;
}
```

## Pattern 2: Async Race Conditions

**Symptom**: Intermittent failures, order-dependent behavior, "flaky" tests

**Root causes**:
- Not awaiting async operations
- Race between multiple async operations
- State modified during async iteration
- Missing cleanup on component unmount

**Debugging approach**:
1. Identify all async paths in the code
2. get_call_graph to see temporal dependencies
3. Check for shared mutable state
4. Look for missing/abused async primitives

**Fix patterns**:
```typescript
// Before (race condition)
let result: Data | null = null;
fetchData().then(data => result = data);
console.log(result); // Might be null!

// After (proper await)
const result = await fetchData();

// Or with concurrent operations
const [users, posts] = await Promise.all([
  fetchUsers(),
  fetchPosts()
]);
```

## Pattern 3: Memory Leaks

**Symptom**: Increasing memory usage over time, performance degradation, eventual crashes

**Root causes**:
- Event listeners not removed
- Closures holding references to large objects
- Caches growing unbounded
- Timers not cleared

**Debugging approach**:
1. Take heap snapshot at stable state
2. Trigger suspected leak scenario
3. Take another snapshot
4. Compare to find retained objects
5. trace_data_flow on the leaking objects

**Common leak patterns**:
```typescript
// Leak: Closure capturing large scope
function createHandler() {
  const largeData = loadLargeDataset(); // This stays in memory
  
  return () => {
    console.log(largeData); // largeData can't be GC'd
  };
}

// Leak: Unbounded cache
const cache = new Map();
function getData(key: string) {
  if (!cache.has(key)) {
    cache.set(key, fetchExpensiveData(key));
  }
  return cache.get(key);
  // Map grows forever!
}

// Fix: Use WeakMap or LRU cache
import { LRUCache } from 'lru-cache';
const cache = new LRUCache({ max: 100 });
```

## Pattern 4: API Contract Violations

**Symptom**: `TypeError: X is not a function`, unexpected data shapes, silent failures

**Root causes**:
- Assuming type without validation
- Different versions of API with incompatible contracts
- Mock/stub not matching real behavior

**Debugging approach**:
1. Get actual type/shape of data (console.log, schema validation)
2. Compare with expected contract
3. find_references to see how contract is assumed
4. Check for version mismatches

**Fix patterns**:
```typescript
// Before (trusting external data)
const users = response.data.users;
users.forEach(u => u.sendEmail()); // .sendEmail doesn't exist!

// After (validate at boundary)
interface ApiResponse {
  data: {
    users: User[];
  };
}

function validateResponse(resp: unknown): ApiResponse {
  if (!isApiResponse(resp)) {
    throw new ContractError('Invalid API response shape');
  }
  return resp;
}

const { data: { users } } = validateResponse(response);
```
