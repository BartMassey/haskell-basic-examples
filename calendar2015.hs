import Data.List (mapAccumL)

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

-- | Actually make the calendar.
makeCalendar :: String
makeCalendar =
    concat (snd (mapAccumL makeMonth start2015 monthDays))
    where
      makeMonth weekDay1 (monthName, daysThisMonth) =
          let calLines = [monthName, "2015"] : dayNameWords :
                         (dayWords ++ [[]]) in
          ((weekDay1 + daysThisMonth) `mod` 7,
           unlines (map unwords calLines))
          where
            dayNameWords = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
            group7 :: [String] -> [[String]]
            group7 ws | length ws <= 7 = [ws]
            group7 ws =
                let (start, rest) = splitAt 7 ws in
                start : group7 rest
            dayWords :: [[String]]
            dayWords =
                group7 (padWords ++ countWords)
                where
                  padWords = replicate weekDay1 "  "
                  countWords =
                      map pad [1..daysThisMonth]
                      where
                        pad n | n <= 9 = " " ++ show n
                        pad n = show n

main :: IO ()
main = putStr makeCalendar
