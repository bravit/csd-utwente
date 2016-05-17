import Data.Vect

{-
data Elem : a -> Vect k a -> Type where
  Here : Elem x (x :: xs)
  There : (later : Elem x xs) -> Elem x (y :: xs)
-}

oneInVector : Elem 1 [1,2,3]
oneInVector = Here

maryInVector : Elem "Mary" ["Peter", "Paul", "Mary"]
maryInVector = There (There Here)

notInVector : Elem 5 [1,2,3] -> Void
notInVector (There (There (There Here))) impossible
notInVector (There (There (There (There _)))) impossible
