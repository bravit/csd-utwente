data PaperState =  Written | Reviewing | Accepted | Rejected

data Paper : PaperState -> Type where
  MkPaper : Paper s

data PaperEvent : Type -> Type where
  Write  :                    PaperEvent (Paper Written)
  Submit : Paper Written   -> PaperEvent (Paper Reviewing) 
  Accept : Paper Reviewing -> PaperEvent (Paper Accepted)
  Reject : Paper Reviewing -> PaperEvent (Paper Rejected)
  Revise : Paper Rejected  -> PaperEvent (Paper Reviewing)

data PaperLang : Type -> Type where
  Action : PaperEvent a -> PaperLang a
  (>>=) : PaperLang a -> (a -> PaperLang b) -> PaperLang b

prog1 : PaperLang (Paper Accepted)
prog1 = Action Write >>= Action . Submit >>= Action . Accept

prog2 : PaperLang (Paper Accepted)
prog2 = do
   p <- Action Write
   p <- Action (Submit p)
   p <- Action (Reject p)
--   p <- Action (Revise p)
   Action (Accept p) 



















implicit
action : PaperEvent a -> PaperLang a
action = Action 

prog2' : PaperLang (Paper Accepted)
prog2' = do
   p <- Write
   p <- Submit p
   p <- Reject p
   p <- Revise p
   Accept p














syntax write = Action (Write)
syntax submit = \p => Action (Submit p)  
syntax accept = \p => Action (Accept p)
syntax reject = \p => Action (Reject p)  
syntax revise = \p => Action (Revise p)
syntax AcceptedPaper = PaperLang (Paper Accepted)


prog3 : AcceptedPaper
prog3 = write >>= submit >>= accept 

prog4 : AcceptedPaper
prog4 = write >>= submit >>= reject >>= revise >>= reject >>= revise >>= accept 
