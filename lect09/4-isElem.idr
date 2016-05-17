import Data.Vect

elem' : Eq ty => (value : ty) -> (xs : Vect n ty) -> Bool
elem' value [] = False
elem' value (x :: xs) = case x == value of
                            False => elem' value xs
                            True => True

not_in_nil : Elem value [] -> Void
not_in_nil Here impossible
not_in_nil (There _) impossible

not_in_tail : (contra : Elem value xs -> Void) -> (contra1 : (x = value) -> Void) -> Elem value (x :: xs) -> Void
not_in_tail contra contra1 Here =  contra1 Refl
not_in_tail contra contra1 (There later) =  contra later

isElem' : DecEq ty => (value : ty) -> (xs : Vect n ty) -> Dec (Elem value xs)
isElem' value [] = No not_in_nil
isElem' value (x :: xs) = case decEq x value of
                              (Yes Refl) => Yes Here
                              (No contra) => case isElem' value xs of
                                                (Yes prf) => Yes (There prf)
                                                (No contra1) => No (not_in_tail contra1 contra)
