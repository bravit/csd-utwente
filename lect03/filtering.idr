import Data.Vect

v : Vect 5 Nat
v = [1,2,3,4,5]

evens : Vect m Nat -> (n ** Vect n Nat)
evens = filter (\x => mod x 2 == 0)
