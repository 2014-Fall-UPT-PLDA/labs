map' :: (listType -> a) -> [listType] -> [a]
map' fun [] = []
map' fun (head:tail) = fun head : map' fun tail

map'' :: (listType -> a) -> [listType] -> [a]
map'' fun list = if (isEmpty) 
                    then []
                    else newHead : newTail
               where isEmpty = null list
                     newHead = fun (head list)
                     newTail = map'' fun (tail list)

filter' :: (listType -> Bool) -> [listType] -> [listType]
filter' predicate [] = []
filter' predicate (head:tail) = if (accept) 
                                   then head : filter' predicate tail
                                   else filter' predicate tail
                              where accept = predicate head

fold' :: (listType -> accType -> accType) -> accType -> [listType] -> accType
fold' fun acc [] = acc
fold' fun acc (head:tail) = fold' fun newAcc tail
                     where newAcc = fun head acc


