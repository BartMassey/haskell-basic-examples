import Text.SSV

tsvFormat :: SSVFormat
tsvFormat = csvFormat { ssvFormatSeparator = '\t' }

main :: IO ()
main = interact (showCSV . readSSV tsvFormat)
