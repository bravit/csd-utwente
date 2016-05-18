module Main

import Effects
import Effect.StdIO
import Effect.System
import Effect.Random

dice3 : Eff (Integer, Integer, Integer) [RND]
dice3 = do 
  a <- rndInt 1 6
  b <- rndInt 1 6
  c <- rndInt 1 6
  pure (a,b,c)

cast_dice : Eff () [RND,STDIO,SYSTEM]
cast_dice = do
  t <- time
  srand t
  (a, b, c) <- dice3
  printLn (a,b,c)
    
main : IO ()
main = run cast_dice
