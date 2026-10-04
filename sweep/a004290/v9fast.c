// Fast version of v9.c with early exit.  For d in [A, B), coprime to 10, j = floor(log10 d):
// walk the orbits of x -> 10x mod d, digit floor(10x/d).  Abort d as soon as an orbit has
// no 9 (then V <= 8) or a linear run of non-9 digits longer than 9j + T (then margin > T).
// Surviving d: print G (longest cyclic non-9 run over all orbits), margin = G - 9j, and
// emax = max(a,b) for the largest c = 2^a5^b with c*10^j < d (c in {1,2,4,5,8}),
// effective margin = margin - emax  (for n = c*(10^r-1)/d; see NOTES).
// usage: v9fast A B T
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char **argv) {
  long A = atol(argv[1]), B = atol(argv[2]); int T = atoi(argv[3]);
  long *vis = calloc(B + 1, sizeof(long)); int *digs = malloc(sizeof(int) * (B + 1));
  long surv = 0;
  for (long d = A < 3 ? 3 : A; d < B; d++) {
    if (d % 2 == 0 || d % 5 == 0) continue;
    int j = 0; long pj = 1; while (pj * 10 <= d) { pj *= 10; j++; }
    int lim = 9 * j + T;
    int ok = 1, G = 0;
    for (long t = 1; t < d && ok; t++) {
      if (vis[t] == d) continue;
      int len = 0, run = 0, has9 = 0; long y = t;
      do {
        vis[y] = d; int dg = (int)(10 * y / d); digs[len++] = dg;
        if (dg == 9) { has9 = 1; run = 0; } else if (++run > lim) { ok = 0; break; }
        y = y * 10 % d;
      } while (y != t);
      if (!ok) break;
      if (!has9) { ok = 0; break; }
      int best = 0; run = 0;
      for (int i = 0; i < 2 * len; i++) { if (digs[i % len] == 9) run = 0; else { run++; if (run > best) best = run; } }
      if (best > lim) { ok = 0; break; }
      if (best > G) G = best;
    }
    if (!ok) continue;
    surv++;
    int e = 0;
    if (8 * pj < d) e = 3; else if (4 * pj < d) e = 2; else if (2 * pj < d) e = 1;
    printf("d=%ld j=%d G=%d margin=%d emax=%d eff=%d\n", d, j, G, G - 9 * j, e, G - 9 * j - e);
  }
  fprintf(stderr, "range [%ld,%ld) T=%d: %ld survivors\n", A, B, T, surv);
  return 0;
}
