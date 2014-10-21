module Interpreter (Val(..), Expr(..), interpret) where

import Debug.Trace

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
         | ExtendEnv String Val Env
     deriving (Show, Eq)

-----------------------------------------------------------

-- the evaluate function takes an environment, which holds variable
-- bindings; i.e. it stores information like `x = 42`
-- the trace there will print out the values with which the function was called,
-- you can easily uncomment it if you don't need it for debugging anymore.
evaluate:: Expr -> Env -> Val
evaluate expr env = 
  trace("expr= " ++ (show expr) ++ "\n env= " ++ (show env)) $
  case expr of
  Const v -> v
  lhs :+: rhs -> 
    let valLhs = evaluate lhs env
        valRhs = evaluate rhs env
    in (IntVal $ (valToInteger valRhs) + (valToInteger valLhs))
  _ -> error $ "unimplemented expression: " ++ (show expr)

-----------------------------------------------------------
valError s v = error $ "expected: " ++ s ++ "; got: " ++ (show v)

-- helper function to remove some of the clutter in the evaluate function
valToInteger:: Val -> Integer
valToInteger (IntVal n) = n
valToInteger v = valError "IntVal" v

-----------------------------------------------------------
-- just an alias that we export in the module definition 
-- (see first line of file)
interpret :: Expr -> Val
interpret expr = evaluate expr EmptyEnv
