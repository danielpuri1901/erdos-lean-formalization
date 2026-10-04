/* Exact necessary-condition filter for tan(arctan 1 + ... + arctan n) in Z.
 * A_n | B_n  <=>  |A_n| = c_n := gcd(A_n, B_n).
 * c_n = 2^floor(o_n/2) * prod_{p = 1 mod 4} p^min(V+_p(n), V-_p(n))   (see NOTES.md).
 * We track A_n mod q and c_n mod q for primes q = 3 mod 4 (q never divides c_n)
 * and report every n with A_n = +-c_n mod q for all q (necessary for an integer value).
 * Usage: search N [dump]   (dump prints n, A_n mod q0, c_n mod q0 for checking) */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
typedef unsigned __int128 u128;
#define NQ 3
static const uint64_t Q[NQ] = {2305843009213693951ULL, 4611686018427387847ULL, 4611686017427387867ULL};
static inline uint64_t mulm(uint64_t a, uint64_t b, uint64_t m) { return (uint64_t)((u128)a * b % m); }
static uint64_t powm(uint64_t a, uint64_t e, uint64_t m) { uint64_t r = 1 % m; a %= m; while (e) { if (e & 1) r = mulm(r, a, m); a = mulm(a, a, m); e >>= 1; } return r; }

int main(int argc, char **argv) {
  uint64_t N = strtoull(argv[1], 0, 10);
  int dump = argc > 2;
  uint64_t B = N + 2;                          /* sieve primes <= B; leftover > B is prime */
  uint8_t *comp = calloc(B + 1, 1);
  for (uint64_t i = 2; i * i <= B; i++) if (!comp[i]) for (uint64_t j = i * i; j <= B; j += i) comp[j] = 1;
  uint64_t np = 0;
  for (uint64_t p = 5; p <= B; p++) if (!comp[p] && p % 4 == 1) np++;
  uint32_t *P = malloc(np * 4), *R = malloc(np * 4), *U = calloc(np, 4), *V = calloc(np, 4);
  uint64_t *H0 = malloc(np * 8), *H1 = malloc(np * 8);   /* next k = r, p-r (mod p) to visit */
  uint64_t t = 0;
  for (uint64_t p = 5; p <= B; p++) if (!comp[p] && p % 4 == 1) {
    uint64_t r = 0;
    for (uint64_t g = 2;; g++) { r = powm(g, (p - 1) / 4, p); if (mulm(r, r, p) == p - 1) break; }
    if (r > p - r) r = p - r;
    P[t] = p; R[t] = r; H0[t] = r; H1[t] = p - r; t++;
  }
  free(comp);
  const uint64_t S = 1 << 25;
  uint64_t *a = malloc(S * 8), *F = malloc(S * NQ * 8);
  uint64_t za[NQ], zb[NQ], c[NQ];
  for (int j = 0; j < NQ; j++) { za[j] = 1; zb[j] = 0; c[j] = 1; }
  uint64_t odd = 0, surv = 0;
  for (uint64_t L = 1; L <= N; L += S) {
    uint64_t Rr = L + S - 1; if (Rr > N) Rr = N;
    uint64_t len = Rr - L + 1;
    for (uint64_t i = 0; i < len; i++) { uint64_t k = L + i; a[i] = 1 + k * k; for (int j = 0; j < NQ; j++) F[i * NQ + j] = 1; }
    for (uint64_t i = 0; i < len; i++) if ((L + i) & 1) a[i] >>= 1;   /* v_2(1+k^2)=1 for odd k */
    for (uint64_t s = 0; s < np; s++) {
      uint64_t p = P[s];
      /* visit the hits of both sides in increasing k so that U, V evolve in k order */
      while (1) {
        uint64_t h0 = H0[s], h1 = H1[s];
        uint64_t h = h0 < h1 ? h0 : h1;
        if (h > Rr) break;
        int side = (h == h0) ? 0 : 1;
        uint64_t i = h - L, e = 0;
        while (a[i] % p == 0) { a[i] /= p; e++; }
        uint32_t m0 = U[s] < V[s] ? U[s] : V[s];
        if (side == 0) { U[s] += e; H0[s] += p; } else { V[s] += e; H1[s] += p; }
        uint32_t m1 = U[s] < V[s] ? U[s] : V[s];
        if (m1 > m0) for (int j = 0; j < NQ; j++) F[i * NQ + j] = mulm(F[i * NQ + j], powm(p, m1 - m0, Q[j]), Q[j]);
      }
    }
    for (uint64_t i = 0; i < len; i++) {
      uint64_t n = L + i;
      if (a[i] > 1) {                         /* leftover prime Pb > B, exponent 1 */
        uint64_t Pb = a[i];
        if (Pb - n >= 1 && Pb - n < n)        /* partner Pb-n already seen: content gains Pb */
          for (int j = 0; j < NQ; j++) F[i * NQ + j] = mulm(F[i * NQ + j], Pb % Q[j], Q[j]);
      }
      if (n & 1) { odd++; if (odd % 2 == 0) for (int j = 0; j < NQ; j++) F[i * NQ + j] = mulm(F[i * NQ + j], 2, Q[j]); }
      int ok = 1;
      for (int j = 0; j < NQ; j++) {
        uint64_t q = Q[j], nm = n % q;
        uint64_t na = (za[j] + q - mulm(nm, zb[j], q)) % q;
        uint64_t nb = (zb[j] + mulm(nm, za[j], q)) % q;
        za[j] = na; zb[j] = nb;
        c[j] = mulm(c[j], F[i * NQ + j], q);
        if (!(za[j] == c[j] || za[j] == (q - c[j]) % q)) ok = 0;
      }
      if (dump) printf("%llu %llu %llu\n", (unsigned long long)n, (unsigned long long)za[0], (unsigned long long)c[0]);
      if (ok) { surv++; printf("SURVIVOR n=%llu\n", (unsigned long long)n); fflush(stdout); }
    }
    if (!dump) { printf("checked n <= %llu survivors so far %llu\n", (unsigned long long)Rr, (unsigned long long)surv); fflush(stdout); }
  }
  printf("done N=%llu survivors=%llu\n", (unsigned long long)N, (unsigned long long)surv);
  return 0;
}
