splitByFactorial :: [Integer] -> [[Integer]]
splitByFactorial x = splitByFactorial' x (maximum x) 1

splitByFactorial' :: [Integer] -> Integer -> Integer -> [[Integer]]
splitByFactorial' x upperest_bound lower_bound = [x_i | x_i <- x, lower_bound <= x_i && x_i < upper_bound] : (if upper_bound < upperest_bound then (splitByFactorial' x upperest_bound upper_bound) else [])
  where upper_bound = lower_bound * (lower_bound + 1)

main = print $ splitByFactorial [1, 3, 5, 2, 6, 7, 12, 14, 9]
