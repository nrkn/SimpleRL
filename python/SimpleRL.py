#!/usr/bin/env python

import curses
from curses import KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT

MAP = [
  '####  ####',
  '#  ####  #',
  '#        #',
  '##      ##',
  ' #      # ',
  ' #      # ',
  '##      ##',
  '#        #',
  '#  ####  #',
  '####  ####',
]

KEY_QUIT = ord('q')

MOVEMENT = {
  KEY_UP:     lambda x, y: (x, y-1),
  KEY_DOWN:   lambda x, y: (x, y+1),
  KEY_LEFT:   lambda x, y: (x-1, y),
  KEY_RIGHT:  lambda x, y: (x+1, y),
}

def main(screen):
  x, y = 2, 2
  
  def draw_tile( tile ):
    screen.addstr(y, x, tile)

  def move_player( newX, newY ):
    return (newX, newY) if ( MAP[newX][newY] == ' ') else (x, y)

  for row in MAP: screen.addstr(row + '\n')
  
  key = None
  
  while key != KEY_QUIT:
    draw_tile('@')
    key = screen.getch()

    if key in [KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT]:
      draw_tile(' ')
      newXY = MOVEMENT[key](x, y)
      x,y = move_player(*newXY)

if __name__ == '__main__':
  curses.wrapper(main)