import Data.Vect

rotateProof : Vect (k + 1) a -> Vect (S k) a
rotateProof {k} xs = 
   rewrite plusCommutative 1 k in xs

rotate : Vect n a -> Vect n a
rotate {n = Z} [] = []
rotate {n = (S k)} (x :: xs) =
   rotateProof (xs ++ [x])
    
--      let r = xs ++ [x]
--   in rewrite plusCommutative 1 k in r
