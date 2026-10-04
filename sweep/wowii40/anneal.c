// Simulated annealing over connected graphs on n vertices minimising slack = 2f - b - p.
// Usage: anneal n seed seconds. Prints any graph with slack <= 0 as adjacency rows.
#include "inv.h"
#include <math.h>
#include <time.h>
static u64 rs; static u64 rnd(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return rs; }
static int slack(u32 *a, int n) { return 2 * calc_f(a, n) - calc_b(a, n) - calc_p(a, n); }
int main(int argc, char **argv) {
  int n = atoi(argv[1]); rs = 88172645463325252ULL ^ (u64)atoi(argv[2]) * 2654435761ULL; int secs = atoi(argv[3]);
  time_t t0 = time(0); long evals = 0; int globalmin = 99; long hist[8] = {0};
  while (time(0) - t0 < secs) {
    u32 a[32] = {0}; double pr = 0.15 + 0.5 * (rnd() % 1000) / 1000.0;
    do { memset(a, 0, sizeof a); for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) if ((rnd() % 1000) < pr * 1000) { a[i] |= 1u << j; a[j] |= 1u << i; } } while (!connected(a, n));
    int s = slack(a, n); evals++; double T = 1.0;
    for (int it = 0; it < 3000 && time(0) - t0 < secs; it++) {
      int i = rnd() % n, j = rnd() % n; if (i == j) continue;
      a[i] ^= 1u << j; a[j] ^= 1u << i;
      if (!connected(a, n)) { a[i] ^= 1u << j; a[j] ^= 1u << i; continue; }
      int s2 = slack(a, n); evals++;
      if (s2 <= s || (rnd() % 100000) / 100000.0 < exp(-(s2 - s) / T)) s = s2; else { a[i] ^= 1u << j; a[j] ^= 1u << i; }
      if (s < 8) hist[s < 0 ? 0 : s]++;
      if (s < globalmin) globalmin = s;
      if (s <= 0) { printf("FOUND n=%d slack=%d\n", n, s); for (int v = 0; v < n; v++) printf("%x\n", a[v]); fflush(stdout); }
      T *= 0.999; if (T < 0.15) T = 0.15;
    }
  }
  printf("n=%d evals=%ld min=%d visits slack0..3: %ld %ld %ld %ld\n", n, evals, globalmin, hist[0], hist[1], hist[2], hist[3]);
  return 0;
}
