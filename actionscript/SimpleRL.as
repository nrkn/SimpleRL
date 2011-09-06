package
{
import flash.events.KeyboardEvent;
import flash.text.TextField;
import flash.display.Sprite;
import flash.text.TextFormat;

public class SimpleRL extends Sprite
{
	private var _map:Array = [
	    '####  ####', 
	    '#  ####  #', 
	    '#        #', 
	    '##      ##', 
	    ' #      # ', 
	    ' #      # ', 
	    '##      ##', 
	    '#        #', 
	    '#  ####  #', 
	    '####  ####'   
	  ];
	
	private var _x:int = 2;
	private var _y:int = 2;
	private var _txt:TextField = new TextField();
	
	public function SimpleRL()
	{
		_txt.width = 550;
		_txt.height = 400;
		_txt.defaultTextFormat = new TextFormat('_typewriter');
		addChild(_txt);
		
		stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP,false,false,37,37));
	}
	
	private function onKeyUp(event:KeyboardEvent):void
	{
		setTile(' ');
		switch(event.keyCode) {
	      case 37: movePlayer(_x - 1, _y); break;
	      case 38: movePlayer(_x, _y - 1); break;
	      case 39: movePlayer(_x + 1, _y); break;
	      case 40: movePlayer(_x, _y + 1); break;
	    }
		setTile( '@' );
		_txt.text = _map.join('\r');
	}
	
	private function setTile(tile:String):void
	{
		_map[_y] = _map[_y].substr(0, _x) + tile + _map[_y].substr(_x + 1);
	}
	
	private function movePlayer(newX:int, newY:int):void 
	{
	    if(_map[ newY ].charAt(newX) != ' ') return;
	    _x = newX;
	    _y = newY;   
	}
}

}