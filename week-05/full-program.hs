import Debug.Trace

main = 
  let read = getLine in
      read >>= (\whatIread ->
         putStrLn $ whatIread ++ " yey!") 
  
  --readStuff <- getLine
  --putStrLn $ readStuff ++ " yey!"
  --fmap (++ "yey") getLine 
  -- >>=, >>

--testFail ::(Show a) => a -> [a]
--testFail x = fail $ (show x) ++ " I failed." 

primes :: [Integer]
primes = sieve [2..]
sieve :: [Integer] -> [Integer]
sieve (prime:xs) = 
  --trace ((show prime) ++ (show (take 10 xs)) $
  prime : (sieve (filter pred xs))
  where pred = (\x -> (x `mod` prime) /= 0)