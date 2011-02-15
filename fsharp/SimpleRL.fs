open System

// use a third party vector class for 2D and 3D positions
// or write your own for pratice
type Pos = {x: int; y: int} 
    with
    static member (+) (a, b) =
        {x = a.x + b.x; y = a.y + b.y}

let drawBoard map =
    //clear the console
    Console.Clear()
    //send each row of the map to the Console
    map |> List.iter (printfn "%s")

let movePlayer (keyInfo : ConsoleKeyInfo) =
    match keyInfo.Key with
    | ConsoleKey.UpArrow -> {x = 0; y = -1}
    | ConsoleKey.DownArrow -> {x = 0; y = 1}
    | ConsoleKey.LeftArrow -> {x = -1; y = 0}
    | ConsoleKey.RightArrow  -> {x = 1; y = 0}
    | _ -> {x = 0; y = 0}

let validPosition (map:string list) position =
    map.Item(position.y).Chars(position.x) = ' '

//clear the square player was standing on
let clearPlayer position =
    Console.SetCursorPosition(position.x, position.y)
    Console.Write( ' ' )

//draw the square player is standing on
let drawPlayer position =
    Console.SetCursorPosition(position.x, position.y)
    Console.Write( '@' )

let takeTurn map playerPosition =
    let keyInfo = Console.ReadKey true
    // check to see if player wants to keep playing
    let keepPlaying = keyInfo.Key <> ConsoleKey.Q
    // get player movement from user input
    let movement = movePlayer keyInfo
    // calculate the players new position
    let newPosition = playerPosition + movement
    // check for valid move
    let validMove = newPosition |> validPosition map
    // update drawing if move was valid
    if validMove then
        clearPlayer playerPosition
        drawPlayer newPosition
    // return state
    if validMove then
        keepPlaying, newPosition
    else
        keepPlaying, playerPosition

// main game loop
let rec gameRun map playerPosition =
    let keepPlaying, newPosition = playerPosition |> takeTurn map
    if keepPlaying then
        gameRun map newPosition

// setup game
let startGame map playerPosition =
    drawBoard map
    drawPlayer playerPosition
    gameRun map playerPosition


//define the map
let map = [ "####  ####"; 
            "#  ####  #"; 
            "#        #"; 
            "##      ##"; 
            " #      # "; 
            " #      # "; 
            "##      ##"; 
            "#        #"; 
            "#  ####  #"; 
            "####  ####" ]

//initial player position on the map
let playerPosition = {x = 2; y = 2}

startGame map playerPosition