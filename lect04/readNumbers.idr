readNumber : IO (Maybe Nat)
readNumber = do
   s <- getLine
   if all isDigit (unpack s)
     then pure (Just (cast s))
     else pure Nothing

readNumbers : IO (Maybe (Nat, Nat))
readNumbers = do
  n1 <- readNumber
  n2 <- readNumber
  case n1 of
    Nothing => pure Nothing
    (Just x) => ?h1_2

readNumbers' : IO (Maybe (Nat, Nat))
readNumbers' = do
  Just n1 <- readNumber | Nothing => pure Nothing
  Just n2 <- readNumber | Nothing => pure Nothing
  pure (Just (n1, n2))
