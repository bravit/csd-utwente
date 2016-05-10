data Ty = TyNat | TyBool | TyString

toString : (ty : Ty) -> (case ty of
                              TyNat => Nat
                              TyBool => Bool
                              TyString => String) -> String
toString TyNat x = "Nat: " ++ show x
toString TyBool x = "Bool: " ++ show x
toString TyString x = "String: " ++ trim x
