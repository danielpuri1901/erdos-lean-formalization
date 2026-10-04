// Upper bounds on the digit length of a(n) for all n < N, by meet-in-the-middle on
// subset sums of 10^i mod m (m = n with factors 2,5 removed), with exact BFS fallback.
// For each m coprime to 10 (m < N) prints a witness line to stdout:
//   "m L H hexmask"  (witness = sum of 10^i over set bits i of mask)   or
//   "m L B digits"   (witness written in decimal, from BFS)
// and to stderr: per k, the max over n in [10^(k-1)-1, 10^k-1) of e(n) + L(m(n)).
// usage: mitm N
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef unsigned long long u64;
static int bfs(int n, char *out, int *par, unsigned char *dig, int *q) {
  if (n == 1) { strcpy(out, "1"); return 1; }
  for (int i = 0; i < n; i++) par[i] = -1;
  int h = 0, t = 0, start = 1 % n, found = 0;
  par[start] = start; dig[start] = 1; q[t++] = start;
  while (h < t && !found) {
    int r = q[h++];
    for (int d = 0; d <= 1 && !found; d++) {
      int s = (int)(((long long)r * 10 + d) % n);
      if (par[s] == -1) { par[s] = r; dig[s] = d; q[t++] = s; }
      if (s == 0) found = 1;
    }
  }
  char buf[512]; int len = 0, r = 0;
  while (1) { buf[len++] = '0' + dig[r]; if (r == start) break; r = par[r]; }
  for (int i = 0; i < len; i++) out[i] = buf[len - 1 - i];
  out[len] = 0; return len;
}
// returns mask or 0 on failure
static u64 mitm(int m, int s, int t, int *key, uint32_t *val, int *lowres) {
  int pw[64]; pw[0] = 1 % m;
  for (int i = 1; i < s + t; i++) pw[i] = (int)(((long long)pw[i - 1] * 10) % m);
  int H = 1 << (s + 1); int Hm = H - 1;
  memset(key, 0xff, sizeof(int) * H);
  lowres[0] = 0;
  for (uint32_t mask = 0; mask < (1u << s); mask++) {
    int r;
    if (mask == 0) r = 0;
    else { r = lowres[mask & (mask - 1)] + pw[__builtin_ctz(mask)]; if (r >= m) r -= m; }
    lowres[mask] = r;
    if (r == 0 && mask) return mask;
    uint32_t hsh = ((uint32_t)r * 2654435761u) & Hm;
    while (key[hsh] != -1 && key[hsh] != r) hsh = (hsh + 1) & Hm;
    if (key[hsh] == -1) { key[hsh] = r; val[hsh] = mask; }
  }
  // high part, gray code over t bits
  int hr = 0; uint32_t hm = 0;
  for (uint32_t g = 1; g < (1u << t); g++) {
    int b = __builtin_ctz(g); hm ^= (1u << b);
    if (hm & (1u << b)) { hr += pw[s + b]; if (hr >= m) hr -= m; }
    else { hr -= pw[s + b]; if (hr < 0) hr += m; }
    int target = hr ? m - hr : 0;
    uint32_t hsh = ((uint32_t)target * 2654435761u) & Hm;
    while (key[hsh] != -1) {
      if (key[hsh] == target) return ((u64)hm << s) | val[hsh];
      hsh = (hsh + 1) & Hm;
    }
  }
  return 0;
}
int main(int argc, char **argv) {
  int N = atoi(argv[1]);
  unsigned char *L = calloc(N, 1);
  #pragma omp parallel
  {
    int *key = malloc(sizeof(int) << 23); uint32_t *val = malloc(sizeof(uint32_t) << 23);
    int *lowres = malloc(sizeof(int) << 22);
    int *par = NULL; unsigned char *dig = NULL; int *q = NULL;
    char out[600], line[700];
    #pragma omp for schedule(dynamic, 1024)
    for (int m = 1; m < N; m++) {
      if (m % 2 == 0 || m % 5 == 0) continue;
      int len = 0;
      if (m == 1) { len = 1; snprintf(line, sizeof line, "1 1 H 1\n"); }
      else {
        int lg = 0; while ((1LL << lg) < m) lg++;
        int s = (lg + 3) / 2; u64 mask = 0;
        while (s <= 21) { mask = mitm(m, s, s + 1, key, val, lowres); if (mask) break; s += 2; }
        if (mask) { len = 64 - __builtin_clzll(mask); snprintf(line, sizeof line, "%d %d H %llx\n", m, len, mask); }
        else {
          if (!par) { par = malloc(sizeof(int) * N); dig = malloc(N); q = malloc(sizeof(int) * N); }
          len = bfs(m, out, par, dig, q); snprintf(line, sizeof line, "%d %d B %s\n", m, len, out);
        }
      }
      L[m] = (unsigned char)len;
      #pragma omp critical
      fputs(line, stdout);
    }
  }
  // per-k maxima
  long long p = 1; int k = 0;
  while (p - 1 < N) { k++; p *= 10; }
  for (int kk = 1; kk <= k; kk++) {
    long long lo = 1, hi = 1; for (int i = 0; i < kk; i++) hi *= 10; lo = hi / 10 - 1; hi = hi - 1;
    if (lo < 1) lo = 1; if (hi > N) hi = N;
    int best = -1; long long bn = 0;
    for (long long n = lo; n < hi; n++) {
      long long m = n; int a = 0, b = 0;
      while (m % 2 == 0) { m /= 2; a++; } while (m % 5 == 0) { m /= 5; b++; }
      int U = (a > b ? a : b) + L[m];
      if (U > best) { best = U; bn = n; }
    }
    fprintf(stderr, "k=%d n in [%lld,%lld): max upper bound %d at n=%lld; need <= %d\n", kk, lo, hi, best, bn, 9 * kk - 1);
  }
  return 0;
}
