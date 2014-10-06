class MyEq a where
  myEq :: a -> a -> Bool

data Ex = IntC Integer

instance MyEq Ex where
  myEq (IntC n) (IntC m) = n == m