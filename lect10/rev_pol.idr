module Main

import Effects
import Effect.State

Stack : Type
Stack = List Int

push : Int -> Eff () [STATE Stack]
{-push a = do
  st <- get
  put (a :: st) 
  -}
--push a = put $ a :: !get
push = update . (::)

pop : Eff Int [STATE Stack]
pop = do
  (x :: xs) <- get
  put xs
  pure x

top : Eff Int [STATE Stack]
top = do 
  (x :: _) <- get
  pure x

tops : (Int -> Int -> Int) -> Eff () [STATE Stack]
--tops op = push $ !pop `op` !pop
{-tops op = do
  x <- pop
  y <- pop
  push (x `op` y)
-}
tops op = update (\(x :: y :: xs) => (x `op` y) :: xs)


step : String -> Eff () [STATE Stack]
step "+" = tops (+)
step "*" = tops (*)
step n   = push (cast n)

evalRPN : String -> Int
evalRPN s = runPure $ do
    mapE (\s => step s) (words s)
    pop

main : IO ()
main = putStrLn $ cast $ evalRPN "4 19 2 * +"

