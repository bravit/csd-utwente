import Effects
import Effect.StdIO

hello : Eff () [STDIO]
hello = do
  putStr "Name? "
  x <- getStr
  putStrLn ("Hello " ++ trim x ++ "!")

main : IO ()
main = run hello
