import Data.Vect
{-
interface DecEq ty where
  decEq : (val1 : ty) -> (val2 : ty) -> Dec (val1 = val2)
-}

exactLength' : (len : Nat) -> (input : Vect m a) -> Maybe (Vect len a)
exactLength' {m} len input = case decEq m len of
                              (Yes Refl) => Just input
                              (No contra) => Nothing
