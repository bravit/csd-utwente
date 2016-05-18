module Main

import Effects
import Effect.StdIO
import Effect.Exception
import Effect.State
import Effect.Random

data Expr = Val Integer
          | Var String
          | Add Expr Expr
          | Random Integer

Env : Type
Env = List (String, Integer)

EvalEff : Type -> Type
EvalEff t = Eff t [STDIO, EXCEPTION String, RND, STATE Env]

eval : Expr -> EvalEff Integer
eval (Val x) = pure x
eval (Add l r) = pure $ !(eval l) + !(eval r)
eval (Var x) = case lookup x !get of
                    Nothing => raise $ "No such variable " ++ x
                    Just val => pure val
eval (Random upper) = do val <- rndInt 0 upper
                         putStrLn $ "Random: " ++ (show val)
                         pure val

runEval : List (String, Integer) -> Expr -> IO Integer
runEval args expr = run (eval' expr)
  where eval' : Expr -> EvalEff Integer
        eval' e = do 
           put args
           eval e

main : IO ()
main = do 
  r <- runEval [("a", 5)] (Add (Var "a") (Random 10))
  printLn r
