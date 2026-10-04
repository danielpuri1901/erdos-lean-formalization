/* Exhaustive search for valid n-subsets of Z/N.
   Valid: the only size-n multiset from A with sum = sum(A) mod N is A itself.
   DFS over sets {0 = a0 < a1 < ...} (translation normalisation), checking each prefix
   (validity is hereditary). Check = saturating DP count of size-k multisets with the target sum.
   usage: search n Nlo Nhi [all]  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int n, N, findall;
static int A[16];
static long long nodes, found;
static unsigned char dp[2][17][512];

static int valid(int k) {
  int S = 0;
  for (int i = 0; i < k; i++) S = (S + A[i]) % N;
  int cur = 0;
  memset(dp[cur], 0, sizeof dp[cur]);
  dp[cur][0][0] = 1;
  for (int i = 0; i < k; i++) {
    int nx = cur ^ 1;
    memset(dp[nx], 0, sizeof dp[nx]);
    int a = A[i];
    for (int j = 0; j <= k; j++)
      for (int s = 0; s < N; s++) {
        unsigned char c = dp[cur][j][s];
        if (!c) continue;
        int ss = s;
        for (int t = 0; j + t <= k; t++) {
          unsigned char *d = &dp[nx][j + t][ss];
          int v = *d + c; *d = v > 2 ? 2 : v;
          ss += a; if (ss >= N) ss -= N;
        }
      }
    cur = nx;
  }
  return dp[cur][k][S] == 1;
}

static int dfs(int k) { /* A[0..k-1] valid */
  nodes++;
  if (k == n) {
    found++;
    if (found <= 3) {
      printf("  valid n=%d N=%d:", n, N);
      for (int i = 0; i < n; i++) printf(" %d", A[i]);
      printf("\n");
    }
    return !findall;
  }
  for (int x = A[k - 1] + 1; x < N; x++) {
    if (N - x < n - k) break;
    A[k] = x;
    if (valid(k + 1) && dfs(k + 1)) return 1;
  }
  return 0;
}

int main(int argc, char **argv) {
  n = atoi(argv[1]);
  int lo = atoi(argv[2]), hi = atoi(argv[3]);
  findall = argc > 4;
  for (N = lo; N <= hi; N++) {
    nodes = found = 0;
    A[0] = 0;
    int r = (N >= n) ? dfs(1) : 0;
    printf("n=%d N=%d exists=%d found=%lld nodes=%lld\n", n, N, findall ? (found > 0) : r, found, nodes);
    fflush(stdout);
  }
  return 0;
}
