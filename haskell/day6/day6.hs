import Data.List.Split
import Data.List
import qualified Data.Map as M

type Group = [String]
type AnswerMap = M.Map Char Int

parseInput :: String -> [Group]
parseInput raw = map lines $ groups
  where groups = splitOn "\n\n" raw

part1 :: [Group] -> Int
part1 groups = sum $ map yesPerGroup groups
    where yesPerGroup = length . nub . foldl1 (++)

-- part2 :: [Group] -> Int
part2 groups = (head groups)
    where addAnswers :: AnswerMap -> String -> AnswerMap
          addAnswers am answers = foldl (\c m -> M.insertWith' (+) c 1 m) mm

answersMap :: M.Map Char Int
answersMap = M.fromList [(c, 0) | c <- ['a'..'z']]

main = do
    raw_input <- readFile "input"
    let groups = parseInput raw_input

    -- print $ part1 groups
    print $ part2 groups
