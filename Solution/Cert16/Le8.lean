import Solution.Cert

namespace CatchUpDeep

-- Catch-Up strategy certificate, N = 16, le side, root child with key 8
-- le root = Cert.all (CertList.cons k cert16le_k ...), keys k = 1..16, gap 0
-- definition: cert16le_8
-- position: l = [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16], g = 8
-- checker: chkGe
-- nodes: 9329
-- (claim: chkGe [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 16] 8 cert16le_8 = true)
set_option maxRecDepth 100000 in
def cert16le_8 : Cert :=
   (Cert.pick 1 (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.all (CertList.cons 5 (Cert.pick 7 (Cert.all
  (CertList.cons 6 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11
  (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons
  15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  9 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  9 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  CertList.nil))))))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick
  15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  9 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf)
  (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  9 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 16 Cert.leaf)
  (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 15 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 11
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick
  13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 6 (Cert.pick 14 (Cert.all (CertList.cons 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  6 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 12 (Cert.pick
  6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 11 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons
  9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons
  13 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick 13 Cert.leaf))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 16 Cert.leaf))
  (CertList.cons 13 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  13 Cert.leaf)) CertList.nil)))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 14 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  CertList.nil))))))))))) (CertList.cons 6 (Cert.pick 7 (Cert.all (CertList.cons 5 (Cert.pick 14 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) CertList.nil))))))) (CertList.cons
  11 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))))
  (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons
  9 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons
  9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 12
  (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick
  11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  9 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick
  15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 11
  Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 11
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick
  13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  9 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 10 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 11 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 12 (Cert.pick
  5 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 13 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 14 (Cert.pick
  5 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 15 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 16 (Cert.pick
  5 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) CertList.nil)))))))))))
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 5 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 12
  (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  6 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons
  6 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons
  15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  6 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 11 (Cert.all
  (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 6 (Cert.pick 10 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 11 (Cert.pick 12
  (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 5 (Cert.all
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  5 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 5 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 5 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) CertList.nil))))) (CertList.cons 13 (Cert.pick 5 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 5 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 5 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 5 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 5 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick
  14 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 5 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 5 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 5 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 5 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))
  (CertList.cons 10 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil))))))))) (CertList.cons 11 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons
  16 (Cert.pick 14 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  10 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 12 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 13 (Cert.pick 5 (Cert.pick 6
  (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick
  14 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 14 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  15 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 11
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 11 (Cert.pick
  13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons
  10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 16 (Cert.pick 5 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
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
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))))) CertList.nil)))))))))))
  (CertList.cons 9 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick
  7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  14 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick
  12 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 7
  (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 7
  (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil))))))
  (CertList.cons 11 (Cert.pick 7 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.pick 13 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))))
  (CertList.cons 16 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))) CertList.nil))))))))
  (CertList.cons 13 (Cert.pick 7 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11
  (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12
  (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf
  CertList.nil)))) CertList.nil))))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 16
  (Cert.pick 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
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
  Cert.leaf)) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))) (CertList.cons 10 (Cert.pick
  5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons
  11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 13 (Cert.pick
  14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  9 (Cert.pick 7 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 14 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick
  14 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  11 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  11 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 13 Cert.leaf
  CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 9 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all
  (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 16 Cert.leaf) (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
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
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))) (CertList.cons
  11 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 7
  (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons
  12 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick
  16 Cert.leaf) (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 16 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 12 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 16 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all
  (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13
  Cert.leaf) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))) (CertList.cons 12 (Cert.pick
  5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 10
  (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 16 (Cert.all (CertList.cons
  13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick
  16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 11 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 13 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 15
  (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.pick
  14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 11 (Cert.all
  (CertList.cons 9 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 16 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  13 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick
  16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 14 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 10
  (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 15
  (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 16 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons
  10 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil)))))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick
  15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))) (CertList.cons
  13 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons
  15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf)) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 11 (Cert.pick
  12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons
  10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  9 (Cert.pick 7 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 (Cert.all (CertList.cons
  14 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 14 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick
  16 Cert.leaf) (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 16 (Cert.all (CertList.cons
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 16 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 14 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 9 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  14 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 11
  Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))))
  (CertList.cons 15 (Cert.pick 9 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons
  10 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf)
  CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))) (CertList.cons
  14 (Cert.pick 5 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all
  (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick
  16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 15
  Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16
  (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 11 Cert.leaf)
  CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick
  7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13
  (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))))
  (CertList.cons 15 (Cert.pick 5 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 16 (Cert.all (CertList.cons
  10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 14 (Cert.all
  (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 14 (Cert.pick 16 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons
  12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 16 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  16 Cert.leaf) (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 12
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 14 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 10 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 14 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick 14 Cert.leaf))
  CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 11
  Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  7 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))) (CertList.cons 16 (Cert.pick 5 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 14 (Cert.pick
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
  11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick
  15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  12 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick
  14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick
  11 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13
  Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick
  14 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons
  14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
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
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))))
  CertList.nil))))))))))))))))

set_option maxRecDepth 100000 in
theorem cert16le_8_ok : chkGe ((List.range' 1 16).erase 8) 8 cert16le_8 = true := by decide +kernel

end CatchUpDeep
