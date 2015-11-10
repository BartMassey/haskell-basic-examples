-- Copyright (c) 2015 Bart Massey
-- [This program is licensed under the "2-clause ('new') BSD License"]
-- Please see the file COPYING in the source
-- distribution of this software for license terms.

import Text.SSV

tsvFormat :: SSVFormat
tsvFormat = csvFormat { ssvFormatSeparator = '\t' }

main :: IO ()
main = interact (showCSV . readSSV tsvFormat)
