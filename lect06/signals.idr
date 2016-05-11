data SignalPreference s = Default s | Received | Corrected (s->s)

preprocess : Monad m => m s -> SignalPreference s -> m s
preprocess ms sp = case sp of
                     Default s => pure s
                     Received => ms
                     Corrected f => map f ms

process : Monad m => s -> m s
process = pure . id

postprocess : Monad m => (s -> s) -> s -> m s
postprocess f = pure . f



signal : Monad m => m s -> m (SignalPreference s) -> (s -> s) -> m s
signal ms sp f = sp >>= preprocess ms >>= process >>= postprocess f


signal' : Monad m => m s -> m (SignalPreference s) -> (s -> s) -> m s
signal' ms sp f = do
  sp' <- sp
  s <- preprocess ms sp'
  s' <- process s 
  postprocess f s'



test : List Integer
test = signal [1,2] [Corrected (+1), Received, Default 0]  (+1)

-- process = do

sig2 : (Alternative m, Monad m, Ord s) => m s
                                       -> m s
                                       -> m (SignalPreference s)
                                       -> (s -> s)
                                       -> m s
sig2 ms1 ms2 sp f = do
  s1 <- ms1
  s2 <- ms2
  s <- signal ms1 sp f <|> signal ms2 sp f
  guard (s1 < s && s < s2)
  pure s

sig2' : (Alternative m, Monad m, Ord s) => m s
                                       -> m s
                                       -> m (SignalPreference s)
                                       -> (s -> s)
                                       -> m s
sig2' ms1 ms2 sp f = [ s | s1 <- ms1, 
                           s2 <- ms2, 
                           s <- signal ms1 sp f <|> signal ms2 sp f, 
                           s1 < s && s < s2]
