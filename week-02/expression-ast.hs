data Expr = IntC Integer
          | Expr :+: Expr
          deriving (Show, Eq)

eval :: Expr -> Integer
eval (IntC n) = n
eval (e1 :+: e2) = eval e1 + eval e2
eval _ = undefined


c1  = IntC 1
c42 = IntC 42
exprAdd = c1 :+: c42

          