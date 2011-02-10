viewport = document.getElementById "viewport"

map = (row.split '' for row in '''
   ####  ####
   #  ####  #
   #        #
   ##      ##
    #      # 
    #      # 
   ##      ##
   #        #
   #  ####  #
   ####  ####
'''.split '\n')

x = y = 2

[LEFT, DOWN, RIGHT, UP] = [37..40]

handleKeyup = ( e ) ->
  switch e.keyCode
    when LEFT  then movePlayer x - 1, y
    when RIGHT then movePlayer x + 1, y
    when UP    then movePlayer x, y + 1
    when DOWN  then movePlayer x, y - 1

movePlayer = ( newX, newY ) ->
  if map[ newY ][ newX ] == ' '
    map[ y ][ x ] = ' '
    [x, y] = [newX, newY]
    map[ y ][ x ] = '@'
    viewport.innerHTML = (row.join '' for row in map).join '\n'

document.addEventListener 'keyup', handleKeyup, false

# Fake a keypress to render the map immediately
handleKeyup keyCode:RIGHT
