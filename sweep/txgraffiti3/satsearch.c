/* Search for an unsatisfiable 3-CNF on m variables with 4m/3 clauses, each clause on 3
   distinct variables, each literal occurring exactly twice. Such a formula gives a cubic
   graph in the extremal family (pair j = vertices 2j (+j), 2j+1 (-j); clause c = vertex
   2m+c adjacent to its literals) with mu* <= m and no independent dominating set made of
   one endpoint per pair. For each unsatisfiable formula found, i(G) is computed exactly
   (n = 10m/3 <= 64) and compared with m.
   Moves: swap two literal occurrences between clauses. Objective: number of satisfying
   assignments (minimise). Usage: satsearch m iters seed */
#include <stdio.h>
#include <stdlib.h>
#include "eval.h"

static int m, nc, L[64][3]; /* literal: +v -> 2v, -v -> 2v+1 */
static u64 rs;
static u64 rnd(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return rs; }

static int valid(void) {
  for (int c = 0; c < nc; c++)
    for (int a = 0; a < 3; a++) for (int b = a + 1; b < 3; b++)
      if (L[c][a] / 2 == L[c][b] / 2) return 0;
  return 1;
}
static long count_sat(long cap) {
  long cnt = 0;
  u64 pos[64], neg[64]; /* clause masks over variables */
  for (int c = 0; c < nc; c++) {
    pos[c] = neg[c] = 0;
    for (int a = 0; a < 3; a++) {
      int l = L[c][a];
      if (l & 1) neg[c] |= 1ULL << (l / 2); else pos[c] |= 1ULL << (l / 2);
    }
  }
  for (u64 x = 0; x < (1ULL << m); x++) {
    int ok = 1;
    for (int c = 0; c < nc; c++)
      if (!((pos[c] & x) | (neg[c] & ~x))) { ok = 0; break; }
    if (ok && ++cnt >= cap) return cnt;
  }
  return cnt;
}
static void graph(void) {
  N = 2 * m + nc; memset(ADJ, 0, sizeof ADJ);
  for (int j = 0; j < m; j++) { ADJ[2 * j] |= 1ULL << (2 * j + 1); ADJ[2 * j + 1] |= 1ULL << (2 * j); }
  for (int c = 0; c < nc; c++) for (int a = 0; a < 3; a++) {
    int v = L[c][a], u = 2 * m + c;
    ADJ[v] |= 1ULL << u; ADJ[u] |= 1ULL << v;
  }
}
int main(int argc, char **argv) {
  m = atoi(argv[1]); long iters = atol(argv[2]); rs = 0x9E3779B97F4A7C15ULL ^ (u64)atol(argv[3]) * 1000003ULL;
  nc = 4 * m / 3;
  int occ[256], no = 0;
  for (int v = 0; v < m; v++) for (int k = 0; k < 2; k++) { occ[no++] = 2 * v; occ[no++] = 2 * v + 1; }
  do {
    for (int k = no - 1; k > 0; k--) { int j = rnd() % (k + 1); int t = occ[k]; occ[k] = occ[j]; occ[j] = t; }
    for (int c = 0; c < nc; c++) for (int a = 0; a < 3; a++) L[c][a] = occ[3 * c + a];
  } while (!valid());
  if (argc > 4) { /* start from a graph file in the extremal format (pairs first) */
    FILE *fp = fopen(argv[4], "r"); int nn, ne, cc[64] = {0};
    if (!fp || fscanf(fp, "%d %d", &nn, &ne) != 2) return 1;
    for (int k = 0; k < ne; k++) { int a, b; if (fscanf(fp, "%d %d", &a, &b) != 2) return 1;
      if (k >= m) { int c = b - 2 * m; L[c][cc[c]++] = a; } }
    fclose(fp);
    if (!valid()) { fprintf(stderr, "invalid start\n"); return 1; }
  }
  long cur = count_sat(1L << 40), best = cur, found = 0;
  fprintf(stderr, "init sat=%ld\n", cur);
  for (long it = 0; it < iters; it++) {
    int c1 = rnd() % nc, a1 = rnd() % 3, c2 = rnd() % nc, a2 = rnd() % 3;
    if (c1 == c2) continue;
    int t = L[c1][a1]; L[c1][a1] = L[c2][a2]; L[c2][a2] = t;
    if (!valid()) { t = L[c1][a1]; L[c1][a1] = L[c2][a2]; L[c2][a2] = t; continue; }
    long s = count_sat(cur + 1);
    if (s <= cur || rnd() % 100 < 2) {
      cur = s;
      if (s < best) { best = s; fprintf(stderr, "it %ld best sat=%ld\n", it, best); }
      if (s == 0) {
        found++;
        graph();
        int i = indep_dom();
        printf("UNSAT formula #%ld: i=%d m=%d %s\n", found, i, m, i > m ? "COUNTEREXAMPLE-CANDIDATE" : "");
        printf("%d %d", N, m + 3 * nc);
        for (int j = 0; j < m; j++) printf(" %d %d", 2 * j, 2 * j + 1);
        for (int c = 0; c < nc; c++) for (int a = 0; a < 3; a++) printf(" %d %d", L[c][a], 2 * m + c);
        printf("\n"); fflush(stdout);
        if (i > m || found >= 20) return 0;
      }
    } else { t = L[c1][a1]; L[c1][a1] = L[c2][a2]; L[c2][a2] = t; }
  }
  printf("done best sat=%ld found=%ld\n", best, found);
  return 0;
}
