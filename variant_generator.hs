import Data.Map (fromList, update, (!))
import Data.List (nub, find)
import Data.Maybe (fromJust)

digs :: Integral x => x -> [x]
digs 0 = []
digs x = x `mod` 10 : digs (x `div` 10)

enumerate list = enumerate' list (fromList $ zip [0..9] (replicate 10 0)) []
enumerate' [] _ res = res
enumerate' (x:xs) entries res = do
    let res' = res ++ [[x, entries ! x]] 
    let entries' = update (\o -> Just $ o + 1) x entries
    enumerate' xs entries' res'              

isUnique list = nub list == list

main = do
    let n = 555
    let last_three = reverse $ take 3 $ digs $ 421 * n
    let resNums = find isUnique $ iterate (map (\y -> mod (sum y) 10) . enumerate) last_three
    putStr $ concat $ map show (fromJust resNums)
