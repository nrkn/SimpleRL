#!/usr/bin/perl -w
# Copyright (C) 2011 David Damerell
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

use Curses;
if (initscr()) {
  if (($COLS<20) || ($LINES <20)) {
    die "Please use at least a 20x20 display";
  }
} else {

  die "Curses support not available?";
}

curs_set(0);cbreak;noecho;

@maplines=("####  ####",
           "#  ####  #",
           "#        #",
           "##      ##",
           "#        #",
           "#        #",
           "##      ##",
           "#        #",
           "#  ####  #",
           "####  ####");

$xmax=0;
foreach $line (0..$#maplines) {
  @{$map[$line]}=split //,$maplines[$line];
  $xmax=length($maplines[$line]) if length($maplines[$line]) > $xmax;
}

$ymax=$#maplines; $xmax--;

$player{'x'}=$player{'y'}=2;
%directions=('h',[ -1,0 ],'j',[ 0,1 ],'k',[ 0,-1 ],'l',[ 1,0 ],
             'y',[ -1,-1 ],'u',[ 1,-1 ],'b',[ -1,1 ],'n',[ 1,1 ]);

&redraw_map;

while ($c = getch) {
  if (defined($directions{$c})) {
    $oldx=$player{'x'}; $oldy=$player{'y'};
    $newx=$player{'x'}+$directions{$c}[0];
    $newy=$player{'y'}+$directions{$c}[1];
    if ($map[$newy][$newx] eq ' ') {
      $oldx=$player{'x'}; $oldy=$player{'y'};
      $player{'x'}=$newx; $player{'y'}=$newy;
      &redraw ($oldx, $oldy); &redraw ($newx,$newy); refresh;
    } else {
      # you bumped into a wall
    }
  } elsif ($c eq 'r') {
    &redraw_map;
  } elsif ($c eq 'q') {
    endwin; exit;
  } else {
    # complain, unknown keypress
  }

}

sub redraw_map {
  foreach $x (0..$xmax) {
    foreach $y (0..$ymax) {
      &redraw ($x,$y);
    }
  }
  refresh;

}

sub redraw {
  my $x=shift; my $y=shift;
  if ($x == $player{'x'} and $y ==$player{'y'}) {
    attrset (A_BOLD | A_REVERSE);
    addch ($y, $x, '@');
    attrset (A_NORMAL);
  } else {
    addch ($y, $x, $map[$y][$x]);
  }
} 