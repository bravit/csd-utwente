import Data.Vect

data Sorted : (xs : Vect n Nat) -> Type where
  SortedEmpty : Sorted []
  SortedOne : (x : Nat) -> Sorted [x]
  SortedMany : (x : Nat) -> (y : Nat) ->
               Sorted (y :: zs) -> (x `LTE` y) ->
               Sorted (x :: y :: zs)  

%name Sorted sp,sp1,sp2

isSorted_rhs_3 : (contra : LTE x y -> Void) -> Sorted (x :: (y :: xs)) -> Void
isSorted_rhs_3 contra (SortedMany x y sp pf) = contra pf

isSorted_rhs_5 : (contra : Sorted (y :: xs) -> Void) -> (prf : LTE x y) -> Sorted (x :: (y :: xs)) -> Void
isSorted_rhs_5 contra prf (SortedMany x y sp pf) = contra sp

isSorted : (xs : Vect n Nat) -> Dec (Sorted xs)
isSorted [] = Yes SortedEmpty
isSorted (x :: []) = Yes (SortedOne x)
isSorted (x :: (y :: xs)) = 
    case isLTE x y of
      (Yes prf1) => (case isSorted (y :: xs) of
                         (Yes prf2) => 
                           Yes (SortedMany x y prf2 prf1)
                         (No contra) => No (isSorted_rhs_5 contra prf1))
      (No contra) => No (isSorted_rhs_3 contra)
