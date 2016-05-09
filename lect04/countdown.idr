import System

countdown : Nat -> IO ()
countdown Z = putStrLn "Done"
countdown (S k) = do
  printLn (S k)
  usleep 1000000
  countdown k
