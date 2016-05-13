{-
data LTE  : (n, m : Nat) -> Type where
  LTEZero : LTE Z    right
  LTESucc : LTE left right -> LTE (S left) (S right)

GTE : Nat -> Nat -> Type
GTE left right = LTE right left

total LT : Nat -> Nat -> Type
LT left right = LTE (S left) right

total GT : Nat -> Nat -> Type
GT left right = LT right left

isLTE : (m, n : Nat) -> Dec (m `LTE` n)
-}

-- if not(x <= y) then (x > y)
not_lte__gt : Not (x `LTE` y) -> x `GT` y
not_lte__gt {x = Z} {y = y} contra = absurd (contra LTEZero)
not_lte__gt {x = (S k)} {y = Z} contra = LTESucc LTEZero
not_lte__gt {x = (S k)} {y = (S j)} contra = LTESucc (not_lte__gt (\__pi_arg => contra (LTESucc (__pi_arg))))

-- if x > y then y <= x
gt__lte : x `GT` y -> y `LTE` x 

-- if not(x <= y) then (y <= x)
not_lte__lte : Not (x `LTE` y) -> y `LTE` x 

