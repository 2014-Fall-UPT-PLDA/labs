import Value

data Val = IntVal Integer
         | StringVal String
         | BooleanVal Bool
         -- since we are implementing a Functional language, functions are
         -- first class citizens.
         | FunVal [String]

--instance Integer Val where 
	--...

instance Eq Val where
	 (==) v1 v2 = case (v1, v2) of
	 				(IntVal x, IntVal y) -> x == y
	 				_ -> False 

isEqual:: (Eq a) => a -> a -> Bool
--isEqual:: (Eq a) => a -> a -> MysteryType -> Bool
isEqual = a == a

test1 = isEqual (IntVal 42) (IntVal 1)

test2 = isEqual 42 1