// For d coprime to 10 with p = ord_d(10) <= P: decide whether every orbit of x -> 10x mod d
// (x = 1..d-1) has a digit 9 among the digits floor(10x/d) (the "V = 9" case), and if so
// compute G = max over orbits of the longest cyclic run of non-9 digits.
// For n = (10^r - 1)/d (p | r, r large) the NOTES derive len(a(n)) = 9r - G and
// k(n) = r - j with j = floor(log10 d), so margin 9k - len = G - 9j.  margin <= 0 is a candidate.
// usage: v9 D P
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef MPRINT
#define MPRINT 8
#endif
int main(int argc, char **argv) {
  long D = atol(argv[1]); int P = atoi(argv[2]);
  unsigned char *vis = malloc(D + 1);
  int *digs = malloc(sizeof(int) * (D + 1));
  long cnt = 0, nv9 = 0; int bestm = 1 << 30;
  for (long d = 3; d <= D; d++) {
    if (d % 2 == 0 || d % 5 == 0) continue;
    long x = 10 % d; int p = 1;
    while (x != 1 && p <= P) { x = x * 10 % d; p++; }
    if (p > P) continue;
    cnt++;
    memset(vis, 0, d);
    int ok = 1, G = 0;
    for (long t = 1; t < d && ok; t++) {
      if (vis[t]) continue;
      int len = 0; long y = t;
      do { vis[y] = 1; digs[len++] = (int)(10 * y / d); y = y * 10 % d; } while (y != t);
      int has9 = 0; for (int i = 0; i < len; i++) if (digs[i] == 9) has9 = 1;
      if (!has9) { ok = 0; break; }
      // longest cyclic run of non-9 digits
      int run = 0, best = 0;
      for (int i = 0; i < 2 * len; i++) { if (digs[i % len] == 9) run = 0; else { run++; if (run > best) best = run; } }
      if (best > G) G = best;
    }
    if (!ok) continue;
    nv9++;
    int j = 0; long dd = d; while (dd >= 10) { dd /= 10; j++; }
    int margin = G - 9 * j;
    if (margin < bestm) bestm = margin;
    if (margin <= MPRINT) printf("d=%ld p=%d j=%d G=%d margin=%d\n", d, p, j, G, margin);
  }
  printf("D=%ld P=%d: %ld d with ord<=P, %ld with V=9, min margin %d\n", D, P, cnt, nv9, bestm);
  return 0;
}
