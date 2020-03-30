import Data.List

main = do
  let list = [1, 2, 3, 3]
  print $ elemIndices (foldr1 min list) list
