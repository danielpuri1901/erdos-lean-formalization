"""For n=5 and N in the Lean gap {18, 20..27}: count 5-sets containing 0 (translation
normalisation; pair witnesses are translation invariant) that have no pair witness
z + w = x + y (z != w, x, y not in {z, w}), and of those, how many have no 3-vs-3 witness."""
import itertools
def has_pair(A, N):
    for z, w in itertools.combinations(A, 2):
        for x in A:
            if x in (z, w): continue
            for y in A:
                if y in (z, w): continue
                if (z + w - x - y) % N == 0: return True
    return False
def has_any(A, N):
    n = len(A); S = sum(A) % N; c = 0
    for M in itertools.combinations_with_replacement(A, n):
        if sum(M) % N == S:
            c += 1
            if c > 1: return True
    return False
for N in [18] + list(range(20, 28)):
    nopair = [A for A in itertools.combinations(range(N), 5) if A[0] == 0 and not has_pair(A, N)]
    print(N, "5-sets with 0 and no pair witness:", len(nopair),
          "of which valid:", sum(not has_any(A, N) for A in nopair), "example:", nopair[:1])
