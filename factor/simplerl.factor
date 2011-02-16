! Factor SimpleRL by Risto Saarelma

USING: accessors arrays fonts kernel math.vectors memoize opengl sequences
strings ui ui.gadgets ui.gestures ui.render ui.text ;

IN: simplerl

: font ( -- font ) monospace-font ;

MEMO: font-dim ( -- dim )
    font "@" [ text-width ] [ text-height ] 2bi 2array ;

: draw ( loc str -- )
    [ font-dim v* ] dip
    [ font swap draw-text ] curry with-translation ;

: putc ( loc char -- ) 1string draw ;

CONSTANT: terrain-data
{ "####  ####"
  "#  ####  #"
  "#        #"
  "##      ##"
  " #      # "
  " #      # "
  "##      ##"
  "#        #"
  "#  ####  #"
  "####  ####" }

: terrain ( loc -- t )
    first2 terrain-data nth nth ;

: terrain-dim ( -- dim )
    terrain-data [ first length ] [ length ] bi 2array ;

: blocks? ( terrain -- ? ) CHAR: # = ;

TUPLE: simplerl < gadget @-pos ;

: <simplerl> ( -- simplerl ) simplerl new { 2 2 } >>@-pos ;

M: simplerl pref-dim* ( gadget -- dim ) drop { 80 25 } font-dim v* ;

: move ( gadget dir -- )
    [ dup @-pos>> ] dip v+
    dup terrain blocks? [ drop ] [ >>@-pos ] if
    relayout-1 ;

: draw-terrain ( -- )
    terrain-dim first2 [ iota ] bi@
    [ 2array dup terrain putc ] cartesian-each ;

simplerl H{
    { T{ key-down f f "UP" } [ { 0 -1 } move ] }
    { T{ key-down f f "DOWN" } [ { 0 1 } move ] }
    { T{ key-down f f "LEFT" } [ { -1 0 } move ] }
    { T{ key-down f f "RIGHT" } [ { 1 0 } move ] }
    { T{ key-down f f "q" } [ close-window ] }
} set-gestures

M: simplerl draw-gadget* ( gadget -- )
    draw-terrain
    @-pos>> CHAR: @ putc ;

: simplerl-window ( -- )
    [ <simplerl> "SimpleRL" open-window ] with-ui ;

MAIN: simplerl-window