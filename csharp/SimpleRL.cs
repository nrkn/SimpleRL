using System;
using System.Collections.Generic;

namespace BasicEngine {
  class Program {
    static readonly List<string> Map = new List<string>{
      "####  ####", 
      "#  ####  #", 
      "#        #", 
      "##      ##", 
      " #      # ", 
      " #      # ", 
      "##      ##", 
      "#        #", 
      "#  ####  #", 
      "####  ####" 
    };

    static int _playerX = 2, _playerY = 2;
  
    static void Main() {
      //clear the console
      Console.Clear();

      //send each row of the map to the Console
      Map.ForEach( Console.WriteLine );


      ConsoleKey key;
      DrawTile( '@' );

      //keep processing key presses until the player wants to quit
      while( ( key = Console.ReadKey( true ).Key ) != ConsoleKey.Q ) {
        //clear the square they were standing on before
        DrawTile( ' ' );

        //change the player's location if they pressed an arrow key
        switch( key ) {
          case ConsoleKey.UpArrow:
            MovePlayer( _playerX, _playerY - 1 );
            break;
          case ConsoleKey.DownArrow:
            MovePlayer( _playerX, _playerY + 1 );
            break;
          case ConsoleKey.LeftArrow:
            MovePlayer( _playerX - 1, _playerY );
            break;
          case ConsoleKey.RightArrow:
            MovePlayer( _playerX + 1, _playerY );
            break;
        }

        //now draw the player at the new square
        DrawTile( '@' );
      }  
    }

    static void MovePlayer( int newX, int newY ) {
      //don't move if the new square isn't empty
      if( Map[ newY ][ newX ] != ' ' ) return;

      //set the new position
      _playerX = newX;
      _playerY = newY;
    }

    static void DrawTile( char tile ) {
      //draw the given tile at the current player location
      Console.SetCursorPosition( _playerX, _playerY );
      Console.Write( tile );
    }
  }
}