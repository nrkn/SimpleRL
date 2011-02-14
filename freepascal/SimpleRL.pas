program SimpleRL;

uses Crt;

type
  TPoint = record
             X, Y : Integer;
           end;

const
  Map : Array [1..10] of String[10] = ( '####  ####',
                                        '#  ####  #',
                                        '#        #',
                                        '##      ##',
                                        ' #      # ',
                                        ' #      # ',
                                        '##      ##',
                                        '#        #',
                                        '#  ####  #',
                                        '####  ####');

var
  P : TPoint = ( X: 2; Y: 2);
  Key : Char;

procedure DrawTile(C: Char);  
begin
  GotoXY(P.X, P.Y);
  Write(c);
end;

procedure MovePlayer(X, Y: Integer);
begin
  if Map[Y][X] = ' ' then
  begin
    P.X := X;
    P.Y := Y;
  end;
end;

procedure DrawMap;
var
  I : Integer;
begin
  for I := Low(Map) to High(Map) do
    WriteLn(Map[I]);
end;

begin
  ClrScr;

  DrawMap;

  DrawTile('@');

  repeat
    Key := ReadKey;

    DrawTile(' ');

    case Key of
      '8' : MovePlayer(P.X, P.Y - 1);
      '2' : MovePlayer(P.X, P.Y + 1);
      '4' : MovePlayer(P.X - 1, P.Y);
      '6' : MovePlayer(P.X + 1, P.Y);      
    end;

    DrawTile('@');
  until Key = 'q';
end.