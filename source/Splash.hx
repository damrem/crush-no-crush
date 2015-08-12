package;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author damrem
 */
class Splash extends FlxEmitter
{

	var drop:FlxParticle;
	
	
	public function new() 
	{
		super(0, 0, 10);
		gravity = 200;
		
		for (i in 0...Std.int(maxSize / 2))
		{
			drop = new FlxParticle();
			drop.makeGraphic(2, 2, FlxColor.RED);
			drop.visible = false;
			add(drop);
			
			drop = new FlxParticle();
			drop.makeGraphic(1, 1, FlxColor.RED);
			drop.visible = false;
			add(drop);
		}
		
		//start(true, 3, .01);
		
	}
	
	override public function start(Explode:Bool = true, Lifespan:Float = 0, Frequency:Float = 0.1, Quantity:Int = 0, LifespanRange:Float = 0)
	{
		super.start(true, 0.25, .1);
	}
	
}