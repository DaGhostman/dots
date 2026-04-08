# Practical Debugging Examples

## Example 1: Mysterious Null Error

**Scenario**: User reports "Cannot read property 'id' of undefined" in production only.

**Debugging session**:
```
1. REPRODUCE
   - Ask user for exact steps
   - Try to reproduce with same user data
   - Realize: happens with users from OAuth login

2. GATHER CONTEXT
   - trace_data_flow("user.id", from="auth", to="error")
   - find_references("user.id")
   - Result: 15 places access user.id, 3 don't null-check

3. FORM HYPOTHESIS
   H1: OAuth users don't have 'id' field (different schema)
   H2: User object not loaded completely from DB
   H3: Race condition in user loading

4. TEST
   - Search code for OAuth user creation
   - Find: OAuth users have 'oauthId' not 'id'
   - Root cause: Code assumes all users have 'id'

5. FIX
   - Add schema validation at user creation
   - Add defensive access in display code
   - Add test for OAuth user flow
```

## Example 2: Flaky Test

**Scenario**: Integration test fails 20% of the time.

**Debugging session**:
```
1. REPRODUCE
   - Run test 10 times: 2 failures
   - Failures at different points

2. GATHER CONTEXT
   - get_call_graph on test flow
   - Look for async operations not awaited

3. FORM HYPOTHESIS
   H1: Race between test setup and test execution
   H2: Shared state from previous test leaking
   H3: External service timing out intermittently

4. TEST
   - Add 100ms delays before each assertion
   - Tests still fail, but differently distributed
   - Add shared state inspection
   - Find: global variable not reset between tests

5. FIX
   - Add beforeEach cleanup
   - Use local state instead of global
   - Run 50 times: 0 failures
```

## Example 3: Memory Leak in Service

**Scenario**: Node.js service memory grows ~1GB/day, requires daily restart.

**Debugging session**:
```
1. REPRODUCE
   - Run service with production load
   - Monitor memory: confirmed growth

2. GATHER CONTEXT
   - Heap snapshot at 1 hour
   - Heap snapshot at 2 hours
   - Compare: 500MB growth in event handlers

3. FORM HYPOTHESIS
   H1: WebSocket handlers not cleaned up
   H2: Growing cache without eviction
   H3: Closure capturing request context

4. TEST
   - trace_data_flow on WebSocket connections
   - find_references("websocket.on")
   - Find: handlers added on 'connection', never removed
   - Old connections' handlers still in memory

5. FIX
   - Add 'disconnect' handler to clean up
   - Implement connection tracking with limits
   - Monitor for 1 week: stable memory usage
```
