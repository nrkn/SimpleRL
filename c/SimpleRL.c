#include <conio.h>

typedef struct { int x; int y; } Point;

char Map[] = "####  ####\r\n"
             "#  ####  #\r\n"
             "#        #\r\n"
             "##      ##\r\n"
             " #      # \r\n"
             " #      # \r\n"
             "##      ##\r\n"
             "#        #\r\n"
             "#  ####  #\r\n"
             "####  ####\r\n";

Point P = {2, 2};

void P_(int c) { gotoxy(1 + P.x, 1 + P.y); putch(c); }

void move(int x, int y) { if (Map[y * 12 + x] == ' ') { P.x = x; P.y = y; } }

void simple_rl(void)
{
        clrscr(); cputs(Map); P_('@');

        {int key; while ((key = getch()) != 'q') {

                P_(' ');

                switch (key) {
                case '8': move(P.x, P.y - 1); break;
                case '2': move(P.x, P.y + 1); break;
                case '4': move(P.x - 1, P.y); break;
                case '6': move(P.x + 1, P.y); break;
                }

                P_('@');
        }}
}

int main(void) { simple_rl(); return 0; } 