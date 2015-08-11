package;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import js.html.Point;
import openfl.display.BitmapData;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var hero:SteppingHero;
	var ground:Ground;
	var dwarves:FlxTypedGroup<Dwarf>;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		//add(new FlxBackdrop("assets/images/bg5.png", 0.0, 0.0, false, false));
		add(new FlxBackdrop("assets/images/bg4.png", 0.1, 0.0, true, false));
		add(new FlxBackdrop("assets/images/bg3.png", 0.2, 0.0, true, false));
		add(new FlxBackdrop("assets/images/bg2.png", 0.4, 0.0, true, false));
		add(new FlxBackdrop("assets/images/bg1.png", 0.8, 0.0, true, false));
		
		hero = new SteppingHero();
		hero.drag.x = 1000;
		add(hero);
		
		var poolSize = 100;
		dwarves = new FlxTypedGroup<Dwarf>(poolSize);
		FlxG.watch.add(dwarves, "members");
		for (i in 0...poolSize)
		{
			var dwarf = new Dwarf();
			dwarf.kill();
			dwarves.add(dwarf);
		}
		//add(dwarves);
		
		
		FlxG.camera.follow(hero.body, FlxCamera.STYLE_PLATFORMER, null, 10);
		
		super.create();
		
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
		//trace(FlxG.mouse.getWorldPosition());
		
		//hero.acceleration.x = 0;
		
		
		if (FlxRandom.chanceRoll(1))
		{
			trace("chance");
			//dwarves.recycle();
			var dwarf = dwarves.recycle();
			trace(dwarf);
			add(dwarves.recycle());
		}
		
		
		
		if (FlxG.keys.pressed.SPACE)
		{
			hero.advance();
		}
		else if (FlxG.keys.justReleased.SPACE) {
				hero.freeze();
		}
		
		
		super.update();
		//FlxG.collide(hero, ground);
	}	
}