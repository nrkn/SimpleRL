#include <SDL/SDL.h>

class Map {
  public: enum { Height = 10, Width = 10 };
          const char *sectors;

};

class Player {
  public: int x; int y;
          void move(int x, int y);

};

class Screen {
  public: void on();
          void off();
          void update();
          void draw(int x, int y, char sym);
          void draw(const Map& map);
  private: SDL_Surface *surface;
           SDL_Surface *font;

};

class Keyboard {
  public: typedef enum { Esc = SDLK_ESCAPE, Up = SDLK_UP, Down = SDLK_DOWN,
                 Left = SDLK_LEFT, Right = SDLK_RIGHT } Key;
          void on();
          void off();
          Key getKey();

};

class Font {
  public: enum { Height = 16, Width = 8, Columns = 32, Rows = 8 };
          static const char * const Bitmap;
};

const char * const Font::Bitmap = "font.bmp";

class Map Map = { "####  ####"
                  "#  ####  #"
                  "#        #"
                  "##      ##"
                  " #      # "
                  " #      # "
                  "##      ##"
                  "#        #"
                  "#  ####  #"
                  "####  ####"};

class Player Player = {2, 2};

class Screen Screen;

class Keyboard Keyboard;

class Font Font;

void SimpleRL(void)
{
  Screen.draw(Map);
  Screen.draw(Player.x, Player.y, '@');

  for (;;) {
    switch (Keyboard.getKey()) {
    case Keyboard::Up:    Player.move(Player.x, Player.y - 1); break;
    case Keyboard::Down:  Player.move(Player.x, Player.y + 1); break;
    case Keyboard::Left:  Player.move(Player.x - 1, Player.y); break;
    case Keyboard::Right: Player.move(Player.x + 1, Player.y); break;
    case Keyboard::Esc:   goto QuitGame;
    }
  }

  QuitGame:;

}

int main(int argc, char *argv[]) {

  Screen.on();
  Keyboard.on();

  SimpleRL();

  Keyboard.off();
  Screen.off();

  return EXIT_SUCCESS;

}

void Player::move(int new_x, int new_y)
{
  if (Map.sectors[new_y * Map::Width + new_x] == ' ') {
    Screen.draw(x, y, ' ');
    x = new_x; y = new_y;
    Screen.draw(x, y, '@');
  }

}

void Screen::on()
{
  SDL_Init(SDL_INIT_VIDEO | SDL_INIT_TIMER);
  surface = SDL_SetVideoMode(80, 160, 32, SDL_SWSURFACE | SDL_HWPALETTE);
  font = SDL_LoadBMP(Font::Bitmap);

}

void Screen::off()
{
  SDL_FreeSurface(font);
  SDL_Quit();

}

void Screen::update()
{
  SDL_Flip(surface);

}

void Screen::draw(int x, int y, char sym)
{
  SDL_Rect src = {
    (sym % Font::Columns) * Font::Width,
    (sym / Font::Columns) * Font::Height,
    Font::Width, Font::Height
  };
  SDL_Rect dest = {x * Font::Width, y * Font::Height, 0, 0};

  SDL_BlitSurface(font, &src, surface, &dest);

}

void Screen::draw(const class Map& map)
{
  for (int y = 0; y < Map::Height; ++y) {
  for (int x = 0; x < Map::Width; ++x) {
    draw(x, y, map.sectors[y * Map::Width + x]);
  }
  }

}

void Keyboard::on()
{
  SDL_EnableKeyRepeat(SDL_DEFAULT_REPEAT_DELAY, SDL_DEFAULT_REPEAT_INTERVAL);

}

void Keyboard::off() {}

Keyboard::Key Keyboard::getKey()
{
  Screen.update();

  SDL_Event event;
  do { SDL_WaitEvent(&event); } while (event.type != SDL_KEYDOWN);

  return static_cast<Keyboard::Key>(event.key.keysym.sym);
} 