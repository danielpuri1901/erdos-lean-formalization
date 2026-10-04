// Zero forcing number vs independence number for subcubic graphs.
// Graphs are stored as uint64 adjacency masks (n <= 64).
// Modes:
//   zf rand  n samples seed cubicflag   : random (sub)cubic graphs, test Z <= alpha+1
//   zf climb n iters  seed              : hill-climb over cubic graphs maximising Z - alpha
//   zf g6 < file                        : read graph6 lines, print n alpha Z
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

typedef uint64_t u64;
static int n;
static u64 adj[64];

static u64 rng_state;
static u64 rnd(void) { rng_state ^= rng_state << 13; rng_state ^= rng_state >> 7; rng_state ^= rng_state << 17; return rng_state; }

// zero forcing closure (order independent)
static u64 closure(u64 S) {
  int changed = 1;
  while (changed) {
    changed = 0;
    u64 T = S;
    while (T) {
      int v = __builtin_ctzll(T); T &= T - 1;
      u64 W = adj[v] & ~S;
      if (W && !(W & (W - 1))) { S |= W; changed = 1; }
    }
  }
  return S;
}

static u64 FULL;

// maximum independent set size, simple branching on max-degree vertex
static int best_a;
static void mis_rec(u64 P, int cur) {
  if (!P) { if (cur > best_a) best_a = cur; return; }
  if (cur + __builtin_popcountll(P) <= best_a) return;
  // pick vertex with min degree in P; if deg <= 1 take it greedily
  int bv = -1, bd = 99;
  u64 T = P;
  while (T) { int v = __builtin_ctzll(T); T &= T - 1; int d = __builtin_popcountll(adj[v] & P); if (d < bd) { bd = d; bv = v; } }
  if (bd <= 1) { mis_rec(P & ~(adj[bv] | (1ULL << bv)), cur + 1); return; }
  // branch: take bv, or take one of its neighbours (some vertex of N[bv] is in any MIS-maximal set)
  u64 C = (adj[bv] & P) | (1ULL << bv);
  while (C) { int u = __builtin_ctzll(C); C &= C - 1; mis_rec(P & ~(adj[u] | (1ULL << u)), cur + 1); }
}
static int alpha(void) { best_a = 0; mis_rec(FULL, 0); return best_a; }

// does some k-subset force? enumerate k-subsets lexicographically with early exit
static int idx[64];
static int has_forcing(int k) {
  if (k >= n) return 1;
  if (k <= 0) return n == 0;
  for (int i = 0; i < k; i++) idx[i] = i;
  for (;;) {
    u64 S = 0; for (int i = 0; i < k; i++) S |= 1ULL << idx[i];
    // quick filter: some vertex in S must have <=1 white neighbour
    int ok = 0; u64 T = S;
    while (T) { int v = __builtin_ctzll(T); T &= T - 1; u64 W = adj[v] & ~S; if (!(W & (W - 1))) { ok = 1; break; } }
    if (ok && closure(S) == FULL) return 1;
    int i = k - 1;
    while (i >= 0 && idx[i] == n - k + i) i--;
    if (i < 0) return 0;
    idx[i]++;
    for (int j = i + 1; j < k; j++) idx[j] = idx[j - 1] + 1;
  }
}

static int zf_number(void) {
  // monotone: find least k with forcing k-set
  int lo = 1;
  for (int k = lo; k <= n; k++) if (has_forcing(k)) return k;
  return n;
}

static int connected(void) {
  u64 seen = 1, fr = 1;
  while (fr) { u64 nf = 0; u64 T = fr; while (T) { int v = __builtin_ctzll(T); T &= T - 1; nf |= adj[v]; } nf &= ~seen; seen |= nf; fr = nf; }
  return seen == FULL;
}

// random cubic multigraph by pairing; reject loops/multi-edges
static int random_cubic(void) {
  int pts[192]; int m = 3 * n;
  for (int tries = 0; tries < 100000; tries++) {
    for (int i = 0; i < m; i++) pts[i] = i / 3;
    for (int i = m - 1; i > 0; i--) { int j = rnd() % (i + 1); int t = pts[i]; pts[i] = pts[j]; pts[j] = t; }
    memset(adj, 0, sizeof adj);
    int bad = 0;
    for (int i = 0; i < m; i += 2) {
      int a = pts[i], b = pts[i + 1];
      if (a == b || (adj[a] >> b & 1)) { bad = 1; break; }
      adj[a] |= 1ULL << b; adj[b] |= 1ULL << a;
    }
    if (!bad && connected()) return 1;
  }
  return 0;
}

// random subcubic: random cubic then delete random edges with prob p
static void delete_edges(double p) {
  for (int a = 0; a < n; a++) for (int b = a + 1; b < n; b++) if (adj[a] >> b & 1) {
    if ((rnd() % 1000000) < p * 1000000) { adj[a] &= ~(1ULL << b); adj[b] &= ~(1ULL << a); }
  }
}

static void print_g(FILE *f) {
  for (int a = 0; a < n; a++) for (int b = a + 1; b < n; b++) if (adj[a] >> b & 1) fprintf(f, "%d-%d ", a, b);
  fprintf(f, "\n");
}


static int deg[64]; static int pa[64*64], pb[64*64], np_;
static long all_cnt, all_fail, all_tight;
static void all_rec(int e) {
  if (e == np_) {
    if (!connected()) return;
    int a = alpha(); all_cnt++;
    if (!has_forcing(a + 1)) { all_fail++; printf("FAIL: "); print_g(stdout); }
    else if (!has_forcing(a)) all_tight++;
    return;
  }
  all_rec(e + 1);
  int x = pa[e], y = pb[e];
  if (deg[x] < 3 && deg[y] < 3) {
    deg[x]++; deg[y]++; adj[x] |= 1ULL << y; adj[y] |= 1ULL << x;
    all_rec(e + 1);
    deg[x]--; deg[y]--; adj[x] &= ~(1ULL << y); adj[y] &= ~(1ULL << x);
  }
}
int main(int argc, char **argv) {
  if (argc < 2) return 1;
  if (!strcmp(argv[1], "all")) {
    n = atoi(argv[2]); FULL = (1ULL << n) - 1; np_ = 0; memset(adj,0,sizeof adj);
    for (int a = 0; a < n; a++) for (int b = a + 1; b < n; b++) { pa[np_] = a; pb[np_] = b; np_++; }
    all_rec(0);
    printf("labelled n=%d connected subcubic=%ld tight=%ld fails=%ld\n", n, all_cnt, all_tight, all_fail);
    return 0;
  }
  if (!strcmp(argv[1], "g6")) {
    char line[1024];
    long cnt = 0, fails = 0;
    while (fgets(line, sizeof line, stdin)) {
      int len = strlen(line); while (len && (line[len - 1] == '\n' || line[len - 1] == '\r')) line[--len] = 0;
      if (!len) continue;
      n = line[0] - 63; memset(adj, 0, sizeof adj);
      int bit = 0; int pos = 1;
      for (int j = 1; j < n; j++) for (int i = 0; i < j; i++) {
        int byte = line[pos + bit / 6] - 63; int b = (byte >> (5 - bit % 6)) & 1; bit++;
        if (b) { adj[i] |= 1ULL << j; adj[j] |= 1ULL << i; }
      }
      FULL = (n == 64) ? ~0ULL : ((1ULL << n) - 1);
      int a = alpha(), z = zf_number();
      cnt++;
      if (z > a + 1) { fails++; printf("FAIL %s n=%d alpha=%d Z=%d\n", line, n, a, z); }
      if (argc > 2) printf("%s %d %d %d\n", line, n, a, z);
    }
    printf("graphs=%ld fails=%ld\n", cnt, fails);
    return 0;
  }
  if (!strcmp(argv[1], "rand")) {
    n = atoi(argv[2]); long samples = atol(argv[3]); rng_state = strtoull(argv[4], 0, 10) * 2654435761ULL + 88172645463325252ULL;
    double p = atof(argv[5]);
    FULL = (n == 64) ? ~0ULL : ((1ULL << n) - 1);
    long tested = 0, tight = 0, fails = 0;
    for (long s = 0; s < samples; s++) {
      if (!random_cubic()) continue;
      if (p > 0) { delete_edges(p); if (!connected()) continue; }
      int a = alpha();
      tested++;
      if (!has_forcing(a + 1)) {
        fails++; printf("FAIL n=%d alpha=%d: ", n, a); print_g(stdout); fflush(stdout);
      } else if (!has_forcing(a)) tight++;
    }
    printf("n=%d p=%.3f tested=%ld tight(Z=alpha+1)=%ld fails=%ld\n", n, p, tested, tight, fails);
    return 0;
  }
  if (!strcmp(argv[1], "climb")) {
    n = atoi(argv[2]); long iters = atol(argv[3]); rng_state = strtoull(argv[4], 0, 10) * 2654435761ULL + 88172645463325252ULL;
    FULL = (n == 64) ? ~0ULL : ((1ULL << n) - 1);
    int bestever = -100;
    for (int restart = 0; restart < 1000000 && iters > 0; restart++) {
      random_cubic();
      int a = alpha(); int z = zf_number(); int cur = z - a;
      for (int it = 0; it < 400 && iters > 0; it++, iters--) {
        // double edge swap: edges ab, cd -> ac, bd
        u64 save[64]; memcpy(save, adj, sizeof save);
        int a1, b1, c1, d1;
        for (;;) {
          a1 = rnd() % n; u64 N = adj[a1]; int k = rnd() % 3; for (int t = 0; t < k; t++) N &= N - 1; b1 = __builtin_ctzll(N);
          c1 = rnd() % n; N = adj[c1]; k = rnd() % 3; for (int t = 0; t < k; t++) N &= N - 1; d1 = __builtin_ctzll(N);
          if (a1 == c1 || a1 == d1 || b1 == c1 || b1 == d1) continue;
          if (adj[a1] >> c1 & 1 || adj[b1] >> d1 & 1) continue;
          break;
        }
        adj[a1] &= ~(1ULL << b1); adj[b1] &= ~(1ULL << a1); adj[c1] &= ~(1ULL << d1); adj[d1] &= ~(1ULL << c1);
        adj[a1] |= 1ULL << c1; adj[c1] |= 1ULL << a1; adj[b1] |= 1ULL << d1; adj[d1] |= 1ULL << b1;
        if (!connected()) { memcpy(adj, save, sizeof save); continue; }
        int a2 = alpha(); int z2 = zf_number(); int v = z2 - a2;
        if (v >= cur || (rnd() % 10) == 0) { cur = v; } else { memcpy(adj, save, sizeof save); }
        if (cur > bestever) { bestever = cur; printf("n=%d best Z-alpha=%d (Z=%d a=%d): ", n, cur, z2, a2); print_g(stdout); fflush(stdout); }
        if (cur >= 2) { printf("FAIL candidate\n"); print_g(stdout); fflush(stdout); }
      }
    }
    printf("n=%d done bestever=%d\n", n, bestever);
    return 0;
  }
  return 0;
}
