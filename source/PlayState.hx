package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var hero:Hero;
	var ground:Ground;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		
		ground = new Ground();
		ground.y = FlxG.height - Ground.HEIGHT;
		//ground.scrollFactor.y = 0;
		
		add(ground);
		
		hero = new Hero();
		hero.x = 100;
		hero.y = FlxG.height - hero.height - ground.height;
		hero.scrollFactor.y = 0;
		hero.drag.x = 1000;
		//hero.maxVelocity.set(200, 800);
		//hero.acceleration.y = 200;
		add(hero);
		
		//FlxG.camera.follow(hero, FlxCamera.STYLE_PLATFORMER, new FlxPoint(-200), 10);
		//FlxG.camera.followLerp = 10;
		//followLead.x = 20;
		
		#if debug
		FlxG.watch.add(hero, "x");
		FlxG.watch.add(hero, "y");
		#end
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		
		
		hero.acceleration.x = 0;
		
		if (FlxG.keys.pressed.SPACE)
			{
				hero.stepStrength ++;
				trace("pressed", hero.stepStrength);
				if (hero.stepStrength > Hero.MAX_STEP_STRENGTH)
				{
					hero.stepStrength = Hero.MAX_STEP_STRENGTH;
					//hero.startStep();
				}	
			}
			
		if (hero.state == Idle)
		{
			
			
			if (FlxG.keys.justPressed.SPACE)
			{
				trace("justPressed", hero.stepStrength);
				hero.startStep();
				
			}
		}
		
		super.update();
		FlxG.collide(hero.legs, ground, onStep);
	}	
	
	function onStep(leg:FlxSprite, ground:FlxSprite) 
	{
		//trace(leg);
		//if (leg.velocity.y > 0)
		{
			//trace("onStep");
			leg.velocity.x = 0;
		}
		//hero.state = Idle;
	}
}