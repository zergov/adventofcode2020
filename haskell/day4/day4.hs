import Data.List.Split
import Data.List
import Data.Char
import Data.Sort
import Text.Read

type Passport = String
type PassportAttribute = (String, String)

passportAttributes :: Passport -> [PassportAttribute]
passportAttributes p = map (\[x, y] -> (x, y)) . map (splitOn ":") . foldl1 (++) . map (splitOn " ") . lines $ p

part1 :: [Passport] -> Int
part1 = length . filter validate1 . map passportAttributes

validate1 :: [PassportAttribute] -> Bool
validate1 attrs = required == attributes
  where required = sort ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
        attributes = sort . filter (/= "cid") . map fst $ attrs

part2 :: [Passport] -> Int
part2 = length . filter validate2 . map passportAttributes

validate2 :: [PassportAttribute] -> Bool
validate2 attrs = validate1 attrs && all validateField attrs
  where validateField ("cid", _) = True
        validateField ("pid", xs) = (length xs) == 9 && (all isDigit xs)

        validateField ("ecl", "amb") = True
        validateField ("ecl", "blu") = True
        validateField ("ecl", "brn") = True
        validateField ("ecl", "gry") = True
        validateField ("ecl", "grn") = True
        validateField ("ecl", "hzl") = True
        validateField ("ecl", "oth") = True
        validateField ("ecl", _) = False

        validateField ("hcl", '#':xs) = (length xs == 6) && all ((flip elem) "0123456789abcdef") xs
        validateField ("hcl", _) = False

        validateField (key, val)
          | key == "byr" = n >= 1920 && n <= 2002
          | key == "iyr" = n >= 2010 && n <= 2020
          | key == "eyr" = n >= 2020 && n <= 2030
          | key == "hgt" && (isSuffixOf "cm" val) = hgtn >= 150 && hgtn <= 193
          | key == "hgt" && (isSuffixOf "in" val) = hgtn >= 59 && hgtn <= 76
          | otherwise = False
          where
                n = nval (readMaybe val :: Maybe Int)
                hgtn = nval (readMaybe (init . init $ val) :: Maybe Int)
                nval Nothing = 0
                nval (Just nn) = nn

main = do
    raw_input <- readFile "input"
    let passports = splitOn "\n\n" raw_input

    print $ part1 passports
    print $ part2 passports
