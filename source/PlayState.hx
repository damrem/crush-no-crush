package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

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
		
		hero = new Hero();
		hero.drag.x = 1000;
		//hero.maxVelocity.set(200, 800);
		hero.acceleration.y = 200;
		add(hero);
		
		ground = new Ground();
		add(ground);
		
		
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
			hero.acceleration.x += hero.drag.x;
		}
		
		
		super.update();
		FlxG.collide(hero, ground);
	}	
}