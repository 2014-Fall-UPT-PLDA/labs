module Interpreter (Val(..), Expr(..), interpret) where

data Val = IntVal Integer
         | StringVal String
         | BooleanVal Bool
         -- since we are implementing a Functional language, functions are
         -- first class citizens.
         | FunVal [String] Expr Env
     deriving (Show, Eq)

-----------------------------------------------------------

data Expr = Const Val
          -- represents a variable
          | Var String
          -- integer multiplication
          | Expr :*: Expr 
          -- integer addition and string concatenation
          | Expr :+: Expr 
          -- equality test. Defined for all Val except FunVal
          | Expr :==: Expr 
          -- semantically equivalent to a Haskell `if`
          | If Expr Expr Expr
          -- binds a Var (the first `Expr`) to a value (the second `Expr`), 
          -- and makes that binding available in the third expression
          | Let Expr Expr Expr
          -- creates an anonymous function with an arbitrary number of parameters
          | Lambda [Expr] Expr 
          -- calls a function with an arbitrary number values for parameters
          | Apply Expr [Expr]
     deriving (Show, Eq)

-----------------------------------------------------------

data Env = EmptyEnv
         | ExtendEnv String Val
     deriving (Show, Eq)

-----------------------------------------------------------

-- the evaluate function takes an environment, which holds variable
-- bindings; i.e. it stores information like `x = 42`
evaluate:: Expr -> Env -> Val
evaluate expr env = case expr of
  Const v -> v
  _ -> undefined

-----------------------------------------------------------
-- just an alias that we export in the module definition 
-- (see first line of file)
interpret :: Expr -> Val
interpret expr = evaluate expr EmptyEnv