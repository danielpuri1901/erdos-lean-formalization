// Extend each parent graph (n vertices, connected) by one new vertex in every nonempty way.
// Print children (canonical code, n+1 vertices) with slack = 2f-b-p <= T.
// Usage: ext parents.txt n T part nparts > out.txt
// Correctness of pruning: child slack >= parent slack + 2*df - 2, and df = 0 iff no maximum
// induced forest F of the parent stays acyclic after adding the new vertex.
#include "inv.h"
#include "canon.h"
int main(int argc, char **argv) {
  FILE *fi = fopen(argv[1], "r"); int n = atoi(argv[2]), T = atoi(argv[3]), part = atoi(argv[4]), np = atoi(argv[5]);
  char line[256]; long idx = 0, nout = 0, ntest = 0;
  static u32 forests[1 << 12]; static u32 fcomp[1 << 12][12]; static int fnc[1 << 12];
  while (fgets(line, sizeof line, fi)) {
    if (idx++ % np != part) continue;
    unsigned long long code; int f, b, p; sscanf(line, "%llx %d %d %d", &code, &f, &b, &p);
    int ps = 2 * f - b - p;
    u32 a[MAXN]; decode(code, n, a);
    // list maximum forests with component masks
    int nf = 0; u32 full = (1u << n) - 1;
    for (u32 S = 0; S <= full; S++) {
      if (POP(S) == f && is_forest(a, n, S)) {
        forests[nf] = S; int k = 0; u32 rem = S;
        while (rem) { u32 comp = rem & -rem, fr = comp;
          while (fr) { u32 nx = 0; for (u32 Q = fr; Q; Q &= Q - 1) nx |= a[__builtin_ctz(Q)]; nx &= S & ~comp; comp |= nx; fr = nx; }
          rem &= ~comp; fcomp[nf][k++] = comp; }
        fnc[nf] = k; nf++;
      }
      if (S == full) break;
    }
    for (u32 N = 1; N <= full; N++) {
      // df: does some max forest extend?
      int df = 0;
      for (int i = 0; i < nf && !df; i++) { int ok = 1; for (int k = 0; k < fnc[i]; k++) if (POP(N & fcomp[i][k]) > 1) { ok = 0; break; } if (ok) df = 1; }
      if (ps + 2 * df - 2 > T) continue;
      u32 c[MAXN]; memcpy(c, a, sizeof(u32) * n);
      for (int i = 0; i < n; i++) if (N >> i & 1) c[i] |= 1u << n;
      c[n] = N; ntest++;
      int f2 = f + df, b2 = calc_b(c, n + 1);
      if (2 * f2 - b2 - (p + 1) > T) continue;
      int p2 = calc_p(c, n + 1), s2 = 2 * f2 - b2 - p2;
      if (s2 <= T) { printf("%llx %d %d %d\n", (unsigned long long)canon(c, n + 1), f2, b2, p2); nout++; }
    }
  }
  fprintf(stderr, "part %d: parents=%ld tested=%ld out=%ld\n", part, idx, ntest, nout);
  return 0;
}
