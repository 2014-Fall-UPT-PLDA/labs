quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (head:tail) = smaller ++ pivot ++ larger
                      where pivot = [head]
                            smaller = filter (< head) (quicksort tail)
                            larger = filter (> head) (quicksort tail)
