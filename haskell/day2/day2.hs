import Data.List.Split

data Entry = Entry Int Int Char String deriving (Show) -- low, high, letter, password

parseEntry :: String -> Entry
parseEntry input = Entry low high (head letter) password
  where [range, letter, password] = splitOn " " input
        [low, high] = map (read :: String -> Int) . splitOn "-" $ range

countChars :: Char -> String -> Int
countChars c = length . filter (== c)

part1 :: [Entry] -> Int
part1 = length . filter validate1

validate1 :: Entry -> Bool
validate1 (Entry low high letter password) = count >= low && count <= high
  where count = countChars letter password

part2 :: [Entry] -> Int
part2 = length . filter validate2

validate2 :: Entry -> Bool
validate2 (Entry low high letter password) = 1 == (countChars letter [x, y])
  where x = password !! (low - 1)
        y = password !! (high - 1)

main = do
    raw_input <- readFile "input"
    let input = map parseEntry . lines $ raw_input

    print $ part1 input
    print $ part2 input
