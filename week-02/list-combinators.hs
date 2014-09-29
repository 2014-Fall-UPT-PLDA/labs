--pattern matching
map' :: (listType -> a) -> [listType] -> [a]
map' fun [] = []
map' fun (head:tail) = fun head : map' fun tail

--map with traditional recursive implementation
map'' :: (listType -> a) -> [listType] -> [a]
map'' fun list = if (isEmpty) 
                    then []
                    else newHead : newTail
               where isEmpty = null list
                     newHead = fun (head list)
                     newTail = map'' fun (tail list)

--map with desugared version of pattern-matching, i.e. case of
map''' :: (listType -> a) -> [listType] -> [a]
map''' fun list = 
    case list of
      [] -> []
      (head:tail) -> fun head : map' fun tail

--map using list comprehensions
map'''' :: (listType -> a) -> [listType] -> [a]
map'''' fun list = [fun x | x <- list]

--filter with pattern matching
filter' :: (listType -> Bool) -> [listType] -> [listType]
filter' predicate [] = []
filter' predicate (head:tail) = if (accept) 
                                   then head : filter' predicate tail
                                   else filter' predicate tail
                              where accept = predicate head

--filter with list comprehensions
filter'''' :: (listType -> Bool) -> [listType] -> [listType]
filter'''' predicate list = [x | x <- list, predicate x]

--fold'
fold' :: (listType -> accType -> accType) -> accType -> [listType] -> accType
fold' fun acc [] = acc
fold' fun acc (head:tail) = fold' fun newAcc tail
                     where newAcc = fun head acc


