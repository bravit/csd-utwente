data Ty = TyNat | TyBool | TyString



infinity : Type
infinity = infinity

nt : (ty : Ty) -> Type
nt TyNat = Nat
nt TyBool = Bool

f : Nat -> infinity
f k = f k

h : Lazy infinity -> String
h _ = "42"


g : (ty : Ty) -> nt ty
g TyNat = ?Z
g TyBool = ?g_rhs_2
g TyString = ?g_rhs_3

