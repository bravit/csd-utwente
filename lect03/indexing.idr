import Data.Vect

v : Vect 5 Nat
v = [1,2,3,4,5]

f6 : Fin 5
f6 = fromInteger 6

v6 : Nat
v6 = index 6 v
