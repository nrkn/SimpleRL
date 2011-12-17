#include <string.h>
#include <i86.h>

#define WIDTH 80

typedef struct {
	int x;
	int y;
} POINT;

void clear() {
	union REGS clear;
	union REGS hide;

	// clear screen
	clear.w.cx = 0;
	clear.w.dx = 0x1850;
	clear.h.bh = 7;
	clear.w.ax = 0x0600;
	int86(0x10, &clear, &clear);

	// hide cursor
	hide.h.ah = 0x01;
	hide.w.cx = 0x2607;
	int86(0x10, &hide, &hide);
}

void draw_char(char ch, int x, int y, char color) {
	int i;

	i = 2 * (y * WIDTH + x);
	((char far *) 0xb8000000)[i] = ch;
	((char far *) 0xb8000000)[i+1] = color;
}
void draw_line(char * line, int x, int y, int w, char color) {
	int ci;
	for (ci = 0; ci < w; ci++)
		draw_char(line[ci], x + ci, y, color);
}
void draw_map(char * map, int x, int y, int w, char color) {
	int h = strlen(map) / w;
	int line;

	for (line = 0; line < h; line++)
		draw_line(map + line * w, 0, line, w, 1);
}

void get_key(unsigned char * scancode, unsigned char * ascii) {
	union REGS getkey;
	getkey.h.ah = 0;
	int86(0x16, &getkey, &getkey);

	*scancode = getkey.h.ah;
	*ascii = getkey.h.al;
}

void move(char * map, POINT * p, int x, int y, int w) {
	if (map[y * w + x] == ' ') {
		p->x = x;
		p->y = y;
	}
}

void main() {
	char * map =
		"####  ####"
		"#  ####  #"
		"#        #"
		"##      ##"
		" #      # "
		" #      # "
		"##      ##"
		"#        #"
		"#  ####  #"
		"####  ####";
	int map_w = 10;

	POINT player = { 2, 2 };
	unsigned char scancode = 0;
	unsigned char ascii = 0;

	clear();
	draw_map(map, 0, 0, map_w, 5);

	do {
		draw_char(' ', player.x, player.y, 15);
		switch (scancode) {
		case 72:
			move(map, &player, player.x, player.y - 1,map_w);
			break;
		case 80:
			move(map, &player, player.x, player.y + 1,map_w);
			break;
		case 75:
			move(map, &player, player.x - 1, player.y,map_w);
			break;
		case 77:
			move(map, &player, player.x + 1, player.y,map_w);
			break;
		}
		draw_char('@', player.x, player.y, 15);

		get_key(&scancode, &ascii);
	}while (scancode != 1);
}