/* Local search for an r-regular graph with i(G) > mu*(G).
   mode 0 (extremal): vertices 0..2m-1 are m matched pairs (2j,2j+1); vertices 2m..n-1 form
     an independent set U; every pair vertex has r-1 neighbours in U, every U vertex has r
     neighbours among pair vertices. Then the pairs form a maximal matching, so mu* <= m.
     Objective: i(G) - m (a positive value is a counterexample candidate).
   mode 1 (general): random r-regular graph on n vertices, double edge swaps.
     Objective: i(G) - mu*(G).
   Moves: swap endpoints of two edges, keep simplicity (and the structure in mode 0).
   Accept if objective does not decrease. Usage: search mode r size iters seed */
#include <stdio.h>
#include <stdlib.h>
#include "eval.h"

static int EA[4096], EB[4096], NE;
static u64 rng_s;
static u64 rnd(void) { rng_s ^= rng_s << 13; rng_s ^= rng_s >> 7; rng_s ^= rng_s << 17; return rng_s; }

static int build_adj(void) {
  memset(ADJ, 0, sizeof ADJ);
  for (int k = 0; k < NE; k++) {
    int a = EA[k], b = EB[k];
    if (a == b || ((ADJ[a] >> b) & 1)) return 0;
    ADJ[a] |= 1ULL << b; ADJ[b] |= 1ULL << a;
  }
  return 1;
}

static int mode, R, M;
static int objective(void) {
  int i = indep_dom();
  if (mode == 0) return i - M;
  return i - sat_num();
}

static void init(void) {
  for (;;) {
    NE = 0;
    if (mode == 0) {
      int nu = 2 * M * (R - 1) / R;
      N = 2 * M + nu;
      int stubsA[2048], stubsB[2048], na = 0, nb = 0;
      for (int v = 0; v < 2 * M; v++) for (int k = 0; k < R - 1; k++) stubsA[na++] = v;
      for (int u = 0; u < nu; u++) for (int k = 0; k < R; k++) stubsB[nb++] = 2 * M + u;
      for (int k = nb - 1; k > 0; k--) { int j = rnd() % (k + 1); int t = stubsB[k]; stubsB[k] = stubsB[j]; stubsB[j] = t; }
      for (int j = 0; j < M; j++) { EA[NE] = 2 * j; EB[NE] = 2 * j + 1; NE++; }
      for (int k = 0; k < na; k++) { EA[NE] = stubsA[k]; EB[NE] = stubsB[k]; NE++; }
    } else {
      int st[4096], ns = 0;
      for (int v = 0; v < N; v++) for (int k = 0; k < R; k++) st[ns++] = v;
      for (int k = ns - 1; k > 0; k--) { int j = rnd() % (k + 1); int t = st[k]; st[k] = st[j]; st[j] = t; }
      for (int k = 0; k < ns; k += 2) { EA[NE] = st[k]; EB[NE] = st[k + 1]; NE++; }
    }
    if (build_adj()) return;
  }
}

int main(int argc, char **argv) {
  mode = atoi(argv[1]); R = atoi(argv[2]);
  int size = atoi(argv[3]); long iters = atol(argv[4]); rng_s = 88172645463325252ULL ^ (u64)atol(argv[5]) * 2654435761ULL;
  if (mode == 0) M = size; else N = size;
  init();
  int cur = objective(), best = cur;
  fprintf(stderr, "init obj %d n=%d\n", cur, N);
  int first = (mode == 0) ? M : 0; /* in mode 0 the matching edges are fixed */
  for (long it = 0; it < iters; it++) {
    int p = first + rnd() % (NE - first), q = first + rnd() % (NE - first);
    if (p == q) continue;
    int a = EA[p], b = EB[p], c0 = EA[q], d0 = EB[q];
    int c = c0, d = d0;
    /* mode 0: EA is the pair side, EB the U side; swap U endpoints */
    if (mode == 1 && (rnd() & 1)) { c = d0; d = c0; }
    EB[p] = d; EA[q] = c; EB[q] = b;
    if (!build_adj()) { EA[p] = a; EB[p] = b; EA[q] = c0; EB[q] = d0; build_adj(); continue; }
    int o = objective();
    if (o >= cur || (rnd() % 1000) < 5) {
      cur = o;
      if (o > best) { best = o; fprintf(stderr, "it %ld best %d\n", it, best); }
      if (o > 0) {
        printf("FOUND n=%d obj=%d\n%d %d", N, o, N, NE);
        for (int k = 0; k < NE; k++) printf(" %d %d", EA[k], EB[k]);
        printf("\n"); fflush(stdout); return 0;
      }
    } else {
      EA[p] = a; EB[p] = b; EA[q] = c0; EB[q] = d0; build_adj();
    }
  }
  printf("done best=%d final=%d n=%d\n", best, cur, N);
  return 0;
}
