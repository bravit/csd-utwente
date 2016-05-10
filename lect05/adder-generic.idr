AdderType : (numargs : Nat) -> (t : Type) -> Type
AdderType Z t = t
AdderType (S k) t = t -> AdderType k t

adder : Num t => (numargs : Nat) -> (acc : t) -> AdderType numargs t
adder Z acc = acc
adder (S k) acc = \i => adder k (acc+i)

