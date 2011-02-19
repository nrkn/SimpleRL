<!doctype html>
<title>SimpleRL</title>
<meta charset="utf-8" />
<pre>
<?php
  $map = array(
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
  );
  
  $startX = 2;
  $startY = 2;
  
  $playerX = isset( $_GET[ 'x' ] ) ? $_GET[ "x" ] : $startX;
  $playerY = isset( $_GET[ 'y' ] ) ? $_GET[ "y" ] : $startY;
  
  if( !canMove( $map, $playerX, $playerY ) ) {
    $playerX = $startX;
    $playerY = $startY;
  }
  
  
  for( $y = 0; $y < count( $map ); $y++ ) {
    for( $x = 0; $x < strlen( $map[ $y ] ); $x++ ) {
      $up = $playerY - 1;
      $down = $playerY + 1;
      $left = $playerX - 1;
      $right = $playerX + 1;
      
      $tile = $map[ $y ][ $x ];
      
      if( $x == $playerX && $y == $up && canMove( $map, $x, $up ) ) {
        $tile = getLink( $x, $y, "&uarr;" );
      } else if( $x == $playerX && $y == $down && canMove( $map, $x, $down ) ) {
        $tile = getLink( $x, $y, "&darr;" );      
      } else if( $x == $left && $y == $playerY && canMove( $map, $left, $y ) ) {
        $tile = getLink( $x, $y, "&larr;" );            
      } else if( $x == $right && $y == $playerY && canMove( $map, $right, $y ) ) {
        $tile = getLink( $x, $y, "&rarr;" );                  
      } else if( $x == $playerX && $y == $playerY ) {
        $tile = '@';
      }
      
      echo $tile;
    }
    echo "\n";    
  }
  
  function canMove( $map, $x, $y ) {
    if( !array_key_exists( $y, $map ) ) return false;
    $row = $map[ $y ];
    if( $x < 0 || $x >= strlen( $row ) ) return false;
    return $row[ $x ] == ' ';
  }
  
  function getLink( $x, $y, $tile ) {
    return "<a href=\"?x=$x&y=$y\">$tile</a>";
  }
?>
</pre>