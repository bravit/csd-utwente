module Main

import Effects
import Effect.File
import Effect.StdIO
import Effect.System

readFile : Eff (List String) [FILE_IO (OpenFile Read)]
readFile = readAcc [] where
    readAcc : List String -> Eff (List String) [FILE_IO (OpenFile Read)]
    readAcc acc = if (not !eof)
                     then readAcc (!readLine :: acc)
                     else pure (reverse acc)

dumpFile : String -> Eff () [FILE_IO (), STDIO]
dumpFile name = case !(open name Read) of
                    True => do putStrLn (show !readFile)
                               close
                    False => putStrLn ("Error!")

emain : Eff () [FILE_IO (), SYSTEM, STDIO]
emain = do 
  [prog, name] <- getArgs | [] => putStrLn "Can't happen!"
                          | [prog] => putStrLn "No arguments!"
                          | _ => putStrLn "Too many arguments!"
  dumpFile name

main : IO ()
main = run emain
