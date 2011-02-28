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

def draw_tile( tile )
  Curses.setpos( $y, $x )
  Curses.addstr( tile )
end

def move_player( x, y )
  if( $map[ y ][ x, 1 ] == " " )
    $x, $y = x, y
  end
end

screen = Curses.init_screen
Curses.noecho
Curses.curs_set( 0 )
screen.keypad( true )

$map.each{ |row| Curses::addstr( row + "\n" ) }

draw_tile( '@' )

until ( c = screen.getch ) == ?q
  draw_tile( ' ' )
  
  keys = { KEY_UP => [$x, $y - 1],
           KEY_DOWN => [$x, $y + 1],
           KEY_LEFT => [$x - 1, $y],
           KEY_RIGHT => [$x + 1, $y] }
    
  move_player( *keys[c] ) if keys[c]
  
  draw_tile( '@' )
end