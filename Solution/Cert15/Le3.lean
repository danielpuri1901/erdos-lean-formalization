import Solution.Cert

namespace CatchUpDeep

-- Catch-Up strategy certificate, N = 15, le side, root child with key 3
-- le root = Cert.all (CertList.cons k cert15le_k ...), keys k = 1..15, gap 0
-- definition: cert15le_3
-- position: l = [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], g = 3
-- checker: chkGe
-- nodes: 15843
-- (claim: chkGe [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] 3 cert15le_3 = true)
set_option maxRecDepth 100000 in
def cert15le_3 : Cert :=
   (Cert.pick 1 (Cert.pick 2 (Cert.all (CertList.cons 4 (Cert.pick 5 (Cert.all (CertList.cons 6 (Cert.pick
  8 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 10 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 11 (Cert.pick
  13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10
  (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 14 Cert.leaf) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) CertList.nil)))))))))) (CertList.cons
  7 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 9 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11
  (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  10 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 13
  (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all
  (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick
  15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11
  Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9
  (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  9 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  8 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8
  Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8
  Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) CertList.nil)))))))))) (CertList.cons
  8 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13
  Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13
  Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  CertList.nil)))))))))) (CertList.cons 9 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 10 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.pick 11 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  6 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick
  6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 11 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 12
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick
  14 Cert.leaf)) (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil)))))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  6 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 14
  Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.pick
  13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons
  6 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil)))))))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons
  6 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 8 (Cert.pick
  10 (Cert.all (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 6 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 8 (Cert.pick
  12 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 8 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 8 (Cert.all
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  10 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons
  11 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12
  Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 8 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  11 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf
  CertList.nil)))) CertList.nil)))))) CertList.nil)))))))))) CertList.nil)))))))))))) (CertList.cons
  5 (Cert.pick 4 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 12
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12
  Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 8 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  9 (Cert.pick 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.all (CertList.cons
  8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  8 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 8
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 8
  (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 8
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons
  8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  8 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 8
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8
  Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 9 (Cert.pick
  14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  CertList.nil))))))))) (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick
  15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 8
  (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 8 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 8
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 8 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons
  8 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8
  Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick
  9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 8 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 9 (Cert.pick 10
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all
  (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 9 (Cert.all
  (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 9 (Cert.all
  (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  10 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 9 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 9 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons
  8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 7 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 7 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 7 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 7
  Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 7 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 9 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8
  (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  12 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick
  15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick
  8 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 Cert.leaf)) CertList.nil))))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 12 Cert.leaf)) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 12 Cert.leaf)) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 12 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil))))))
  CertList.nil))))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 11 (Cert.pick 12 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 11 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil)))))))))
  CertList.nil)))))))))))) (CertList.cons 6 (Cert.pick 4 (Cert.pick 7 (Cert.all (CertList.cons 5 (Cert.pick
  11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))))) CertList.nil))))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  CertList.nil))))))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8
  Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8
  Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons
  8 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 14
  Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick
  9 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all
  (CertList.cons 8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 8 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 8 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8
  Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) (CertList.cons 9 (Cert.pick 13
  (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 9 Cert.leaf))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8
  Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8
  Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  8 (Cert.pick 9 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  5 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 5 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  5 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 5
  (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 5 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 11 (Cert.pick
  5 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 5 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons 5 (Cert.pick 14 (Cert.all (CertList.cons 9
  (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 5 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 11 (Cert.pick
  5 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 5 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 11 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 12 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 13 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons
  12 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 12 Cert.leaf))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 14 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 8 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 8
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all
  (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 Cert.leaf))
  (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  12 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  CertList.nil)))))))))))) (CertList.cons 7 (Cert.pick 4 (Cert.pick 6 (Cert.all (CertList.cons 5 (Cert.pick
  11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))
  (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons
  9 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 8
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 12
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 8 (Cert.pick
  9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.all
  (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 14 (Cert.all (CertList.cons 8
  (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 8 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 8
  (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 8
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons
  8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  8 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 8
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8
  Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 9 (Cert.pick
  14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick 14 Cert.leaf) (CertList.cons 9 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  CertList.nil))))))))) (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 5 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 5 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 11 (Cert.pick
  5 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 5 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 9 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 10 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 11 (Cert.pick
  5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 12 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 13 (Cert.pick 5
  (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 14 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 15 (Cert.pick 5
  (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) CertList.nil))))))))))))
  (CertList.cons 8 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 6 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 6
  (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 12 (Cert.pick
  6 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons 9 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 10 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 11 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 7
  (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  9 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf)
  (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11
  (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 15 (Cert.pick 6
  (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))))) CertList.nil)))))))))))) (CertList.cons 9 (Cert.pick 4 (Cert.pick
  5 (Cert.all (CertList.cons 6 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 8 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 8
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 8 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 8 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 7 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 8 (Cert.pick
  6 (Cert.pick 7 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 10 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons
  8 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick
  14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  8 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  8 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))))
  CertList.nil))))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  CertList.nil))))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 7 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))))))
  CertList.nil))))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  14 Cert.leaf)) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11
  (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 7 (Cert.pick 12
  (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  8 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf)
  (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12
  (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))))) CertList.nil)))))))))))) (CertList.cons
  10 (Cert.pick 4 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 8 (Cert.pick 7
  (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 14
  Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  11 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 7 (Cert.pick 13 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  7 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13
  Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf)
  (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13
  Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  14 Cert.leaf) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick
  11 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) CertList.nil)))))))) CertList.nil)))))))))))) (CertList.cons 11 (Cert.pick 4 (Cert.pick
  5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 8 (Cert.pick 7
  (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  CertList.nil)))))))) (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  CertList.nil)))))))) (CertList.cons 10 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  12 (Cert.pick 7 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all
  (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  9 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick
  9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons
  8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons
  10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 14 Cert.leaf) (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 13 Cert.leaf) (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 7
  (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) CertList.nil)))))))))))) (CertList.cons
  12 (Cert.pick 4 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 8 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 8 (Cert.all
  (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 13 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons
  7 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick
  7 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  11 (Cert.pick 7 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.all
  (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  9 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick
  9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons
  10 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons
  8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick
  11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 14 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  9 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons
  9 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 9
  Cert.leaf CertList.nil))) (CertList.cons 9 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))))
  (CertList.cons 13 (Cert.pick 4 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all
  (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 8 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11
  (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  9 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 11 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  10 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  10 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf)
  (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons
  10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick
  11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all
  (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) (CertList.cons
  10 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons 11 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons 10 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  CertList.nil)))))))))))) (CertList.cons 14 (Cert.pick 4 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons
  7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 8 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 10
  (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.pick
  12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  9 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons
  8 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 13
  Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 8 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons
  8 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.pick 15 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 9 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf)
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  9 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 13 Cert.leaf) (CertList.cons 9 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  CertList.nil)))))))))))) (CertList.cons 15 (Cert.pick 4 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons
  7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  8 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 14 Cert.leaf))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all
  (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12
  (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 8 (Cert.pick
  9 (Cert.all (CertList.cons 7 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 8 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.pick 14 Cert.leaf) (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 13 Cert.leaf) (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 7
  (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons
  9 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 9
  Cert.leaf CertList.nil))) (CertList.cons 9 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 14 Cert.leaf) (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 14 Cert.leaf) (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 14 (Cert.pick 8 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11
  (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 13 Cert.leaf)
  (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 9 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))))
  CertList.nil)))))))) CertList.nil)))))))))))) CertList.nil)))))))))))))))

set_option maxRecDepth 100000 in
theorem cert15le_3_ok : chkGe ((List.range' 1 15).erase 3) 3 cert15le_3 = true := by decide +kernel

end CatchUpDeep
