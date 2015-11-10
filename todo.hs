-- Copyright © 2015 Bart Massey

-- | Maintain an interactive TODO list.
-- http://www.haskellforall.com/2015/10/basic-haskell-examples.html

-- | A TODO item is represented by its index and its note.
newtype ToDo = ToDo (Int, String)

-- | How to turn a TODO item into a 'String'.
instance Show ToDo where
    show (ToDo (index, desc)) =
        show index ++ ": " ++ desc

-- | The TODO list state is represented by an index of the
-- next item together with a list of 'ToDo' items.
data ToDoState = ToDoState {
      nextIndex :: Int,
      items :: [ToDo] }

-- | Repeat an action for its side effect until
-- it is done. The action should take a state and
-- produce either 'Just' the new state or 'Nothing'.
repeat_ :: (a -> IO (Maybe a)) -> a -> IO ()
repeat_ a state = do
  maybeState <- a state
  case maybeState of
    Nothing -> return ()
    Just state' -> repeat_ a state'

-- | Prompt and process a single command. Return 'Nothing'
-- if the command is to quit, otherwise the new state.
processCommand :: ToDoState -> IO (Maybe ToDoState)
processCommand state = do
  putStrLn ""
  putStrLn "Current TODO list:"
  putStrLn (unlines (map show (items state)))
  cmd <- getLine
  case words cmd of
    [] ->
        return (Just state)
    ["q"] ->
        return Nothing
    ("+" : desc) ->
        return (Just (state {nextIndex = nextIndex state + 1,
                             items = items state ++
                                     [ToDo (nextIndex state,
                                            unwords desc)]}))
    ["-", count] -> 
        case reads count of
          [(n, "")] ->
              return (Just (state {items = filter ok (items state)}))
              where
                ok (ToDo (n0, _)) = n /= n0
          _ -> do
            putStrLn "illegal count"
            return (Just state)
    _ -> do
      putStrLn "illegal command"
      return (Just state)

-- | Print some instructions, then process commands.
--
-- The main program here is interactive, so it will mostly be trapped
-- in the IO Monad. In Haskell, IO can be done by marking
-- function results to be IO functions. Any IO function can
-- call other IO functions, but ordinary functions cannot.
-- A special syntax ("do notation") is normally used to make
-- IO functions easier to write.
main :: IO ()
main = do
   putStrLn "Commands:"
   putStrLn "+ <String> - Add a TODO entry"
   putStrLn "- <Int>    - Delete the numbered entry"
   putStrLn "q          - Quit"
   repeat_ processCommand (ToDoState{nextIndex = 1, items = []})
