#!/usr/bin/env python
# -*- coding: utf-8 -*-

import curses


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
    curses.KEY_UP: lambda x, y: (x, y-1),
    curses.KEY_DOWN: lambda x, y: (x, y+1),
    curses.KEY_LEFT: lambda x, y: (x-1, y),
    curses.KEY_RIGHT: lambda x, y: (x+1, y),
}


def main(screen):
    x, y = 2, 2

    def draw_tile(tile):
        screen.addstr(y, x, tile)

    def move_player(new_x, new_y):
        if MAP[new_x][new_y] == ' ':
            return new_x, new_y
        return x, y

    for row in MAP:
        screen.addstr(row + '\n')
    key = None
    while key != KEY_QUIT:
        draw_tile('@')
        key = screen.getch()
        try:
            new_position = MOVEMENT[key](x, y)
        except KeyError:
            pass
        else:
            draw_tile(' ')
            x, y = move_player(*new_position)


if __name__ == '__main__':
    curses.wrapper(main)

