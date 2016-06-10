-- Copyright (c) 2015 Bart Massey
-- [This program is licensed under the "2-clause ('new') BSD License"]
-- Please see the file COPYING in the source
-- distribution of this software for license terms.

import Data.List (find)

-- | Group a list into chunks of specified size, with
-- any shortage in the last chunk.
chunk :: Int -> [a] -> [[a]]
chunk _ [] = []
chunk n ws =
    let (start, rest) = splitAt n ws in
    start : chunk n rest

-- | Return true iff the target matches the AA decoding table pattern.
okTriple :: String -> [String] -> Bool
okTriple triple [pattern, _] | length triple /= length pattern = False
okTriple triple [pattern, _] =
    and (zipWith sloppyEqual pattern triple)
    where
      sloppyEqual '_' _ = True
      sloppyEqual patternChar tripleChar = patternChar == tripleChar
okTriple _ entry = error ("bad decoding table entry: " ++ show entry)

-- | Look up the appropriate pattern in the decoding table
-- and return the matching target.
findTriple :: [[String]] -> String -> String
findTriple table triple =
    case find (okTriple triple) table of
      Just [_, target] -> target
      _ -> error ("triple not found: " ++ triple)

-- | Read in the RNA -> AA table and process the input. Note that the use
-- of "triple" in this code is misleading: it will work fine for any
-- nonzero-length table patterns and input strings.
main :: IO ()
main = do
  tableData <- readFile "rna.txt"
  let table = map words (lines tableData)
  interact (concatMap (findTriple table) . chunk 3)
  putStrLn ""
