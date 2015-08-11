package ;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author damrem
 */
class Rect extends FlxSprite
{

	public function new(Width:Int=0, Height:Int=0, Color:Int=FlxColor.WHITE) 
	{
		super();
		makeGraphic(Width, Height, Color);
	}
	
}