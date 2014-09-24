
-- This file contains the implementation of Set in terms of a characteristic function. 
-- The characteristic function takes one parameter and it returns `True` if the parameter
-- is contained within the set and `False` otherwise


--here we are saying that singletonSet is a function that operates on some generic type `a`, 
--that has the constraints that it has to be an Integral, and an Eq. The function then takes one parameter
--of type `a` and returns a *function* that, in turn, takes a value of type `a` and returns a Bool
singletonSet :: (Integral a, Eq a) => a -> (a -> Bool)
singletonSet x = \y -> y == x

or' :: (Integral a, Eq a) => (a -> Bool) -> (a -> Bool) -> (a -> Bool)
or' s1 s2 = \y -> (s1 y) || (s2 y)

union :: (Integral a, Eq a) => (a -> Bool) -> (a -> Bool) -> (a -> Bool)
union s1 s2 = s1 `or'` s2

-- we ommit this type signature because the compiler can infer it!
diff s1 s2 = \y -> (s1 y) && not (s2 y)

--the definition of this set is why the generic type `a` now is constrained to being an Integral.
--the `mod` operation we are using is defined only for Integral values.
evenNumbersSet :: (Integral a, Eq a) => (a -> Bool)
evenNumbersSet = \y -> (y `mod` 2) == 0


set1 = singletonSet 1

set12 = union (singletonSet 2) set1

set2 = diff set12 $ set1

setOneOddAndInfiniteEven = union set1 $ evenNumbersSet

addN n = \x -> x + n 
add42 = addN 42
