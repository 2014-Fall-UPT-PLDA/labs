data Expr = IntC Integer
          --integers
          | Expr :+: Expr
          deriving (Read, Show, Eq)

eval :: Expr -> Integer
eval (IntC n) = n
eval (e1 :+: e2) = eval e1 + eval e2
--eval _ = 42 


c1  = IntC 1
c42 = IntC 42
eAdd = c1 :+: c42

          