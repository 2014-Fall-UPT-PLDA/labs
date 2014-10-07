data Map = 
    Empty
  | KVPair String String Map 
  deriving (Show, Eq)

instance ShowInteger Map where
  showInteger m = case m of
                 Empty -> 0
                 KVPair _ _ t -> 1 + showInteger(t) 

class ShowInteger a where
  showInteger:: a -> Integer

testSI:: (ShowInteger a) => a -> Integer
testSI x = showInteger x

test:: (Show a, Eq a, Num a) => a -> String
test x = if (x == 42) then show "I got fortytwo"
            else show x


data AST = 
     IntC Integer
     -- 3 + 1; (1 + 2) + (1 + 2)
     | Add AST AST
     | PP AST
     deriving (Show, Eq)

evaluate :: AST -> Integer 
evaluate ast = case ast of
  IntC n -> n
  Add ast1 ast2 -> (evaluate ast1) + 
                   (evaluate ast2)
  PP e -> (evaluate e) + 1 

translateToJava :: AST -> String
translateToJava ast = case ast of
  IntC n -> undefined
  Add ast1 ast2 -> undefined
  PP e -> undefined

  --(Add (IntC 1) (IntC 2))




