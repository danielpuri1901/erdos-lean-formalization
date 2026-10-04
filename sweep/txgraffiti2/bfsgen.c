// Exhaustive generation of connected subcubic graphs on n vertices, up to isomorphism
// with repetitions: every graph appears at least once, as a BFS labelling from a
// max-degree root in which each sibling group is sorted by nonincreasing degree.
// Each generated graph is tested for Z(G) <= alpha(G)+1 (K4 skipped).
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
typedef uint64_t u64;
static int n; static u64 adj[64], FULL; static int deg[64], par[64];
static long gen, fails, tight, k4;
static u64 closure(u64 S) {
  int ch = 1;
  while (ch) { ch = 0; u64 T = S;
    while (T) { int v = __builtin_ctzll(T); T &= T - 1; u64 W = adj[v] & ~S; if (W && !(W & (W - 1))) { S |= W; ch = 1; } } }
  return S;
}
static int best_a;
static void mis(u64 P, int cur) {
  if (!P) { if (cur > best_a) best_a = cur; return; }
  if (cur + __builtin_popcountll(P) <= best_a) return;
  int bv = -1, bd = 99; u64 T = P;
  while (T) { int v = __builtin_ctzll(T); T &= T - 1; int d = __builtin_popcountll(adj[v] & P); if (d < bd) { bd = d; bv = v; } }
  if (bd <= 1) { mis(P & ~(adj[bv] | (1ULL << bv)), cur + 1); return; }
  u64 C = (adj[bv] & P) | (1ULL << bv);
  while (C) { int u = __builtin_ctzll(C); C &= C - 1; mis(P & ~(adj[u] | (1ULL << u)), cur + 1); }
}
static int idx[64];
static int has_forcing(int k) {
  if (k >= n) return 1;
  for (int i = 0; i < k; i++) idx[i] = i;
  for (;;) {
    u64 S = 0; for (int i = 0; i < k; i++) S |= 1ULL << idx[i];
    int ok = 0; u64 T = S;
    while (T) { int v = __builtin_ctzll(T); T &= T - 1; u64 W = adj[v] & ~S; if (!(W & (W - 1))) { ok = 1; break; } }
    if (ok && closure(S) == FULL) return 1;
    int i = k - 1; while (i >= 0 && idx[i] == n - k + i) i--;
    if (i < 0) return 0;
    idx[i]++; for (int j = i + 1; j < k; j++) idx[j] = idx[j - 1] + 1;
  }
}
static int dumpmode, cubic;
static void test(void) {
  gen++;
  if (n == 4 && deg[0] == 3 && deg[1] == 3 && deg[2] == 3 && deg[3] == 3) { k4++; return; }
  if (dumpmode) { // print edge list for validation
    for (int a = 0; a < n; a++) for (int b = a + 1; b < n; b++) if (adj[a] >> b & 1) printf("%d-%d ", a, b);
    printf("\n"); return; }
  best_a = 0; mis(FULL, 0); int a = best_a;
  if (!has_forcing(a + 1)) { fails++; printf("FAIL alpha=%d: ", a); for (int x = 0; x < n; x++) for (int y = x + 1; y < n; y++) if (adj[x] >> y & 1) printf("%d-%d ", x, y); printf("\n"); fflush(stdout); }
}
static int next_label;
// sibling/degree constraints for processed vertex v (its degree is now final)
static int final_ok(int v) {
  if (deg[v] > deg[0]) return 0;
  if (cubic && deg[v] != 3) return 0;
  if (v > 1 && par[v] == par[v - 1] && deg[v - 1] < deg[v]) return 0;
  return 1;
}
static void process(int v);
// choose non-tree edges from v to existing unprocessed vertices u in (v, next_label), starting at u0
static void choose_nt(int v, int u0) {
  // option: stop adding non-tree edges, now choose number of children
  int room = 3 - deg[v];
  int maxc = room; if (maxc > n - next_label) maxc = n - next_label;
  for (int c = (v == 0 ? 1 : 0); c <= maxc; c++) {
    int save_next = next_label;
    for (int i = 0; i < c; i++) { int w = next_label++; par[w] = v; adj[v] |= 1ULL << w; adj[w] |= 1ULL << v; deg[v]++; deg[w] = 1; }
    if (final_ok(v)) process(v + 1);
    for (int i = 0; i < c; i++) { int w = --next_label; adj[v] &= ~(1ULL << w); adj[w] &= ~(1ULL << v); deg[v]--; deg[w] = 0; }
    (void)save_next;
  }
  if (v == 0) return;
  for (int u = u0; u < next_label; u++) {
    if (deg[v] >= 3) break;
    if (deg[u] >= 3 || (adj[v] >> u & 1)) continue;
    adj[v] |= 1ULL << u; adj[u] |= 1ULL << v; deg[v]++; deg[u]++;
    choose_nt(v, u + 1);
    adj[v] &= ~(1ULL << u); adj[u] &= ~(1ULL << v); deg[v]--; deg[u]--;
  }
}
static void process(int v) {
  if (v == n) { if (next_label == n) test(); return; }
  if (v >= next_label) return; // disconnected
  choose_nt(v, v + 1);
}
int main(int argc, char **argv) {
  n = atoi(argv[1]); dumpmode = argc > 3 || (argc > 2 && !strcmp(argv[2], "dump")); cubic = argc > 2 && !strcmp(argv[2], "cubic"); FULL = (1ULL << n) - 1;
  memset(adj, 0, sizeof adj); memset(deg, 0, sizeof deg);
  next_label = 1; par[0] = -1;
  if (n == 1) { test(); } else process(0);
  if (!dumpmode) printf("%sn=%d generated=%ld (k4 skipped=%ld) fails=%ld\n", cubic ? "cubic " : "", n, gen, k4, fails);
  return 0;
}
