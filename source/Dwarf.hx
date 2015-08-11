package;

import flixel.text.FlxText;
import flixel.util.FlxRandom;


/**
 * ...
 * @author damrem
 */
class Dwarf extends Rect
{

	public function new(X:Float=0, Y:Float=0) 
	{
		super(FlxRandom.intRanged(10, 20), FlxRandom.intRanged(10, 20), 0xff000000 + FlxRandom.intRanged(0x000000,0xffffff));
		//offset.set( width/2, height);
		//alpha = 0.5;
	}
	
	#if debug
	override public function update() {
		if (!inWorldBounds()) {
			alpha = 0.1;
		}
		else
		{
			alpha = 1;
		}
		super.update();
	}
	#end 
}