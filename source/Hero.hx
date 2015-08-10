package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author damrem
 */
class Hero extends FlxSpriteGroup
{

	public static inline var ACCELERATION:UInt = 200;
	
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		//drag.x = 500;
		
		var body = new FlxSprite();
		body.makeGraphic(50, 100, FlxColor.WHITE, true, "hero");
		add(body);
	}
	
}