module Main

import Effects
import Effect.StdIO
import Effect.System

printArgs : Eff () [STDIO, SYSTEM]
printArgs = do 
  args <- getArgs
  printLn args

main : IO ()
main = run printArgs
