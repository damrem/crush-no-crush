package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class Dwarf extends FlxSpriteGroup
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y);
		
		var rect = new Rect(FlxRandom.intRanged(1000, 2000), FlxRandom.intRanged(1000, 2000), FlxColor.YELLOW);
		//rect.x = -rect.width / 2;
		//rect.y = -rect.height;
		
		add(rect);
	}
	
}