data Ty = TyNat | TyBool | TyString

evalType :  Ty -> Type
evalType TyNat = Nat
evalType TyBool = Bool
evalType TyString = String

initVal : (ty : Ty) -> evalType ty
initVal TyNat = 0
initVal TyBool = False
initVal TyString = ""

toString : (ty : Ty) -> evalType ty -> String
toString TyNat x = "Nat: " ++ show x
toString TyBool x = "Bool: " ++ show x
toString TyString x = "String: " ++ trim x


