import Data.Vect

exactLength' : (len : Nat) -> 
               (input : Vect m a) -> 
               Maybe (Vect len a)
exactLength' {m} len input = 
                case len == m of
                     False => Nothing
                     True => Just ?exactLength'_r
