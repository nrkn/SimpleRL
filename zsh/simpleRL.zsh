#!/bin/zsh

zmodload zsh/curses
zcurses init

y=2
x=2
newy=2
newx=2
map="####  #####  ####  ##        ###      ## #      #  #      # ##      ###
  ##  ####  #####  ####"

zcurses addwin mapw 10 10 0 0
zcurses string mapw $map

drawplayer()
{
 zcurses move mapw $y $x
 zcurses char mapw "@"
 zcurses move mapw $y $x
 zcurses refresh
}

walkable()
{
 zcurses move mapw $newy $newx
 zcurses querychar mapw reply
 if [[ $reply[1] == " " ]]; then
   zcurses move mapw $y $x
   zcurses char mapw " "
   y=$newy
   x=$newx
   drawplayer
   else
     newy=$y
     newx=$x
     zcurses move mapw $y $x
 fi
}

drawplayer

while [[ -z $REPLY ]];do
   zcurses input mapw REPLY key
   case $key in
     (UP)
     newy=$((y-1))
     ;;
     (DOWN)
     newy=$((y+1))
     ;;
     (RIGHT)
     newx=$((x+1))
     ;;
     (LEFT)
     newx=$((x-1))
     ;;
     ("")
     if [[ $REPLY == "q" ]]; then
       delwin mapw
       zcurses end
       exit
     fi
     ;;
   esac
 walkable
 REPLY=
 key=
done