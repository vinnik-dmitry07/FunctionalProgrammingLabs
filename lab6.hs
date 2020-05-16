import Control.Monad (join)

n = 9
f7 x = let temp = 1 / (x ^ 2  + logBase 10 n) in if isNaN temp then Nothing else Just temp
f8 x = let temp = logBase 10 (x - 1 / n)      in if isNaN temp then Nothing else Just temp
f9 x = let temp = sqrt (x - 1 / n)            in if isNaN temp then Nothing else Just temp

f9Bin x n = let temp = sqrt (x - 1 / n)       in if isNaN temp then Nothing else Just temp

sup x = f7 =<< f8 =<< f9 x
supDo x = do
    r1 <- f9 x
    r2 <- f8 r1
    f7 r2

supBin x = join $ f9Bin <$> f7 x <*> f8 x
supBinDo x = do
    r1 <- f7 x
    r2 <- f8 x
    f9Bin r1 r2 

main = do
    print $ supBinDo 1
