import Effects
import Effect.Exception

PositiveNat : Type
PositiveNat = (n : Nat ** 1 `LTE` n)

parsePositiveNat : String -> 
              Eff PositiveNat [EXCEPTION String]
parsePositiveNat str
  = if all isDigit (unpack str)
     then let n = the Nat (cast str) in
       case isLTE 1 n of
         Yes p => pure (n ** p)
         No _ => raise "Not a positive natural"
     else raise "Not a number"
