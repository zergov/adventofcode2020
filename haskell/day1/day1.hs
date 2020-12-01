part1 :: [Int] -> Int
part1 xs = head $ [ x * y | x <- xs, y <- xs, x + y == 2020 ]

part2 :: [Int] -> Int
part2 xs = head $ [ x * y * z | x <- xs, y <- xs, z <- xs, x + y + z == 2020 ]

main = do
  raw_input <- readFile "input"
  let input = map (read::String->Int) . lines $ raw_input

  print $ part1 input
  print $ part2 input
