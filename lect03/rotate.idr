import Data.Vect


rotate : Vect n a -> Vect n a
rotate [] = []
rotate (x :: xs) = ins_last x xs
  where
  ins_last : (x : a) -> (xs : Vect k a) -> Vect (S k) a
  ins_last x [] = [x]
  ins_last x (y :: xs) = y :: ins_last x xs
  
