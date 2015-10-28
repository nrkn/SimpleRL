const viewport = document.getElementById( 'viewport' )

const map = `
####  ####
#  ####  #
#        #
##      ##
 #      # 
 #      # 
##      ##
#        #
#  ####  #
####  ####`

var player = {
  x: 2,
  y: 2
}

const dungeon = map.trim()
  .split( '\n' )
  .map( row => 
    row.split( '' ) 
  )

const setTile = tile =>
  dungeon[ player.y ][ player.x ] = tile
  
const movePlayer = point => 
  dungeon[ point.y ][ point.x ] === ' ' ? point : player

const modifiers = {
  37: { x: -1, y: 0 },
  38: { x: 0, y: -1 },
  39: { x: 1, y: 0 },
  40: { x: 0, y: 1 }
}

const tick = e => {
  setTile( ' ' )
  
  if( e && e.keyCode in modifiers ){
    const modifier = modifiers[ e.keyCode ]
    
    player = movePlayer({
      x: player.x + modifier.x,
      y: player.y + modifier.y
    })
  }
  
  setTile( '@' )
  
  viewport.textContent = dungeon.map( row => 
    row.join( '' ) 
  ).join( '\n' )
} 

document.addEventListener( 'keyup', tick, false )
tick()