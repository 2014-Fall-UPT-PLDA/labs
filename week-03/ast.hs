data Val = IntV Integer
         | BoolV Bool
         | StringV String
         deriving (Show, Eq)

data Expr = Const Val
          | Expr :+: Expr
          deriving (Show, Eq)

eval :: Expr -> Val
eval (Const c) = c
eval (e1 :+: e2) = IntV $ valToInt (eval e1) + valToInt (eval e2)
eval _ = undefined

valToInt (IntV n) = n 


v1  = IntV 1
v42 = IntV 42
c1 = Const v1
c42 = Const v42
exprAdd = c1 :+: c42

