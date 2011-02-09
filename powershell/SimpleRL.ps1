function DrawTile {
  param( $tile )
  
  $cursorPos = $Host.UI.RawUI.CursorPosition
  $cursorPos.x = $position.x
  $cursorPos.y = $position.y
  $Host.UI.RawUI.CursorPosition = $cursorPos
  
  $tile
}

function MovePlayer {
  param( $position )

  return $map[ $position.y ][ $position.x ] -eq ' '
}

$map = "####  ####", "#  ####  #", "#        #", "##      ##", " #      # ", " #      # ", "##      ##", "#        #", "#  ####  #", "####  ####"
$position = @{}
$position.x = $position.y = 2

Clear-Host

$map

DrawTile "@"

while( ( $key = $Host.UI.RawUI.ReadKey( "NoEcho,IncludeKeyDown" ) ).Character -ne "q" ) {
  DrawTile " "
  
  $newPosition = @{} + $position
  switch( $key.VirtualKeyCode ) {
    38 {
      $newPosition.y--
    }
    40 {
      $newPosition.y++
    }
    37 {
      $newPosition.x--
    }
    39 {
      $newPosition.x++
    }
  }
  
  if( MovePlayer $newPosition ) {
    $position = $newPosition
  }
  
  DrawTile "@"
}

Clear-Host