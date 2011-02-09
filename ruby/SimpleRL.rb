require 'curses'
include Curses

$map = [ 
  '####  ####', 
  '#  ####  #', 
  '#        #', 
  '##      ##', 
  ' #      # ', 
  ' #      # ', 
  '##      ##', 
  '#        #', 
  '#  ####  #', 
  '####  ####' 
]

$x = $y = 2

def drawTile( tile )
  Curses.setpos( $y, $x )
  Curses::addstr( tile )
end

def movePlayer( newX, newY )
  if( $map[ newY ][ newX, 1 ] == ' ' ) then
    $x = newX
    $y = newY
  end
end

screen = Curses.init_screen
Curses.noecho
Curses.curs_set( 0 )
screen.keypad( true )

$map.each{ |row| Curses::addstr( row + "\n" ) }

drawTile( '@' )

c = nil

begin
  drawTile( ' ' )
  
  case c
    when KEY_UP
      movePlayer( $x, $y - 1 )
    when KEY_DOWN
      movePlayer( $x, $y + 1 )
    when KEY_LEFT
      movePlayer( $x - 1, $y )
    when KEY_RIGHT
      movePlayer( $x + 1, $y )
  end
  
  drawTile( '@' )
end until ( c = screen.getch ) == ?q