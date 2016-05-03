{-
Key points 2:
1) Type-driven development: Type/Define/Refine
2) Editor shortcuts (google list for your editor: vim or atom):
   * add definition (C-c C-s)
   * split pattern variable (C-c C-c)
   * attempt to solve hole (C-c C-a)
   * extract function (C-c C-e)
3) It is instructive to understand idris' heuristic for solving holes.
-}

pred : Nat -> Nat
pred Z = 0
pred (S k) = k

inv : Bool -> Bool
inv False = True
inv True = False

sum' : Num a => List a -> a
sum' [] = 0
sum' (x :: xs) = x + sum' xs

sum'' : List Nat -> Nat
sum'' [] = 0
sum'' (x :: xs) = x + sum'' xs

