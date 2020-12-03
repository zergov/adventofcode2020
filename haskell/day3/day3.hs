type Grid = [String]
type Point = (Int, Int)

itemAt :: Grid -> Point -> Char
itemAt grid (i, j) = (grid !! i) !! j

slope :: Grid -> Int -> Int -> Int -> Point -> Point -> Int
slope grid h w tree (i, j) (di, dj) =
    if i < h
       then slope grid h w ntree (ii, jj) (di, dj)
       else tree
    where ii = i + di
          jj = (j + dj) `mod` w
          ntree = if item == '#' then tree + 1 else tree
          item = itemAt grid (i, j)

part1 :: Grid -> Int -> Int -> Int
part1 grid h w = slope grid h w 0 (0, 0) (1, 3)

part2 :: Grid -> Int -> Int -> Int
part2 grid h w = foldl1 (*) [slope1, slope2, slope3, slope4, slope5]
  where slope1 = slope grid h w 0 (0, 0) (1, 1)
        slope2 = slope grid h w 0 (0, 0) (1, 3)
        slope3 = slope grid h w 0 (0, 0) (1, 5)
        slope4 = slope grid h w 0 (0, 0) (1, 7)
        slope5 = slope grid h w 0 (0, 0) (2, 1)

main = do
    raw_input <- readFile "input"
    let grid = lines raw_input
    let height = length grid
    let width = length (grid !! 0)

    print $ part1 grid height width
    print $ part2 grid height width
