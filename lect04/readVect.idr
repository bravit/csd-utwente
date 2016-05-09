import Data.Vect

readVectLen : (len : Nat) -> IO (Vect len String)
readVectLen Z = pure []
readVectLen (S k) = do 
  s <- getLine
  xs <- readVectLen k
  pure (s :: xs)

readVect : IO (len ** Vect len String)
readVect = do
  s <- getLine
  if s == ""
    then pure (_ ** [])
    else do 
           (_ ** xs) <- readVect
           pure (_ ** s :: xs)


readAndZip : IO (len ** Vect len (String, String))
readAndZip = do
  (len1 ** v1) <- readVect
  (len2 ** v2) <- readVect
  case exactLength len1 v2 of
    Nothing => pure (_ ** [])
    (Just v) => pure (_ ** zip v1 v)
