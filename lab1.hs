import Data.List

count :: Eq a => a -> [a] -> Int
count x = length . filter (x ==)

getDistribution :: Ord a => [a] -> [(a, Int)]
getDistribution list = map (\element -> (element, count element list)) (sort $ nub list)
main = 
  putStr $ 
  unlines $ 
  map 
    (\(element, entrances) ->  (show element) ++ " - " ++ (show entrances)) $
    getDistribution [1, 2, 3, 3]
  
