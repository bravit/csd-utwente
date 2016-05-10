
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

toFormat : (xs : List Char) -> Format
toFormat [] = End
toFormat ('%' :: 'd' :: xs) = Number (toFormat xs)
toFormat ('%' :: 's' :: xs) = Str (toFormat xs)
toFormat ('%' :: xs) = Lit "%" (toFormat xs)
toFormat (x :: xs)  = case toFormat xs of
                           (Lit s fmt) => Lit (strCons x s) fmt
                           fmt => Lit (singleton x) fmt

sprintf : (fmt : String) -> SPrintfType (toFormat (unpack fmt))
sprintf fmt = sprintfFmt _  ""

main : IO ()
main = do
  s <- getLine
  print $ sprintf "%s" s
  print ""
