#include <curses.h>
const char *map =
    "####  ####\n"
    "#  ####  #\n"
    "#        #\n"
    "##      ##\n"
    " #      # \n"
    " #      # \n"
    "##      ##\n"
    "#        #\n"
    "#  ####  #\n"
    "####  ####\n";
int px = 1, py = 1;
void move_to(int x, int y) { if (map[y * 11 + x] == ' ') { px = x; py = y; } }
void simple_rl(void)
{
    int key;
    initscr(); noecho(); curs_set(0); keypad(stdscr, 1);
    mvaddstr(0, 0, map); mvaddch(py, px, '@');
    while ((key = getch()) != 'q') {
        mvaddch(py, px, ' ');
        switch (key) {
        case KEY_UP: move_to(px, py - 1); break;
        case KEY_DOWN: move_to(px, py + 1); break;
        case KEY_LEFT: move_to(px - 1, py); break;
        case KEY_RIGHT: move_to(px + 1, py); break;
        }
        mvaddch(py, px, '@');
    }
    endwin();
}

int main(void) { simple_rl(); return 0; } 