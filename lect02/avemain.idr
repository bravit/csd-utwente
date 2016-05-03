module Main

{- 
Key points:
0) let/where, (:) for type annotations
1) Basic types: Int, Integer, Nat, Double, String (!), Char, Bool
2) Interfaces instead of Haskell's type classes: Cast, Num, Neg, etc
3) Lists : [], (::)
4) Function overloading: e.g. length for lists and strings
5) main and repl:
  main : IO ()
  repl : String -> (String -> String) -> IO ()
6) REPL commands: 
    :type
    :doc
    :exec
    :search
 7) Documenting functions with ||| and @arg_name     
 8) Higher-order functions: 
   map : Functor f => (a -> b) -> f a -> f b
 9) Coloured output: types are blue
-}

||| Calculate the average length of words in a string.
||| @str a string containing words separated by whitespace.
average : (str : String) -> Double
average str = let num_words = word_count str
                  total_length = sum (word_lengths (words str)) 
              in cast total_length / cast num_words
  where
    word_count : String -> Nat
    word_count str = length (words str)

    word_lengths : List String -> List Nat
    word_lengths strs = map length strs

showAverage : String -> String
showAverage str = "The average word length is: " ++ 
                  show (average str)  ++ "\n"

main : IO ()
main = repl "Enter a string: " showAverage
