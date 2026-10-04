// Blow-ups of connected base graphs H on k <= 5 vertices: vertex i becomes an independent set
// (type 0) or a clique (type 1) of size w_i; adjacent classes are joined completely.
// Usage: blowup maxn mixed part nparts. Prints graphs with slack <= 0 and per-run stats.
#include "inv.h"
#include "canon.h"
static u64 *tab; static size_t tcap = 1 << 24;
static int insert(u64 key) { key += 1; size_t m = tcap - 1, i = mix(key) & m; while (tab[i]) { if (tab[i] == key) return 0; i = (i + 1) & m; } tab[i] = key; return 1; }
int maxn, mixed, part, np; long tested = 0, cnt = 0; int minslack = 99; long hist[8];
int k; u32 H[5]; int w[5], t[5];
static void eval(void) {
  int n = 0, start[5]; for (int i = 0; i < k; i++) { start[i] = n; n += w[i]; }
  if (n < 2) return;
  u32 a[32] = {0};
  for (int i = 0; i < k; i++) for (int x = 0; x < w[i]; x++) {
    int v = start[i] + x;
    if (t[i]) for (int y = 0; y < w[i]; y++) if (y != x) a[v] |= 1u << (start[i] + y);
    for (int j = 0; j < k; j++) if (H[i] >> j & 1) for (int y = 0; y < w[j]; y++) a[v] |= 1u << (start[j] + y);
  }
  // dedupe by canonical code only for n <= 11 (code fits 64 bits); otherwise by cheap key
  if (n <= 11) { if (!insert(canon(a, n) ^ ((u64)n << 58))) return; }
  if ((cnt++ % np) != part) return;
  tested++;
  int f = calc_f(a, n), b = calc_b(a, n), p = calc_p(a, n), s = 2 * f - b - p;
  if (s < minslack) minslack = s; if (s < 8) hist[s < 0 ? 0 : s]++;
  if (s <= 0) { printf("FOUND n=%d f=%d b=%d p=%d k=%d", n, f, b, p, k); for (int i = 0; i < k; i++) printf(" [%x w%d t%d]", H[i], w[i], t[i]); printf("\n"); fflush(stdout); }
}
static void rec_w(int i, int sum) {
  if (i == k) { int tmax = mixed ? (1 << k) : 1; for (int T = 0; T < tmax; T++) { for (int j = 0; j < k; j++) t[j] = T >> j & 1; eval(); } return; }
  for (int x = 1; sum + x + (k - i - 1) <= maxn; x++) { w[i] = x; rec_w(i + 1, sum + x); }
}
int main(int argc, char **argv) {
  maxn = atoi(argv[1]); mixed = atoi(argv[2]); part = atoi(argv[3]); np = atoi(argv[4]);
  tab = calloc(tcap, 8);
  for (k = 2; k <= 5; k++) {
    int m = k * (k - 1) / 2;
    for (u32 E = 0; E < (1u << m); E++) {
      memset(H, 0, sizeof H); int e = 0;
      for (int j = 1; j < k; j++) for (int i = 0; i < j; i++) { if (E >> e & 1) { H[i] |= 1u << j; H[j] |= 1u << i; } e++; }
      if (!connected(H, k)) continue;
      // keep one labelled copy per isomorphism class of H
      u32 c[MAXN]; memcpy(c, H, sizeof(u32) * k);
      if (canon(c, k) != canon(H, k)) continue;
      { u64 code = canon(H, k); u32 d[MAXN]; decode(code, k, d); int same = 1; for (int i = 0; i < k; i++) if (d[i] != H[i]) same = 0; if (!same) continue; }
      rec_w(0, 0);
    }
  }
  printf("maxn=%d mixed=%d part=%d tested=%ld minslack=%d hist0..4: %ld %ld %ld %ld %ld\n", maxn, mixed, part, tested, minslack, hist[0], hist[1], hist[2], hist[3], hist[4]);
  return 0;
}
