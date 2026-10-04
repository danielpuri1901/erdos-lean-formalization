/* Exact i(G) and mu*(G) for graphs on at most 64 vertices (bitmask adjacency). */
#include <stdint.h>
#include <string.h>

typedef uint64_t u64;
static int N;
static u64 ADJ[64];

static int popc(u64 x) { return __builtin_popcountll(x); }

/* ---------- independent domination ---------- */
static int best_i;
static void idom(u64 dom, int sz) {
  u64 und = (N == 64 ? ~0ULL : ((1ULL << N) - 1)) & ~dom;
  if (!und) { if (sz < best_i) best_i = sz; return; }
  /* lower bound: each new vertex dominates at most maxdeg+1 undominated vertices */
  int maxc = 0;
  /* pick undominated v with fewest candidates (undominated vertices of N[v]) */
  int bv = -1, bc = 100;
  for (u64 t = und; t; t &= t - 1) {
    int v = __builtin_ctzll(t);
    u64 cand = (ADJ[v] | (1ULL << v)) & und;
    int c = popc(cand);
    if (c < bc) { bc = c; bv = v; }
    if (c > maxc) maxc = c;
  }
  int need = (popc(und) + maxc - 1) / maxc;
  if (sz + need >= best_i) return;
  u64 cand = (ADJ[bv] | (1ULL << bv)) & und;
  for (u64 t = cand; t; t &= t - 1) {
    int w = __builtin_ctzll(t);
    idom(dom | ADJ[w] | (1ULL << w), sz + 1);
  }
}
static int indep_dom(void) { best_i = N + 1; idom(0, 0); return best_i; }

/* ---------- saturation number (min maximal matching) ---------- */
static int best_m;
/* free: unmatched vertices; blocked: vertices decided to stay unmatched */
static void satm(u64 freev, u64 blocked, int sz) {
  /* edges with both ends free: greedy matching lower bound */
  u64 avail = freev;
  int f = 0;
  int pick = -1, pickc = 100;
  u64 all = freev;
  for (u64 t = all; t; t &= t - 1) {
    int v = __builtin_ctzll(t);
    u64 nb = ADJ[v] & freev;
    if (!nb) continue;
    /* vertex v free with free neighbour: an uncovered edge exists */
    if ((avail >> v) & 1) {
      u64 nb2 = ADJ[v] & avail & ~(1ULL << v);
      if (nb2) {
        int w = __builtin_ctzll(nb2);
        avail &= ~((1ULL << v) | (1ULL << w));
        f++;
      }
    }
  }
  if (f == 0) { if (sz < best_m) best_m = sz; return; }
  if (sz + (f + 1) / 2 >= best_m) return;
  /* forced: a blocked vertex with a free neighbour forces that neighbour to be matched */
  for (u64 t = blocked & freev; t; t &= t - 1) {
    int v = __builtin_ctzll(t);
    u64 nb = ADJ[v] & freev;
    if (nb) {
      int w = __builtin_ctzll(nb);
      if ((blocked >> w) & 1) return;
      u64 partners = ADJ[w] & freev & ~blocked;
      for (u64 s = partners; s; s &= s - 1) {
        int x = __builtin_ctzll(s);
        satm(freev & ~((1ULL << w) | (1ULL << x)), blocked, sz + 1);
      }
      return;
    }
  }
  /* choose a free unblocked vertex with free neighbours, fewest options */
  for (u64 t = freev & ~blocked; t; t &= t - 1) {
    int v = __builtin_ctzll(t);
    int c = popc(ADJ[v] & freev);
    if (c && c < pickc) { pickc = c; pick = v; }
  }
  if (pick < 0) return; /* unreachable */
  int u = pick;
  u64 partners = ADJ[u] & freev & ~blocked;
  for (u64 s = partners; s; s &= s - 1) {
    int x = __builtin_ctzll(s);
    satm(freev & ~((1ULL << u) | (1ULL << x)), blocked, sz + 1);
  }
  satm(freev, blocked | (1ULL << u), sz);
}
static int sat_num(void) {
  best_m = N;
  satm(N == 64 ? ~0ULL : ((1ULL << N) - 1), 0, 0);
  return best_m;
}

/* ---------- count distinct independent dominating sets of size <= bound (capped) ---------- */
static long cnt_sets, cnt_cap;
static int cnt_bound;
static void cdom(u64 dom, u64 excl, int sz) {
  if (cnt_sets >= cnt_cap) return;
  u64 und = (N == 64 ? ~0ULL : ((1ULL << N) - 1)) & ~dom;
  if (!und) { cnt_sets++; return; }
  if (sz >= cnt_bound) return;
  int bv = -1, bc = 100, maxc = 0;
  for (u64 t = und; t; t &= t - 1) {
    int v = __builtin_ctzll(t);
    u64 cand = (ADJ[v] | (1ULL << v)) & und & ~excl;
    int c = popc(cand);
    if (c == 0) return;
    if (c < bc) { bc = c; bv = v; }
    int cc = popc((ADJ[v] | (1ULL << v)) & und);
    if (cc > maxc) maxc = cc;
  }
  if (sz + (popc(und) + maxc - 1) / maxc > cnt_bound) return;
  u64 cand = (ADJ[bv] | (1ULL << bv)) & und & ~excl;
  for (u64 t = cand; t; t &= t - 1) {
    int w = __builtin_ctzll(t);
    cdom(dom | ADJ[w] | (1ULL << w), excl, sz + 1);
    excl |= 1ULL << w;
  }
}
static long count_idom(int bound, long cap) {
  cnt_sets = 0; cnt_cap = cap; cnt_bound = bound;
  cdom(0, 0, 0);
  return cnt_sets;
}
