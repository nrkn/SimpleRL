"Smalltalk test"

Object subclass: SimpleRL [
    | map px py |

    startCurses [
        NCWindow initscr; noecho; cbreak; cursSet: 0.
        NCWindow stdscr keypad: true.
    ]

    mapAtY: y x: x [
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
        1 to: map size do: [:i |
          NCWindow mvaddstr: i - 1 x: 0 str: (map at: i)].
        px := 1.  py := 1.
        NCWindow mvaddch: py x: px ch: $@;
            refresh.

        moves := Dictionary new.
        {{{$k asInteger. NCWindow keyUp. 259}. 0@-1}.
         {{$j asInteger. NCWindow keyDown. 258}. 0@1}.
         {{$h asInteger. NCWindow keyLeft. 260}. -1@0}.
         {{$l asInteger. NCWindow keyRight. 261}. 1@0}} do: [:list |
            (list at: 1) do: [:key | moves at: key put: (list at: 0)]
        ].

        [ (ch := NCWindow stdscr wgetch) = $q asInteger] whileFalse: [
            NCWindow mvaddch: py x: px ch: (Character space).
            ({$k asInteger. NCWindow keyUp. 259} includes: ch)
                ifTrue: [self moveBy: 0@-1]
                ifFalse: [({$j asInteger. NCWindow keyDown. 258} includes: ch)
                  ifTrue: [self moveBy: 0@1]
                  ifFalse: [({$h asInteger. NCWindow keyLeft. 260} includes: ch)
                    ifTrue: [self moveBy: -1@0]
                    ifFalse: [({$l asInteger. NCWindow keyRight. 261} includes: ch)
                      ifTrue: [self moveBy: 1@0] ]]].
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
