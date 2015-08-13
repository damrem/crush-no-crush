package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class Ground extends FlxSpriteGroup
{
	static public inline var HEIGHT:Float = 100;

	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		var g0 = new FlxSprite(0, 0);
		g0.makeGraphic(40000, HEIGHT);
		
		g0.immovable = true;
		
		add(g0);
		
	}
	
}