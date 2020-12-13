import Text.Read
import Data.List.Split

execute :: (Int, Int) -> (String, Int) -> (Int, Int)
execute (i, acc) ("acc", n) = (i + 1, acc + n)
execute (i, acc) ("jmp", n) = (i + n, acc)
execute (i, acc) ("nop", _) = (i + 1, acc)

parseOp :: String -> (String, Int)
parseOp "nop" = ("nop", 0)
parseOp operation = (op, arg)
    where [op, n] = splitOn " " operation
          arg = nval (readMaybe n :: Maybe Int)
          nval (Just n) = n
          nval (Nothing) = 0

part1 :: [(String, Int)] -> (Int, Int) -> [Int] -> (Int, Int, [Int])
part1 ops (i, acc) executed =
    if (i `elem` executed)
       then (i, acc, executed)
       else part1 ops (i', acc') (executed ++ [i])
    where (i', acc') = execute (i, acc) (ops !! i)

main = do
    raw_input <- readFile "input"
    let operations = map parseOp . lines $ raw_input

    print $ part1 operations (0, 0) []
