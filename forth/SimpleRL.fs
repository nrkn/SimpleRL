10 constant width
10 constant height
create map
    '# , '# , '# , '# , '. , '. , '# , '# , '# , '# ,
    '# , '. , '. , '# , '# , '# , '# , '. , '. , '# ,
    '# , '. , '. , '. , '. , '. , '. , '. , '. , '# ,
    '# , '# , '. , '. , '. , '. , '. , '. , '# , '# ,
    '. , '# , '. , '. , '. , '. , '. , '. , '# , '. ,
    '. , '# , '. , '. , '. , '. , '. , '. , '# , '. ,
    '# , '# , '. , '. , '. , '. , '. , '. , '# , '# ,
    '# , '. , '. , '. , '. , '. , '. , '. , '. , '# ,
    '# , '. , '. , '# , '# , '# , '# , '. , '. , '# ,
    '# , '# , '# , '# , '. , '. , '# , '# , '# , '# ,

1 value playerx
1 value playery

: .player ( -- ) playerx playery at-xy   '@ emit ;
: .tile ( i -- ) dup width /mod at-xy   cells map +   @ emit ;
: .map ( -- ) width height * 0 do i .tile loop ;

: can-walk? ( x y -- f ) width * + cells map + @ '. = ;
: walk ( x y -- ) 2dup can-walk? if to playery to playerx else 2drop
then ;
: process ( ekey -- )
    ekey>fkey drop case
    k-up    of playerx playery 1- walk endof
    k-down  of playerx playery 1+ walk endof
    k-left  of playerx 1- playery walk endof
    k-right of playerx 1+ playery walk endof
    endcase ;
: draw ( -- ) .map   .player   form swap at-xy ;
: quit? ( ekey -- ? ) ekey>char if 'q = else drop false then ;
: game ( ) begin ekey dup quit? invert while process draw repeat
drop ;

page   draw   game   page   bye 