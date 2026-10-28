# Source of the graph

`H24.edgelist` lists the 30 edges of the graph H = G(K3) from M. Fischer, "A counterexample to the zero forcing versus independence conjecture for cubic and subcubic graphs", arXiv 2607.23664.
The edge list was written by our own script from the paper's description, with this labelling:

- 0, 1, 2 are the triangle c0, c1, c2.
- 3, 4, 5 are r0, r1, r2, with the edges c_j r_j.
- Copy k (k = 0..5) of K3 has the vertices z = 6 + 3k, a = 7 + 3k, b = 8 + 3k, with the edges z a, z b, a b, and z is joined to r_(k div 2).

Checked on 2026-10-04 with separate code:

- 24 vertices, 30 edges, connected, maximum degree 3 (twelve vertices of degree 2, twelve of degree 3).
- The independence number is 9 (branch and bound).
- No set of 10 vertices forces the whole graph (all 1,961,256 sets tried), so the zero forcing number is at least 11.
- The 11 vertices z, a of copies 0 to 4 together with a of copy 5 force the whole graph, so the zero forcing number is 11.
