module Main

import Data.Vect
import Data.Fin

data Ty = TyInt | TyBool | TyFun Ty Ty

interpTy : Ty -> Type
interpTy TyInt       = Int
interpTy TyBool      = Bool
interpTy (TyFun s t) = interpTy s -> interpTy t

using (G : Vect n Ty)

  data Env : Vect n Ty -> Type where
      Nil  : Env Nil
      (::) : interpTy a -> Env G -> Env (a :: G)

  data HasType : (i : Fin n) -> Vect n Ty -> Ty -> Type where
      Stop : HasType FZ (t :: G) t
      Pop  : HasType k G t -> HasType (FS k) (u :: G) t

  lookup : HasType i G t -> Env G -> interpTy t
  lookup Stop    (x :: xs) = x
  lookup (Pop k) (x :: xs) = lookup k xs
  lookup Stop    [] impossible

  data Expr : Vect n Ty -> Ty -> Type where
      Var : HasType i G t -> Expr G t
      Val : (x : Int) -> Expr G TyInt
      Lam : Expr (a :: G) t -> Expr G (TyFun a t)
      App : Lazy (Expr G (TyFun a t)) -> Expr G a -> Expr G t
      Op  : (interpTy a -> interpTy b -> interpTy c) -> Expr G a -> Expr G b ->
            Expr G c
      If  : Expr G TyBool -> Expr G a -> Expr G a -> Expr G a

  lam_ : TTName -> Expr (a :: G) t -> Expr G (TyFun a t)
  lam_ _ = Lam

  dsl expr
      lambda = lam_
      variable = Var
      index_first = Stop
      index_next = Pop

  total
  interp : Env G -> (e : Expr G t) -> interpTy t
  interp env (Var i)     = lookup i env
  interp env (Val x)     = x
  interp env (Lam sc)    = \x => interp (x :: env) sc
  interp env (App f s)   = (interp env f) (interp env s)
  interp env (Op op x y) = op (interp env x) (interp env y)
  interp env (If x t e)  = if interp env x then interp env t else interp env e

  eId : Expr G (TyFun TyInt TyInt)
  eId = expr (\x => x)

  eTEST : Expr G (TyFun TyInt (TyFun TyInt TyInt))
  eTEST = expr (\x, y => y)

  eAdd : Expr G (TyFun TyInt (TyFun TyInt TyInt))
  eAdd = expr (\x, y => Op (+) x y)

  eDouble : Expr G (TyFun TyInt TyInt)
  eDouble = expr (\x => App (App eAdd x) (Var Stop))

--   app : Lazy (Expr G (TyFun a t)) -> Expr G a -> Expr G t
--   app = \f, a => App (Force f) a

  eFac : Expr G (TyFun TyInt TyInt)
  eFac = expr (\x => If (Op (==) x (Val 0))
                 (Val 1)
                 (Op (*) (App eFac (Op (-) x (Val 1))) x))

  eadd : Expr G (TyFun TyInt (TyFun TyInt TyInt))
  eadd = Lam (Lam (Op (+) (Var Stop) (Var (Pop Stop))))
  
  ef : Expr G TyInt
  ef = App (App eadd (Val 5)) (Val 10)


testFac : Int
testFac = interp [] eFac 4

testEnv : Int -> Env [TyInt,TyInt]
testEnv x = [x,x]

main : IO ()
main = printLn testFac
            



