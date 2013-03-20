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
DIRECTIONS = {
    curses.KEY_UP: (0, -1),
    curses.KEY_RIGHT: (1, 0),
    curses.KEY_DOWN: (0, 1),
    curses.KEY_LEFT: (-1, 0),
}


def main(screen):
    x, y = 2, 2

    def draw_tile(tile):
        screen.addstr(y, x, tile)

    def move_player(new_x, new_y):
        if MAP[new_y][new_x] == ' ':
            return new_x, new_y
        return x, y

    for row in MAP:
        screen.addstr(row + '\n')
    key = None
    while key != KEY_QUIT:
        draw_tile('@')
        key = screen.getch()
        try:
            dx, dy = DIRECTIONS[key]
        except KeyError:
            pass
        else:
            draw_tile(' ')
            x, y = move_player(x + dx, y + dy)


if __name__ == '__main__':
    curses.wrapper(main)

