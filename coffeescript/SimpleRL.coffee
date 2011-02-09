viewport = document.getElementById( "viewport" )

map = [ 
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

x = y = 2

tick = ( e ) ->
  setTile ' '
  
  switch e.keyCode
    when 37 then movePlayer x - 1, y
    when 38 then movePlayer x, y - 1
    when 39 then movePlayer x + 1, y
    when 40 then movePlayer x, y + 1

  setTile '@'
  viewport.innerHTML = map.join '<br />'

setTile = ( tile ) ->
  map[ y ] = map[ y ].substr( 0, x ) + tile + map[ y ].substr( x + 1 )
  
movePlayer = ( newX, newY ) ->
  if map[ newY ][ newX ] == ' ' 
    x = newX
    y = newY

document.addEventListener 'keyup', tick, 0

tick keyCode: null