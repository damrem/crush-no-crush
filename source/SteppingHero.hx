package ;


import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxRect;
import hxlpers.Range;
import motion.Actuate;
import motion.easing.Linear;
import motion.MotionPath;
import msignal.Signal.Signal0;

/**
 * ...
 * @author damrem
 */
class SteppingHero extends FlxSpriteGroup
{
	var isControlled:Bool;
	public var state:HeroState;
	
	static public inline var LEG_WIDTH:Int = 16;
	static public inline var LEG_HEIGHT:Int= 48;
	
	static public inline var STEP_LENGTH:Int= 128;
	static public inline var STEP_HALFLENGTH:Float= STEP_LENGTH / 2;
	static public inline var STEP_HEIGHT:Float = STEP_LENGTH / 2;
	static public inline var STEP_DURATION:Float= 0.5;
	
	static public inline var BODY_WIDTH:Float= STEP_HALFLENGTH + LEG_WIDTH;
	static public inline var BODY_HALFWIDTH:Float= BODY_WIDTH / 2;
	static public inline var BODY_HEIGHT:Float = BODY_WIDTH * 2;
	
	static public inline var HEAD_WIDTH:Int = 32;
	static public inline var HEAD_HEIGHT:Int= HEAD_WIDTH * 2;

	var leftLeg:Rect;
	var rightLeg:Rect;
	public var backLeg:Rect;
	var frontLeg:Rect;
	
	public var body:Rect;
	public var head:Rect;
	
	public var onStep:Signal0;

	var prevBackLegY:Float;
	
	public function new() 
	{
		super();
		
		//trace("new");
		
		onStep = new Signal0();
		
		state = Standing;
		
		leftLeg = backLeg = new Rect(LEG_WIDTH, LEG_HEIGHT * 2);
		leftLeg.x -= STEP_HALFLENGTH / 2;
		leftLeg.y -= LEG_HEIGHT * 2;
		add(leftLeg);
		
		rightLeg = frontLeg = new Rect(LEG_WIDTH, LEG_HEIGHT * 2);
		rightLeg.x += STEP_HALFLENGTH / 2;
		rightLeg.y -= LEG_HEIGHT * 2;
		add(rightLeg);
		
		body = new Rect(cast(BODY_WIDTH), cast(BODY_HEIGHT));
		updateBody();
		add(body);
		
		head = new Rect(HEAD_WIDTH, HEAD_HEIGHT);
		updateHead();
		add(head);
		 
	}
	
	function updateBody() 
	{
		//body.x = Math.min(leftLeg.x, rightLeg.x);
		body.x = (leftLeg.x + rightLeg.x) / 2 - LEG_WIDTH * 2;
		body.y = (leftLeg.y + rightLeg.y) / 4 - BODY_HEIGHT;// - LEG_HEIGHT;
		//body.width = Math.abs(rightLeg.x - leftLeg.x) + LEG_WIDTH;
		body.scale.x = (Math.abs(rightLeg.x - leftLeg.x) + LEG_WIDTH) / BODY_WIDTH;
		
	}
	
	function updateHead()
	{
		head.x = body.x + (body.width - HEAD_WIDTH) / 2;
		head.y = body.y - HEAD_HEIGHT;
		
	}
	
	public function advance()
	{
		//trace("advance");
		
		switch(state)
		{
			case Standing:
				//trace("was Standing");
				step();
				
			case Stepping:
				//trace("was Stepping");
				
			case Freezing:
				//trace("was Freezing");
				state = Stepping;
				Actuate.resume(backLeg);
		}
	}
	
	public function freeze()
	{
		//trace("freeze");
		if (state == Stepping)
		{
			state = Freezing;
			Actuate.pause(backLeg);
		}
	}
	
	function step()
	{
		//trace("step");
		state = Stepping;
		var path = new MotionPath().bezier(backLeg.x + STEP_LENGTH, backLeg.y, backLeg.x + STEP_HALFLENGTH, backLeg.y - STEP_HEIGHT);
		Actuate.motionPath(backLeg, STEP_DURATION, { x:path.x, y:path.y } ).ease(Linear.easeNone).onUpdate(update).onComplete(finishStep);
	}
	
	override function update() 
	{
		updateBody();
		updateHead();
		prevBackLegY = backLeg.y;
		super.update();
	}
	
	function finishStep() 
	{
		//trace("finishStep");
		state = Standing;
		onStep.dispatch();
		if (backLeg == leftLeg)
		{
			backLeg = rightLeg;
			frontLeg = leftLeg;
		}
		else
		{
			backLeg = leftLeg;
			frontLeg = rightLeg;
		}
		
		#if debug
		backLeg.color = 0xffff0000;
		frontLeg.color = 0xff00ff00;
		#end
		
		body.x -= STEP_LENGTH;
		backLeg.x -= STEP_LENGTH;
		frontLeg.x -= STEP_LENGTH;
		x += STEP_LENGTH;
		
	}
	
	public function isSteppingDown():Bool
	{
		return state == Stepping && backLeg.x > frontLeg.x;
	}
	
	public function getBackLegHRange():Range
	{
		var range = new Range(backLeg.x, backLeg.x + LEG_WIDTH);
		return range;
	}
	
}

enum HeroState
{
	Standing;
	Freezing;
	Stepping;
}

