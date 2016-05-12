{-
data Dec : (prop : Type) -> Type where
  Yes : (prf : prop) -> Dec prop
  No : (contra : prop -> Void) -> Dec prop
-}

%default total

f : (2=3) -> Void
f Refl impossible

zero_notzero : (Z = S k) -> Void
zero_notzero Refl impossible

notsero_zero : (S k = Z) -> Void
notsero_zero Refl impossible

checkEqNat_rhs_4 : (contra : (k = j) -> Void) -> (S k = S j) -> Void
checkEqNat_rhs_4 contra Refl = contra Refl

checkEqNat : (num1 : Nat) -> (num2 : Nat) -> 
                             Dec (num1 = num2)
checkEqNat Z Z = Yes Refl
checkEqNat Z (S k) = No zero_notzero
checkEqNat (S k) Z = No notsero_zero
checkEqNat (S k) (S j) = 
     case checkEqNat k j of
           (Yes Refl) => Yes Refl
           (No contra) => No (checkEqNat_rhs_4 contra)
