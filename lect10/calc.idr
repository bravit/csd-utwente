module Main

import Effects
import Effect.StdIO
import Effect.Exception
import Effect.State

calc_step : Int -> Eff () ['Sum ::: STATE Int, 'Prod ::: STATE Int]
calc_step a = do
  'Sum :- update (+a)
  'Prod :- update (*a)

calc : Eff (Int, Int) ['Sum ::: STATE Int, 'Prod ::: STATE Int]
calc = do
  calc_step 5
  calc_step 10
  calc_step 20
  s <- 'Sum :- get
  p <- 'Prod :- get
  pure (s, p)


calc_IO : Eff (Int, Int) ['Sum ::: STATE Int, 'Prod ::: STATE Int, STDIO]
calc_IO = do
  let x = trim !getStr
  case all isDigit (unpack x) of
     False => pure (!('Sum :- get), !('Prod :- get))
     True => do
               calc_step (cast x)
               calc_IO


main : IO ()
main = printLn  $ runPureInit ['Sum := 0, 'Prod := 1] (calc_step 5)
--main = printLn $ runPureInit ['Sum := 0, 'Prod := 1] calc
--main = runInit ['Sum := 0, 'Prod := 1, ()] calc_IO
