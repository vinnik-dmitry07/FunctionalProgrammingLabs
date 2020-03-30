split_by_factorial :: [Integer] -> [[Integer]]
split_by_factorial x = split_by_factorial' x (maximum x) 1

split_by_factorial' :: [Integer] -> Integer -> Integer -> [[Integer]]
split_by_factorial' x upperest_bound lower_bound = [x_i | x_i <- x, lower_bound <= x_i && x_i < upper_bound] : (if upper_bound < upperest_bound then (split_by_factorial' x upperest_bound upper_bound) else [])
  where upper_bound = lower_bound * (lower_bound + 1)

main = print $ split_by_factorial [1, 3, 5, 2, 6, 7, 12, 14, 9]
