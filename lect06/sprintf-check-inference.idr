
data Format = Number Format
            | Str Format
            | Lit String Format
            | End

%name Format fmt

SPrintfType : Format -> Type
SPrintfType (Number fmt) = Int -> SPrintfType fmt
SPrintfType (Str fmt) = String -> SPrintfType fmt
SPrintfType (Lit x fmt) = SPrintfType fmt
SPrintfType End = String

sprintfFmt : (fmt : Format) -> (acc : String) -> SPrintfType fmt
sprintfFmt (Number fmt) acc = \k => sprintfFmt fmt (acc ++ show k)
sprintfFmt (Str fmt) acc = \s => sprintfFmt fmt (acc ++ s)
sprintfFmt (Lit x fmt) acc = sprintfFmt fmt (acc ++ x)
sprintfFmt End acc = acc

toFormat2 : (xs : List Char) -> Format
toFormat2 [] = End
toFormat2 ('%' :: 'd' :: xs) = Number (toFormat2 xs)
toFormat2 ('%' :: 's' :: xs) = Str (toFormat2 xs)
toFormat2 ('%' :: xs) = Lit "c" (toFormat2 xs)
toFormat2 (x :: xs)  = case toFormat2 xs of
                           (Lit s fmt) => Lit (strCons x s) fmt
                           fmt => Lit (singleton x) fmt

toFormat : (xs : List Char) -> Format
toFormat [] = End
toFormat ('%' :: 'd' :: xs) = Number (toFormat xs)
toFormat ('%' :: 's' :: xs) = Str (toFormat xs)
toFormat ('%' :: xs) = Lit "%" (toFormat xs)
toFormat (x :: xs)  = case toFormat xs of
                           (Lit s fmt) => Lit (strCons x s) fmt
                           fmt => Lit (singleton x) fmt


sprintf : (fm : String) -> SPrintfType (toFormat (unpack fm))
sprintf fm =  let fmt = toFormat2 (unpack fm) in 
             sprintfFmt _ ""
{-             (%runElab
                            (do
                               search' 100 [
                                 NS (UN "toFormat") ["Main"], 
                                 NS (UN "unpack") ["Strings", "Prelude"]
                               ]
--                               debug
                               )) ""
-}

main : IO ()
main = do
  s <- getLine
  print $ sprintf "%s" "qqq"
  print ""
