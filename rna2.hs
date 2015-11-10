-- | Group a list into chunks of specified size, with
-- any shortage in the last chunk.
chunk :: Int -> [a] -> [[a]]
chunk n ws | length ws <= n = [ws]
chunk n ws =
    let (start, rest) = splitAt n ws in
    start : chunk n rest

-- | Return the first match of the RNA triple in
-- the AA decoding table.
findTriple :: [[String]] -> String -> String
findTriple [] triple = error ("triple not found: " ++ triple)
findTriple ([pattern, target] : _) triple 
    | and (zipWith sloppyEqual pattern triple) = target
    where
      sloppyEqual '_' target = True
      sloppyEqual pattern target = pattern == target
findTriple (_ : table) triple =
    findTriple table triple

-- | Read in the RNA -> AA table and process the input.
main :: IO ()
main = do
  tableData <- readFile "rna.txt"
  let table = map words (lines tableData)
  interact (concatMap (findTriple table) . chunk 3)
  putStrLn ""