// Exact digit length of a(n) (least positive 0/1 multiple of n) by BFS over residues.
// usage: bfs_exact N  -> prints n and a(n) for n = 1..N (a(n) as digit string)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int *par; static unsigned char *dig; static int *q;
static int bfs(int n, char *out) {
  if (n == 1) { strcpy(out, "1"); return 1; }
  memset(par, -1, sizeof(int) * n);
  int h = 0, t = 0; int start = 1 % n;
  par[start] = start; dig[start] = 1; q[t++] = start;
  while (h < t) {
    int r = q[h++];
    for (int d = 0; d <= 1; d++) {
      int s = (int)(((long long)r * 10 + d) % n);
      if (par[s] == -1) { par[s] = r; dig[s] = d; q[t++] = s; }
      if (s == 0) goto done;
    }
  }
  return -1;
done:;
  char buf[256]; int len = 0; int r = 0;
  // r = 0 reached; walk back
  while (1) { buf[len++] = '0' + dig[r]; if (r == start && len > 0 && par[r] == r) break; r = par[r]; if (r == start) { buf[len++] = '0' + dig[r]; break; } }
  for (int i = 0; i < len; i++) out[i] = buf[len - 1 - i];
  out[len] = 0; return len;
}
int main(int argc, char **argv) {
  int N = atoi(argv[1]);
  par = malloc(sizeof(int) * (N + 1)); dig = malloc(N + 1); q = malloc(sizeof(int) * (N + 1));
  char out[300];
  for (int n = 1; n <= N; n++) { int L = bfs(n, out); printf("%d %s\n", n, out); }
  return 0;
}
