{-# LANGUAGE FlexibleInstances #-}
-- Copyright (c) 2015 Bart Massey
-- [This program is licensed under the "2-clause ('new') BSD License"]
-- Please see the file COPYING in the source
-- distribution of this software for license terms.

-- | Typeclass for producing an option list from various story
-- elements.
class StringList element where
    get :: element -> [String]

-- | Produce an option list from a string by making it a
-- singleton option list.
instance StringList String where
    get string = [string]

-- | A list of option strings is already an option list.
instance StringList ([] String) where
    get = id

-- | Combine each possible prefix with each possible
-- suffix to produce a collection of strings.
(>>>) :: StringList a => a -> [String] -> [String]
infixr 1 >>>
prefixes >>> suffixes = do
  p <- get prefixes
  s <- suffixes
  return (p ++ " " ++ s)

-- | Special case for the end of the story.
fini :: [String]
fini = [""]

-- | Produce a list of all possible stories. This obviously
-- won't scale well beyond a certain point. (I have used a bit
-- of editorial license on the author's original story and fixed
-- some gender issues.)
stories :: [String]
stories =
    "There once was" >>> ["a princess", "a cat", "a little girl"] >>>
    "who lived in" >>> ["a shoe.", "a castle.", "an enchanted forest."] >>>
    "She found a" >>> ["giant", "frog", "treasure chest"] >>>
    ["when she got lost", "while strolling along"] >>>
    "and immediately regretted it. Then a" >>>
    ["lumberjack", "wolf", "magical pony"] >>>
    "named" >>> ["Pinkie Pie", "Courage", "Natasha"] >>>
    "found her and" >>> ["saved the day.", "granted her three wishes."] >>>
    fini

-- | Word wrap the story to 60-column lines for readability.
-- This is pretty gross, and could be cleaned up a bit using
-- 'Data.List.mapAccumL', but I'm not sure that's better.
wordWrap :: String -> String
wordWrap story =
    unlines $ map unwords $ accum60 0 $ words story
    where
      accum60 _ [] = [[]]
      accum60 n (w : ws) | n' < 60 =
          (w : l) : ls
          where
            n' = n + 1 + length w
            l : ls = accum60 n' ws
      accum60 _ (w : ws) =
          [w] : accum60 0 ws

-- | Pick a story and read it. The user can pick; it would be
-- straightforward to pick randomly for them.
main :: IO ()
main = do
    let len = length stories
    putStrLn ("Enter a number from 1 to " ++ show len)
    n <- readLn
    putStrLn ""
    putStr (wordWrap (stories !! (n - 1)))
    putStrLn "The End."
