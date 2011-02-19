DECLARE SUB DrawTile (Tile$, X%, Y%)
CLS

Map$(1) = "####  ####"
Map$(2) = "#  ####  #"
Map$(3) = "#        #"
Map$(4) = "##      ##"
Map$(5) = " #      # "
Map$(6) = " #      # "
Map$(7) = "##      ##"
Map$(8) = "#        #"
Map$(9) = "#  ####  #"
Map$(10) = "####  ####"

X% = 3
Y% = 3

FOR Row% = 1 TO 10
  PRINT Map$(Row%)
NEXT

CALL DrawTile("@", X%, Y%)

Key$ = INKEY$
WHILE UCASE$(Key$) <> "Q"
  U% = X%
  V% = Y%

  CALL DrawTile(" ", X%, Y%)

  SELECT CASE Key$
    CASE CHR$(0) + CHR$(72)
      V% = V% - 1
    CASE CHR$(0) + CHR$(80)
      V% = V% + 1
    CASE CHR$(0) + CHR$(75)
      U% = U% - 1
    CASE CHR$(0) + CHR$(77)
      U% = U% + 1
  END SELECT

  IF MID$(Map$(V%), U%, 1) = " " THEN
    X% = U%
    Y% = V%
  END IF

  CALL DrawTile("@", X%, Y%)

  DO
    Key$ = INKEY$
  LOOP WHILE Key$ = ""
WEND

SUB DrawTile (Tile$, X%, Y%)
LOCATE Y%, X%
PRINT Tile$;
END SUB