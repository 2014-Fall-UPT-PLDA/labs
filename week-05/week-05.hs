{--
f
for (String s : listOfString) {
	--String temp = 
		f(s, addBuffer)
	--buffer.add(temp)
}
--}
import Data.List

head' :: [a] -> Maybe a
head' [] = Nothing
head' (x:xs) = Just x

sum42First :: (Num a) => [a] -> Maybe a
sum42First l = fmap (+ 42) (head' l)

test :: a -> [a]
test x = [x]
