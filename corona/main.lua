small_dungeon = {
  '####..####',
  '#  ####  #',
  '#        #',
  '##      ##',
  '.#      #.',
  '.#      #.',
  '##      ##',
  '#        #',
  '#  ####  #',
  '####..####'
}

local function drawDungeon(  )

for key,value in next,small_dungeon,nil do

 	for i = 1, #value do
    local c = value:sub(i,i)
    local img
    if c == '#' then
    	img = display.newImage( "wall.png", true )
    elseif c == ' ' then
    	img = display.newImage( "floor.png", true )
    end
    if( img ~= nil ) then
  	  img.x = i*64 + 64
  	  img.y = key*64;
  	end
  end
end

end

-- we make an educated guess that someone touched an arrow bitmap ;)
local function touchArrow( event )

  local vx = event.target.vectorX;
  local vy = event.target.vectorY;

  if small_dungeon[ sage.Y + vy ]:sub( sage.X + vx , sage.X + vx ) == ' ' then

    sage.x = sage.x + vx * 64;
    sage.y = sage.y + vy * 64;

    sage.X = sage.X + vx
    sage.Y = sage.Y + vy;

  end

end

-- img.x and img.y will need some adaption for some phones
local function addArrow( degrees , vectorX , vectorY )

  local img = display.newImage( "left.gif", true );
  img:rotate( degrees );
  img.y = 640 + 32 * vectorY; -- magic number alert
  img.x = 32  + 32 * vectorX; -- magic number alert
  img.vectorX = vectorX; -- Custom field added
  img.vectorY = vectorY; -- Custom field added

  img:addEventListener( "touch" , touchArrow );
end

drawDungeon();

sage = display.newImage( "sage.png", true ) --Evil global

sage.X = 2; -- custom field
sage.Y = 2; -- custom field
sage.x = sage.X * 64 + 64;
sage.y = sage.Y * 64;

addArrow( 0   , -1 , 0  ); --rotation degree , x vector , y vector
addArrow( 90  , 0  , -1 ); --rotation degree , x vector , y vector
addArrow( 180 ,  1 , 0  ); --rotation degree , x vector , y vector
addArrow( 270 , 0  , 1  ); --rotation degree , x vector , y vector