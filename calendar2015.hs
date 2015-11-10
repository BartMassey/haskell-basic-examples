-- Copyright (c) 2015 Bart Massey
-- [This program is licensed under the "2-clause ('new') BSD License"]
-- Please see the file COPYING in the source
-- distribution of this software for license terms.

-- | First weekday of 2015, where 0 is Sunday.
start2015 :: Int
start2015 = 4

-- | Names and number of days in each month of 2015.
monthDays :: [(String, Int)]
monthDays = [
 ("January", 31), ("February", 28), ("March", 31),
 ("April", 30), ("May", 31), ("June", 30),
 ("July", 31), ("August", 31), ("September", 30),
 ("October", 31), ("November", 30), ("December", 31) ]

-- | Two-letter day name abbreviations.
dayNameWords :: [String]
dayNameWords = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

-- | Group a list into chunks of specified size, with
-- any shortage in the last chunk.
chunk :: Int -> [a] -> [[a]]
chunk n ws | length ws <= n = [ws]
chunk n ws =
    let (start, rest) = splitAt n ws in
    start : chunk n rest

-- | Build the calendar for a given month. Returns
-- the weekDay1 of the next month and the calendar text.
makeMonth :: Int -> (String, Int) -> (Int, String)
makeMonth weekDay1 (monthName, daysThisMonth) =
    ((weekDay1 + daysThisMonth) `mod` 7,
     unlines (map unwords calLines))
    where
      calLines = [monthName, "2015"] : dayNameWords : dayWords ++ [[]]
      dayWords = chunk 7 (padWords ++ dateWords)
      padWords = replicate weekDay1 "  "
      dateWords = map pad [1..daysThisMonth]
      pad n | n <= 9 = ' ' : show n
      pad n = show n

-- | Glue together the months to make a whole year.
-- This should arguably use 'Data.List.mapAccumL' rather
-- than recursion.
makeYear :: Int -> [(String, Int)] -> String
makeYear _ [] = ""
makeYear weekDay1 (month : months) =
    let (weekDay1', text) = makeMonth weekDay1 month in
    text ++ makeYear weekDay1' months

main :: IO ()
main = putStr (makeYear start2015 monthDays)
