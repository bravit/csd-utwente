module Main

import Effects
import Effect.StdIO
import Effect.Exception

data EErr = NotANumber | OutOfRange

parseNumber : Int -> String -> Eff Int [EXCEPTION EErr]
parseNumber num str = do
  when (not $ all isDigit (unpack str)) $ raise NotANumber
  let x = cast str
  if (x >=0 && x <= num)
      then pure x
      else raise OutOfRange

work : Int -> String -> Eff Int [EXCEPTION EErr]
work up s = do 
  n <- parseNumber up s
  pure (n + 1)

io : Eff () [STDIO]
io = do
  putStr "Number (0-10)? "
  s <- getStr
  case run (work 10 s) of 
    Right n => putStrLn $ "OK: " ++ show n
    Left _ => putStrLn "Error"

main : IO ()
main = run io
