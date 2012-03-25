with Ada.Text_IO; use Ada.Text_IO;

procedure Simple_RL is
  type Map_Type is array (1 .. 10, 1 .. 10) of Character;
  Map_Pure : Map_Type := ( ('#', '#', '#', '#', ' ', ' ', '#', '#', '#', '#'),
                           ('#', '.', '.', '#', '#', '#', '#', '.', '.', '#'),
                           ('#', '.', '.', '.', '.', '.', '.', '.', '.', '#'),
                           ('#', '#', '.', '.', '.', '.', '.', '.', '#', '#'),
                           (' ', '#', '.', '.', '.', '.', '.', '.', '#', ' '),
                           (' ', '#', '.', '.', '.', '.', '.', '.', '#', ' '),
                           ('#', '#', '.', '.', '.', '.', '.', '.', '#', '#'),
                           ('#', '.', '.', '.', '.', '.', '.', '.', '.', '#'),
                           ('#', '.', '.', '#', '#', '#', '#', '.', '.', '#'),
                           ('#', '#', '#', '#', ' ', ' ', '#', '#', '#', '#') );

  Map      : Map_Type  := Map_Pure;
  Player   : Character := '@';
  Player_X : Integer   := 2;
  Player_Y : Integer   := 2;

 procedure Draw is
 begin
   Put (ASCII.ESC);
   Put ("[2J");
   for Y in Map'Range loop
     for X in Map'Range (2) loop
       Put (Map (Y, X));
     end loop;
     New_Line;
   end loop;
 end Draw;

 procedure Move is
   Dir  : Character;
   X    : Integer := Player_X;
   Y    : Integer := Player_Y;
 begin
   Get_Immediate (Standard_Input, Dir);
   case Dir is
     when 'j'    => Y := Player_Y + 1;
     when 'k'    => Y := Player_Y - 1;
     when 'h'    => X := Player_X - 1;
     when 'l'    => X := Player_X + 1;
     when others => null;
   end case;

   if Map (Y, X) = '#' then
     null;
   else
     Player_X := X;
     Player_Y := Y;
     Map := Map_Pure;
     Map (Player_Y, Player_X) := Player;
   end if;
 end Move;

begin
  Map (Player_Y, Player_X) := Player;
  loop
    Draw;
    Move;
  end loop;
end Simple_RL;