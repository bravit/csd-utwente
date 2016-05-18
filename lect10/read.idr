module Main

import Effects
import Effect.StdIO
import Effect.State
import Data.Vect

readInt : DepEff.Eff Bool [STATE (Vect n Int), STDIO]
            (\ok => if ok then [STATE (Vect (S n) Int), STDIO]
                          else [STATE (Vect n Int), STDIO])
readInt = do let x = trim !getStr
             case all isDigit (unpack x) of
                  False => pureM False
                  True => do putM (cast x :: !get)
                             pureM True

readN : (n : Nat) ->
        Eff () [STATE (Vect m Int), STDIO]
               [STATE (Vect (n + m) Int), STDIO]
readN Z = pure ()
readN {m} (S k) = case !readInt of
                      True => rewrite plusSuccRightSucc k m in readN k
                      False => readN (S k)
