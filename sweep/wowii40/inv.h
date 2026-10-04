// Exact invariants for small graphs (n <= 20) given as adjacency bitmasks.
// f = largest induced forest, b = largest induced bipartite, p = min vertex-disjoint path cover.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef uint32_t u32;
typedef uint64_t u64;
#define POP __builtin_popcount

static int is_forest(const u32 *adj, int n, u32 S) {
  int e = 0, comps = 0;
  for (u32 T = S; T; T &= T - 1) { int v = __builtin_ctz(T); e += POP(adj[v] & S); }
  e /= 2;
  u32 rem = S;
  while (rem) {
    u32 comp = rem & -rem, fr = comp;
    while (fr) { u32 nf = 0; for (u32 T = fr; T; T &= T - 1) nf |= adj[__builtin_ctz(T)]; nf &= S & ~comp; comp |= nf; fr = nf; }
    rem &= ~comp; comps++;
  }
  return e == POP(S) - comps;
}

static int is_bip(const u32 *adj, int n, u32 S) {
  u32 rem = S, A = 0, B = 0;
  while (rem) {
    u32 st = rem & -rem, vis = st, fr = st; int side = 0; A |= st;
    while (fr) {
      u32 nf = 0; for (u32 T = fr; T; T &= T - 1) nf |= adj[__builtin_ctz(T)];
      nf &= S & ~vis; vis |= nf; side ^= 1; if (side) B |= nf; else A |= nf; fr = nf;
    }
    rem &= ~vis;
  }
  for (u32 T = A; T; T &= T - 1) if (adj[__builtin_ctz(T)] & A) return 0;
  for (u32 T = B; T; T &= T - 1) if (adj[__builtin_ctz(T)] & B) return 0;
  return 1;
}

static int calc_f(const u32 *adj, int n) {
  int best = 0; u32 full = (n == 32) ? ~0u : ((1u << n) - 1);
  for (u32 S = 0; S <= full; S++) { int c = POP(S); if (c > best && is_forest(adj, n, S)) best = c; if (S == full) break; }
  return best;
}
static int calc_b(const u32 *adj, int n) {
  int best = 0; u32 full = (1u << n) - 1;
  for (u32 S = 0; S <= full; S++) { int c = POP(S); if (c > best && is_bip(adj, n, S)) best = c; if (S == full) break; }
  return best;
}
// g[S*n+v] = min #paths covering S, last path ends at v (v in S).
static unsigned char *gbuf = 0; static size_t gcap = 0;
static int calc_p(const u32 *adj, int n) {
  size_t need = ((size_t)1 << n) * n;
  if (need > gcap) { gbuf = realloc(gbuf, need); gcap = need; }
  memset(gbuf, 255, need);
  for (int v = 0; v < n; v++) gbuf[((size_t)1 << v) * n + v] = 1;
  u32 full = (1u << n) - 1;
  for (u32 S = 1; S <= full; S++) {
    for (int v = 0; v < n; v++) {
      if (!(S >> v & 1)) continue;
      int val = gbuf[(size_t)S * n + v]; if (val == 255) continue;
      u32 out = full & ~S;
      for (u32 T = out; T; T &= T - 1) {
        int u = __builtin_ctz(T); u32 S2 = S | (1u << u);
        int nv = (adj[v] >> u & 1) ? val : val + 1;
        unsigned char *q = &gbuf[(size_t)S2 * n + u]; if (nv < *q) *q = nv;
      }
    }
    if (S == full) break;
  }
  int best = 255; for (int v = 0; v < n; v++) if (gbuf[(size_t)full * n + v] < best) best = gbuf[(size_t)full * n + v];
  return best;
}
static int connected(const u32 *adj, int n) {
  u32 full = (1u << n) - 1, vis = 1, fr = 1;
  while (fr) { u32 nf = 0; for (u32 T = fr; T; T &= T - 1) nf |= adj[__builtin_ctz(T)]; nf &= full & ~vis; vis |= nf; fr = nf; }
  return vis == full;
}
