quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (head:tail) = smaller ++ [pivot] ++ larger
                      where pivot = head
                            smaller = filter (< pivot) (quicksort tail)
                            larger = filter (> pivot) (quicksort tail)
