import Data.Vect

-- Function
occ : (x : Nat) -> (xs : Vect m Nat) -> Nat
occ x [] = 0
occ x (y :: xs) = occ x xs + (if x == y then 1 else 0)

-- Relation (predicate)
data Occ : (x : Nat) -> (n : Nat) -> (xs : Vect m Nat) -> Type where
  OccNil : Occ x 0 Nil
  OccNext : Not (x=y) -> Occ x n xs -> Occ x n (y :: xs)
  OccMore : (x = y) -> Occ x n xs -> Occ x (S n) (y :: xs)

mkOcc : (x : Nat) -> (xs : Vect m Nat) -> (n : Nat ** Occ x n xs)


data ElemsAreSame : Vect n Nat -> Vect n Nat -> Type where
  SameElems : (xs, ys : Vect n Nat) -> 
              ((x : Nat) -> (m : Nat ** (Occ x m xs, Occ x m ys))) -> 
              ElemsAreSame xs ys
