data Parity : Nat -> Type where
   Even : Parity (n + n)
   Odd  : Parity (S (n + n))

parity_lemma_1 : (j : Nat) -> Parity ((S j) + (S j)) -> Parity (S (S (plus j j)))
parity_lemma_1 j par = rewrite plusSuccRightSucc j j in par

parity_lemma_2 : (j : Nat) -> Parity (S ((S j) + (S j))) -> Parity (S (S (S (plus j j))))
parity_lemma_2 j par = rewrite plusSuccRightSucc j j in par

parity : (n : Nat) -> Parity n
parity Z = Even {n=Z}
parity (S Z) = Odd {n=Z}
parity (S (S k)) with (parity k)
  parity (S (S (j + j))) | Even = parity_lemma_1 j (Even {n=S j})
  parity (S (S (S (j + j)))) | Odd = parity_lemma_2 j (Odd {n=S j})

data Digit = I | O

natToBin : Nat -> List Digit
natToBin Z = []
natToBin k with (parity k)
  natToBin (n + n) | Even = O :: natToBin n
  natToBin (S (n + n)) | Odd = I :: natToBin n

