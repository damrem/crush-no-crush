package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author damrem
 */
class Hero extends FlxSpriteGroup
{
	var legA:flixel.FlxSprite;
	var legB:flixel.FlxSprite;
	var body:flixel.FlxSprite;

	public static inline var ACCELERATION:UInt = 200;
	public static inline var GRAVITY:UInt = 500;
	public static inline var BODY_WIDTH:UInt = 160;
	public static inline var LEG_WIDTH:UInt = 40;
	public static inline var LEG_HEIGHT:UInt = 100;
	static public inline var MAX_STEP_STRENGTH:UInt= 10;
	
	
	public var backLeg:FlxSprite;
	public var stepStrength:Int=0;
	public var legs:FlxSpriteGroup;
	public var state:HeroState=Idle;
	
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		//drag.x = 500;
		
		body = new FlxSprite();
		body.makeGraphic(BODY_WIDTH, cast(FlxG.height/2), FlxColor.GREEN, true, "hero");
		add(body);
		
		legA = new FlxSprite();
		legA.makeGraphic(LEG_WIDTH, LEG_HEIGHT, FlxColor.BLUE, true, "legA");
		legA.y = body.height;
		legA.acceleration.y = GRAVITY;
		//legA.drag.x = 1000;
		add(legA);
		
		legB = new FlxSprite();
		legB.makeGraphic(LEG_WIDTH, LEG_HEIGHT, FlxColor.RED, true, "legB");
		legB.x = body.width - legB.width;
		legB.y = body.height;
		legB.acceleration.y = GRAVITY;
		//legB.drag.x = 1000;
		add(legB);
		
		legs = new FlxSpriteGroup(0, 0, 2);
		legs.add(legA);
		legs.add(legB);
		
		backLeg = legA;
		
		#if debug
		/*
		FlxG.watch.add(body, "x", "bx");
		FlxG.watch.add(body, "y", "by");
		*/
		FlxG.watch.add(this, "state");
		FlxG.watch.add(backLeg, "x", "blx");
		FlxG.watch.add(backLeg, "y", "bly");
		FlxG.watch.add(backLeg.velocity, "x", "blvx");
		FlxG.watch.add(backLeg.velocity, "y", "blvy");
		
		/*
		FlxG.watch.add(legA.velocity, "x");
		FlxG.watch.add(legA.velocity, "y");
		FlxG.watch.add(legB.velocity, "x");
		FlxG.watch.add(legB.velocity, "y");
		*/
		FlxG.watch.add(this, "stepStrength");
		#end
	}
	
	public function startStep()
	{
		trace("startStep");
		//state = Stepping;
		trace(5 * stepStrength, -5 * stepStrength);
		backLeg.velocity.set(20 * stepStrength, -20 * stepStrength);
		stepStrength = 0;
	}
	
	override public function update()
	{
		if (backLeg.velocity.y > 0)
		{
			state = Descending;
		}
		else if (backLeg.velocity.y < 0)
		{
			state = Ascending;
		}
		else if (state == Descending) {
			state = Landing;
			switchLeg();
		}
		else
		{
			state = Idle;
			
		}
		
		body.x = (legA.x + legB.x) / 2 - body.width / 2;
		
		
		super.update();
	}
	
	function switchLeg()
	{
		
		if (backLeg == legA)
		{
			backLeg = legB;
		}
		else 
		{
			backLeg = legA;
		}
		trace("switchLeg to " + backLeg);
	}
	
}

enum HeroState {
	Ascending;
	Descending;
	Landing;
	Idle;
	
}