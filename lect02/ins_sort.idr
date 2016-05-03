import Data.Vect

{-
Key points 4:
1) Function extraction - remove unnecessary arguments
2) The more information from types, the more power for solving holes - check 
   first equation for `insert`
3) Using case/of instead of if/then/else for (arguably) more structured code
4) Recursive structure in `ins_sort` - looks like inductive hypothesis (not acccidentally!)
-}

insert : (x : Nat) -> (xs' : Vect k Nat) -> Vect (S k) Nat
insert x [] = [x]
insert x (y :: xs) = case x < y of
                       True => x :: y :: xs
                       False => y :: insert x xs

ins_sort : Vect n Nat -> Vect n Nat
ins_sort [] = []
ins_sort (x :: xs) = let xs' = ins_sort xs in
                      insert x xs'
