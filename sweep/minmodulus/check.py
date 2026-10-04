"""Independent brute-force check, straight from the Lean definition:
A valid mod N iff the only size-#A multiset from A with sum = sum(A) mod N is A itself.
No symmetry reduction at all (every subset is tried)."""
import itertools, sys

def valid(A, N):
    n = len(A); S = sum(A) % N
    hits = 0
    for M in itertools.combinations_with_replacement(A, n):
        if sum(M) % N == S:
            hits += 1
            if hits > 1:
                return False
    return True

def exists(n, N):
    for A in itertools.combinations(range(N), n):
        if valid(A, N):
            return A
    return None

if __name__ == "__main__":
    for n, hi in [(2, 4), (3, 8), (4, 16), (5, 31)]:
        res = {N: exists(n, N) for N in range(n, hi + 1)}
        print(n, "valid N:", [N for N in res if res[N]], "first:", {N: res[N] for N in res if res[N]})
        sys.stdout.flush()
    for n in [6, 7]:
        A = [2**k - 1 for k in range(n)]
        N = 2**n - 2**(n.bit_length() - 1)
        print(n, N, "super-increasing valid at minModulus:", valid(A, N), "at N-1:", valid(A, N - 1))
