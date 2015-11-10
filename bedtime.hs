-- Copyright (c) 2015 Bart Massey
-- [This program is licensed under the "2-clause ('new') BSD License"]
-- Please see the file COPYING in the source
-- distribution of this software for license terms.

-- | Combine each possible prefix with each possible
-- suffix to produce a collection of strings.
(>>>) :: [String] -> [String] -> [String]
infixl 1 >>>
prefixes >>> suffixes = do
  p <- prefixes
  s <- suffixes
  return (p ++ " " ++ s)

-- | Combine a fixed prefix with each possible
-- suffix to produce a collection of strings.
(///) :: String -> [String] -> [String]
infixl 2 ///
prefix /// suffixes =
    [prefix] >>> suffixes

-- | Produce a list of all possible stories. This obviously
-- won't scale well beyond a certain point. (I have used a bit
-- of editorial license on the author's original story and fixed
-- some gender issues.)
stories :: [String]
stories =
    "There once was" /// ["a princess", "a cat", "a little girl"] >>>
    "who lived in" /// ["a shoe.", "a castle.", "an enchanted forest."] >>>
    "She found a" /// ["giant", "frog", "treasure chest"] >>>
    ["when she got lost", "while strolling along"] >>>
    "and immediately regretted it. Then a" ///
       ["lumberjack", "wolf", "magical pony"] >>>
    "named" /// ["Pinkie Pie", "Courage", "Natasha"] >>>
    "found her and" /// ["saved the day.", "granted her three wishes."] >>>
    ["The End."]

-- | Pick a story and read it. The user can pick; it would be
-- straightforward to pick randomly for them.
main = do
    let len = length stories
    putStrLn ("Enter a number from 1 to " ++ show len)
    n <- readLn
    putStrLn ""
    putStrLn (stories !! (n - 1))
