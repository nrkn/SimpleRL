"This only works with GNU Smalltalk."

Object subclass: SimpleRL [
    | map px py |

    startCurses [
        NCWindow initscr; noecho; cbreak; cursSet: 0.
        NCWindow stdscr keypad: true.
    ]

    mapAtY: y x: x [
        "Get the character at (y, x), 0-based."
        ^(map at: y + 1) at: x + 1
    ]

    moveBy: delta [
        | x y |
        x := px + delta x.
        y := py + delta y.
        Character space = (self mapAtY: y x: x)
          ifTrue: [px := x. py := y ]
    ]

    mainLoop [
        | ch moves |
        map := #('####  ####'
                 '#  ####  #'
                 '#        #'
                 '##      ##'
                 ' #      # '
                 ' #      # '
                 '##      ##'
                 '#        #'
                 '#  ####  #'
                 '####  ####').
        "player coordinates"
        px := 1.  py := 1.

        "Draw the map and the player."
        1 to: map size do: [:i |
          NCWindow mvaddstr: i - 1 x: 0 str: (map at: i)].
        NCWindow mvaddch: py x: px ch: $@;
            refresh.

        "Create a dictionary mapping keypresses to dx@dy moves.
         The GNU Smalltalk NCurses bindings have bad values for
         keyUp/Down/etc, at least on my system, so I manually
         include the key codes that I actually observe, along
         with the rogue keys, because I actually prefer those."
        moves := Dictionary new.
        {{{$k asInteger. NCWindow keyUp.    259}.  0@-1}.
         {{$j asInteger. NCWindow keyDown.  258}.  0@ 1}.
         {{$h asInteger. NCWindow keyLeft.  260}. -1@ 0}.
         {{$l asInteger. NCWindow keyRight. 261}.  1@ 0}} do: [:keysPoint |
             (keysPoint at: 1) do: [:key |
                 moves at: key put: (keysPoint at: 2)]
        ].

        [ (ch := NCWindow stdscr wgetch) = $q asInteger] whileFalse: [
            NCWindow mvaddch: py x: px ch: (Character space).
            moves at: ch ifPresent: [:delta | self moveBy: delta].
            NCWindow mvaddch: py x: px ch: $@;
                refresh.
        ]
    ]

    SimpleRL class >> run [
        | s |
        s := SimpleRL new.
        s startCurses.
        ^[ s mainLoop ] ensure: [ NCWindow endwin ]
    ]
]

PackageLoader fileInPackage: 'NCurses'.
SimpleRL run.
