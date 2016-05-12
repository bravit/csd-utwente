%default total

plus_commutes_Z : n = plus n 0
plus_commutes_Z {n = Z} = Refl
plus_commutes_Z {n = (S k)} =
      rewrite plus_commutes_Z {n=k} in Refl

plus_commutes_S : (k : Nat) -> (n : Nat) -> 
                   S (plus n k) = plus n (S k)
plus_commutes_S k Z = Refl
plus_commutes_S k (S j) = 
    rewrite plus_commutes_S k j in
    Refl

plus_commutes : (m, n : Nat) -> m + n = n + m
plus_commutes Z n = plus_commutes_Z
plus_commutes (S k) n = 
   rewrite plus_commutes k n in
   plus_commutes_S k n
