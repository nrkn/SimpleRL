module Main where

import UI.HSCurses.Curses
import Data.Array.IArray

type Coord = (Int, Int)

gameMap :: Array Coord Char
gameMap = 
    let xs = ["####  ####",
              "#  ####  #",
              "#        #",
              "##      ##",
              " #      # ",
              " #      # ",
              "##      ##",
              "#        #",
              "#  ####  #",
              "####  ####"] in
    listArray ((0, 0), (length (head xs) - 1, length xs - 1)) $ concat xs

-- note: Curses uses (y, x) addressing, going against all good sense, and the
-- first thing any self-respecting roguelike developer should do is write a
-- translation layer that returns sanity
-- also, Haskell's Char represent Unicode characters in an abstract manner;
-- passing through Enum probably isn't the cleanest way to convert them into
-- characters as understood by Curses, but it'll work within the 7-bit ASCII
-- range
renderAt :: Coord -> Char -> IO ()
renderAt (x, y) c =
    mvAddCh y x (toEnum $ fromEnum c)

moveIfOk f c 
    | gameMap ! f c /= ' ' = c
    | otherwise = f c

-- gameLoop takes the player's position as its only argument. In a more complex
-- roguelike, it would take a more complex /game state/ as its argument, or
-- equivalently be a computation in a state monad containing the game state.
gameLoop :: Coord -> IO ()
gameLoop playerPosition = do
  mapM_ (\c -> renderAt c $ if c == playerPosition then '@' else gameMap ! c) 
            $ range $ bounds gameMap
  refresh
  key <- getCh
  case key of
    KeyLeft  -> gameLoop $ moveIfOk (\(x, y) -> (x - 1, y)) playerPosition
    KeyRight -> gameLoop $ moveIfOk (\(x, y) -> (x + 1, y)) playerPosition
    KeyDown  -> gameLoop $ moveIfOk (\(x, y) -> (x, y + 1)) playerPosition
    KeyUp    -> gameLoop $ moveIfOk (\(x, y) -> (x, y - 1)) playerPosition
    KeyChar 'q' -> return ()
    _ -> gameLoop playerPosition

main = do
  scr <- initScr
  keypad scr True
  echo False
  cursSet CursorInvisible
  gameLoop (5, 5)
  endWin