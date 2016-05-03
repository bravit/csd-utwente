import Data.Vect

{-
Key points 5:
1) Implicit arguments in type annotations
2) _ for inferred arguments (can be of any type, here Nat):
  Data.Vect.replicate : (n : Nat) -> a -> Vect n a
3) Using implicit arguments in function's equations: {m}
4) Case splitting over implicit arguments: {m=Z}
5) Providing values for implicit arguments when they
 cannot be inferred: 
 > create_empties {a=Nat} {m=5} 
-}

create_empties' : Vect m (Vect 0 a)
create_empties' = replicate _ []

create_empties : Vect m (Vect 0 a)
create_empties {a = a} {m = Z}  = []
create_empties {a = a} {m = (S k)}  = [] :: create_empties


transpose : Vect n (Vect m a) -> Vect m (Vect n a)
transpose [] = create_empties
transpose (x :: xs) = ?transpose_rhs_2

