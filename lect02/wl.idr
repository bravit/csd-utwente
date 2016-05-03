import Data.Vect

{-
Key points 3:
1) TDD in case of word_lengths (recursive definition) - not enough info from types!
2) TDD in case of wl (with vectors) - structure of result value is derived from type
3) `total` annotation: compiler complains if some cases are missing (otherwise not) 
-}

word_lengths : List String -> List Nat
word_lengths [] = []
word_lengths (x :: xs) = length x :: word_lengths xs

total
wl : Vect n String -> Vect n Nat
wl [] = []
wl (x :: xs) = length x :: wl xs

