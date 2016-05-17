import Data.Vect

removeElem : (value : a) -> (xs : Vect (S n) a) -> 
                     (prf : Elem value xs) -> Vect n a
removeElem value (value :: xs) Here = xs
removeElem {n = Z} _ (_ :: _) (There Here) impossible
removeElem {n = Z} _ (_ :: _) (There (There _)) impossible
removeElem {n = S k} value (x :: xs) (There later) = x :: removeElem value xs later

removeElem_auto : (value : a) -> (xs : Vect (S n) a) -> 
                     {auto prf : Elem value xs} -> Vect n a
removeElem_auto {prf} value xs = removeElem value xs prf
