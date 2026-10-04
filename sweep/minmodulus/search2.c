/* Faster exhaustive search for valid n-subsets of Z/N.
   Normalisation (affine invariance x -> u x + c, u a unit): pick a pair a,b in A minimising
   g = gcd(b-a, N); translate a to 0 and multiply by a unit sending b-a to g. So WLOG
   {0, g} ⊆ A, g | N, g < N, and every difference x-y of A has gcd(x-y, N) >= g.
   DFS adds further elements x in increasing order (x != 0, g), keeping a DP table per depth:
   dp[j][s] = number (saturated at 2) of size-j multisets from the current set with sum s.
   The current set of size k is valid iff dp[k][sum] == 1 (validity is hereditary, so pruning
   at every prefix is sound).
   usage: search2 n Nlo Nhi  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int n, N, g;
static int A[16];
static long long nodes, found;
static unsigned char dp[17][17][512];
static int gcdtab[512];
static int gcd(int a, int b) { while (b) { int t = a % b; a = b; b = t; } return a; }

static void add(int depth, int x) { /* dp[depth+1] = dp[depth] * (1 + t z^x + t^2 z^{2x} + ...) */
  memset(dp[depth + 1], 0, sizeof dp[depth + 1]);
  for (int j = 0; j <= n; j++)
    for (int s = 0; s < N; s++) {
      unsigned char c = dp[depth][j][s];
      if (!c) continue;
      int ss = s;
      for (int t = 0; j + t <= n; t++) {
        unsigned char *d = &dp[depth + 1][j + t][ss];
        int v = *d + c; *d = v > 2 ? 2 : v;
        ss += x; if (ss >= N) ss -= N;
      }
    }
}

static int dfs(int k, int last, int S) { /* A[0..k-1] valid, dp[k] current */
  nodes++;
  if (k == n) {
    found++;
    printf("  valid n=%d N=%d:", n, N);
    for (int i = 0; i < n; i++) printf(" %d", A[i]);
    printf("\n");
    return 1;
  }
  for (int x = last + 1; x < N; x++) {
    if (x == g) continue;
    int ok = 1;
    for (int i = 0; i < k; i++) { int d = x - A[i]; if (d < 0) d += N; if (gcdtab[d] < g) { ok = 0; break; } }
    if (!ok) continue;
    A[k] = x;
    add(k, x);
    int S2 = (S + x) % N;
    if (dp[k + 1][k + 1][S2] == 1 && dfs(k + 1, x, S2)) return 1;
  }
  return 0;
}

int main(int argc, char **argv) {
  n = atoi(argv[1]);
  int lo = atoi(argv[2]), hi = atoi(argv[3]);
  for (N = lo; N <= hi; N++) {
    for (int d = 0; d < N; d++) gcdtab[d] = gcd(d, N);
    long long totnodes = 0; int ex = 0;
    if (N >= n)
      for (g = 1; g < N && !ex; g++) {
        if (N % g) continue;
        nodes = found = 0;
        memset(dp[0], 0, sizeof dp[0]);
        dp[0][0][0] = 1;
        A[0] = 0; add(0, 0);
        A[1] = g; add(1, g);
        if (dp[2][2][g % N] == 1) ex = dfs(2, 0, g % N);
        totnodes += nodes;
      }
    printf("n=%d N=%d exists=%d nodes=%lld\n", n, N, ex, totnodes);
    fflush(stdout);
  }
  return 0;
}
