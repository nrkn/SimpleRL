var viewport = document.getElementById( 'viewport' );

var map = [
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
];

var x, y;
x = y = 2;

var tick = function( e ) {    
  setTile( ' ' );

  switch( e.keyCode ) {
    case 37:
      movePlayer( x - 1, y );
      break;
    case 38:
      movePlayer( x, y - 1 );
      break;
    case 39:
      movePlayer( x + 1, y );
      break;
    case 40:
      movePlayer( x, y + 1 );
      break;
  }

  setTile( '@' );

  viewport.innerHTML = map.join( '<br />' );
}

var setTile = function( tile ) {
  map[ y ] = map[ y ].substr( 0, x ) + tile + map[ y ].substr( x + 1 );
}

var movePlayer = function( newX, newY ) {
  if( map[ newY ][ newX ] != ' ' ) return;
  
  x = newX;
  y = newY;   
}

document.addEventListener( 'keyup', tick, 0 ); 

tick( { keyCode: null } );