package;

import flixel.FlxGame;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class Ground extends FlxSpriteGroup
{

	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		var g0 = new FlxSprite(0, 200);
		g0.makeGraphic(4000, 20);
		
		g0.immovable = true;
		
		add(g0);
		
	}
	
}