#include <stdbool.h>
#include "SMSlib/src/SMSlib.h"
#include "gfx.h"

#define PF_OFFSET_X 10
#define PF_OFFSET_Y 6

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

void draw_map(unsigned char x, unsigned char y, char *map) {
  char *o, count;
  unsigned int buffer[12], *d;

  o = map; d = buffer; count = 0;
  while (*o) {
    if (*o == '\n') {
      SMS_loadTileMap(x, y, buffer, count << 1);
      d = buffer; count = 0;
      y++;
    } else {
      *d = *o - 32;
      d++; count++;
    }
    o++;
  }
}

void draw_char(unsigned char x, unsigned char y, char c) {
  SMS_setTileatXY(x + PF_OFFSET_X, y + PF_OFFSET_Y, c - 32);
}

int px = 1, py = 1;
void move_to(int x, int y) { if (map[y * 11 + x] == ' ') { px = x; py = y; } }

void simple_rl(void)
{
  unsigned short kp;

  draw_map(PF_OFFSET_X, PF_OFFSET_Y, map);
  draw_char(px, py, '@');
  SMS_displayOn();

  while (true) {
    kp = SMS_getKeysPressed();

    SMS_waitForVBlank();

    draw_char(px, py, ' ');

    if (kp & PORT_A_KEY_UP) { move_to(px, py - 1); }
    if (kp & PORT_A_KEY_DOWN) { move_to(px, py + 1); }
    if (kp & PORT_A_KEY_LEFT) { move_to(px - 1, py); }
    if (kp & PORT_A_KEY_RIGHT) { move_to(px + 1, py); }

    draw_char(px, py, '@');
  }
}

void load_font (void) {
	unsigned char i, j;
	unsigned char buffer[32], *o, *d;

	o = font_fnt;
	for (i = 0; i != 96; i++) {
		d = buffer;
		for (j = 0; j != 8; j++) {
			*d = *o; d++;	o++;
			*d = 0;	d++;
			*d = 0;	d++;
			*d = 0;	d++;
		}
		SMS_loadTiles(buffer, i, 32);
	}
}

void main(void) {
  unsigned char i;

  load_font();

  for (i=0;i<16;i++)
    SMS_setBGPaletteColor(i,0x00);    // black
  SMS_setBGPaletteColor(01,0x3f);     // white

  simple_rl();
}

SMS_EMBED_SEGA_ROM_HEADER(9999,0); // code 9999 hopefully free, here this means 'homebrew'
SMS_EMBED_SDSC_HEADER(0,1, 2015,8,27, "Haroldo-OK\\2015", "SimpleRL for SSM",
  "This is a port of SimpleRL to Sega Master System - https://github.com/haroldo-ok/SimpleRL.\n"
  "Built using devkitSMS & SMSlib - https://github.com/sverx/devkitSMS");
