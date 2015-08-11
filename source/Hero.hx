package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author damrem
 */
class Hero extends FlxSpriteGroup
{
	public var body:flixel.FlxSprite;
	var legA:flixel.FlxSprite;
	var legB:flixel.FlxSprite;

	public static inline var ACCELERATION:UInt = 200;
	
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		
		//drag.x = 500;
		
		body = new FlxSprite( -25, -175);
		//body.immovable = true;
		body.makeGraphic(50, 100, FlxColor.GREEN, true, "heroBody");
		
		legA = new FlxSprite(-25, -75);
		legA.makeGraphic(20, 75, FlxColor.RED, true, "heroLegA");
		
		legB = new FlxSprite(5, -75);
		legB.makeGraphic(20, 75, FlxColor.BLUE, true, "heroLegB");
		
		add(body);
		add(legA);
		add(legB);
	}
	
	override public function update()
	{
		//FlxG.collide(this, this);
		body.y = (legA.y + legB.y) / 2 - body.height;
		
		super.update();
	}
	
}