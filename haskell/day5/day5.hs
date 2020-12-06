import Data.List

binaryspace :: (Int, Int) -> Char -> (Int, Int)
binaryspace (s, e) 'F' = (s, (s + e) `div` 2)
binaryspace (s, e) 'L' = (s, (s + e) `div` 2)
binaryspace (s, e) 'B' = (1 + ((s + e) `div` 2), e)
binaryspace (s, e) 'R' = (1 + ((s + e) `div` 2), e)

rowNumber :: String -> Int
rowNumber = fst . foldl binaryspace (0, 127) . take 7

colNumber :: String -> Int
colNumber = fst . foldl binaryspace (0, 7) . drop 7

seats :: [(Int, Int)]
seats = [(r, c) | r <- [0..127], c <- [0..7]]

seat :: String -> (Int, Int)
seat s = (rowNumber s, colNumber s)

seatId :: (Int, Int) -> Int
seatId (row, col) = row * 8 + col

part1 :: [String] -> Int
part1 = maximum . map (seatId . seat)

part2 :: [String] -> [(Int, Int)]
part2 xs = seats \\ (map seat xs)
-- by printing all of those values ^, we can see that (76, 7) stands out of the rest.
-- So our seat id is `seatId (76, 7) == 615`

main = do
    raw_input <- readFile "input"

    print $ part1 $ lines raw_input
    print $ part2 $ lines raw_input
    print $ seatId (76, 7)
