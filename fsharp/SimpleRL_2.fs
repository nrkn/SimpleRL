module SimpleRL
open System
let Map = 
     [| "####  ####";
        "#  ####  #";
        "#        #";
        "##      ##";
        " #      # ";
        " #      # ";
        "##      ##";
        "#        #";
        "#  ####  #";
        "####  ####"
    |]

let mutable x,y = 2,2
let DrawTile (tile:char) =
      //draw the given tile at the current player location
      Console.SetCursorPosition(x,y )
      Console.Write( tile )
let MovePlayer newX newY =
      //don't move if the new square isn't empty
    if( Map.[ newY ].[ newX ] = ' ' ) then
      //set the new position
        x <- newX;
        y <- newY;
let rec Main() = 
    Console.Clear();
    Map |> Array.iter (Console.WriteLine)
    DrawTile('@')
    let key = Console.ReadKey(true).Key
        //clear the square they were standing on before
    DrawTile(' ')
        //change the player's location if they pressed an arrow key
    match key with 
    |ConsoleKey.UpArrow ->    MovePlayer x  (y- 1 )
    |ConsoleKey.DownArrow ->  MovePlayer x  (y+ 1 )
    |ConsoleKey.LeftArrow ->  MovePlayer (x - 1) y
    |ConsoleKey.RightArrow -> MovePlayer (x + 1) y
    | _-> () //do nothing if key is not matched
    //now draw the player at the new square
    DrawTile( '@' );
    if key <> ConsoleKey.Q then Main() //recurse
    
Main()