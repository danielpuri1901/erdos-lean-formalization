# Source of the graph

`counterexample.edgelist` lists the 72 edges of a connected cubic graph on the vertices 0 to 47, one edge per line.
It comes from the public repository https://github.com/ipitchford/txgraffiti-order48-successor (file `counterexample.edgelist`, fetched on 2026-10-04).
That repository calls its result an unrefereed, certificate-backed candidate: i(G) = 16 and μ*(G) = 15.
Credit for finding the graph belongs to its authors.
An earlier 50-vertex counterexample is recorded at https://www.evidencepress.org/releases/txgraffiti-c3-resolution/.

Checked independently on 2026-10-04 with separate code:

- The graph has 48 vertices and 72 edges, every degree is 3, and it is connected.
- The 15 edges {0,1}, {2,3}, {4,5}, ..., {28,29} form a matching, and every edge of the graph meets one of them, so it is a maximal matching of size 15.
- An exhaustive branch and bound (branch on an undominated vertex, bound by 4 new dominated vertices per chosen vertex) finds no independent dominating set with 15 or fewer vertices; it visits about 125 thousand nodes.
- An independent dominating set with 16 vertices exists.
