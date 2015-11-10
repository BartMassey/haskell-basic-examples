tabComma :: Char -> Char
tabComma '\t' = ','
tabComma c = c

main :: IO ()
main = interact (map tabComma)
