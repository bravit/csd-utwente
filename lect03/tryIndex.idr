import Data.Vect

v : Vect 5 Nat
v = [1,2,3,4,5]

tryIndex : Integer -> Vect n a -> Maybe a
tryIndex {n} i xs = case integerToFin i n of
                      Nothing => Nothing
                      (Just i') => Just (index i' xs)  

tryIndex' : Integer -> Vect n a -> Maybe a
tryIndex' {n} i xs = integerToFin i n >>= pure . flip index xs 
