const viewport = document.getElementById( 'viewport' )

const map = [
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

var player = {
  x: 2,
  y: 2
}

const setTile = tile =>
  map[ player.y ] = 
    map[ player.y ].substr( 0, player.x ) + 
    tile + 
    map[ player.y ].substr( player.x + 1 )
  
const movePlayer = point => {
  if( map[ point.y ][ point.x ] === ' ' )
    player = point
}

const modifiers = {
  37: { x: -1, y: 0 },
  38: { x: 0, y: -1 },
  39: { x: 1, y: 0 },
  40: { x: 0, y: 1 }
}

const tick = e => {
  setTile( ' ' )
  
  if( e.keyCode in modifiers ){
    const modifier = modifiers[ e.keyCode ]
    
    movePlayer({
      x: player.x + modifier.x,
      y: player.y + modifier.y
    })
  }
  
  setTile( '@' )
  
  viewport.textContent = map.join( '\n' )
} 

document.addEventListener( 'keyup', tick, false )
tick( { keyCode: null } )