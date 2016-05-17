import Data.Vect

removeElem : Eq a => (value : a) -> (xs : Vect (S n) a) -> Vect n a
removeElem {n=Z} value (x :: xs) = []
removeElem {n=S j} value (x :: xs) = case value == x of
                                  False => x :: removeElem value xs
                                  True => xs
