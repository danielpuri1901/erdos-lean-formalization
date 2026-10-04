"""Independent re-check of the pairs conjecture on small ranges.
Implements CatchUp.valueAux literally on (remaining set, s_me, s_opp, isFirstMove),
with no gap reformulation, and the full-set values N <= 12."""
import sys
from functools import lru_cache
sys.setrecursionlimit(10000)
W, L, D = 'win', 'loss', 'draw'
def neg(o): return {W: L, L: W, D: D}[o]
def best(os):
    return W if W in os else (D if D in os else L)

@lru_cache(maxsize=None)
def value_aux(rem, s_me, s_opp, first):
    if not rem:
        return W if s_me > s_opp else (L if s_opp > s_me else D)
    if s_me + sum(rem) < s_opp:
        return L
    outs = []
    for x in rem:
        s2 = s_me + x
        r2 = rem - {x}
        if first or s2 >= s_opp:
            outs.append(neg(value_aux(r2, s_opp, s2, False)))
        else:
            outs.append(value_aux(r2, s2, s_opp, False))
    return best(outs)

def pair_unions(M, start=1):
    yield frozenset()
    for a in range(start, M):
        for rest in pair_unions(M, a + 2):
            yield frozenset({a, a + 1}) | rest

def main():
    M = int(sys.argv[1])
    print('full sets:', [value_aux(frozenset(range(1, n + 1)), 0, 0, True) for n in range(0, 13)])
    bad = tot = 0
    for R in pair_unions(M):
        k = len(R) // 2
        g = k % 2
        # gap g: opponent leads by g; start of a turn, not the first move unless g == 0
        r = value_aux(R, 0, g, g == 0)
        tot += 1
        if r != D:
            bad += 1
            print('violation', sorted(R), g, r)
    for R in pair_unions(M, 4):
        R3 = R | {1, 2, 3}
        k = len(R) // 2
        g = k % 2
        r = value_aux(R3, 0, g, g == 0)
        tot += 1
        if r != D:
            bad += 1
            print('violation', sorted(R3), g, r)
    print(f'pairs conjecture (both families) inside 1..{M}: {tot} sets, {bad} violations')

main()
