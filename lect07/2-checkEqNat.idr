import Data.Vect

data EqNat : (num1 : Nat) -> (num2 : Nat) -> Type where
  Same : (num : Nat) -> EqNat num num

checkEqNat : (num1 : Nat) -> (num2 : Nat) -> 
             Maybe (EqNat num1 num2)
checkEqNat Z Z = Just (Same Z)
checkEqNat Z (S k) = Nothing
checkEqNat (S k) Z = Nothing
checkEqNat (S k) (S j) = 
         (case checkEqNat k j of
               Nothing => Nothing
               (Just (Same k)) => Just (Same (S k)))

exactLength' : (len : Nat) -> (input : Vect m a) ->
                              Maybe (Vect len a)
exactLength' {m} len input = case checkEqNat m len of
                                  Nothing => Nothing
                                  (Just (Same m)) => 
                                      Just input
