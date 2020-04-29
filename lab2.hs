splitByFactorial :: [Integer] -> [[Integer]]
splitByFactorial list = splitByFactorial' list (maximum list) 2 1

splitByFactorial' :: [Integer] -> Integer -> Integer -> Integer -> [[Integer]]
splitByFactorial' list upperest_bound i lower_bound = 
  [l |  l <- list, lower_bound <= l && l < upper_bound] : 
      (if upper_bound < upperest_bound 
        then (splitByFactorial' list upperest_bound (i + 1) upper_bound) 
        else [])
    where upper_bound = lower_bound * i

main = print $ splitByFactorial [1, 3, 5, 2, 6, 7, 12, 14, 9]
