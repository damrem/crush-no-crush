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
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import openfl.Lib;

import openfl.display.BitmapData;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var hero:SteppingHero;
	var ground:Ground;
	var dwarves:FlxTypedGroup<Dwarf>;
	var worldDebug:Rect;
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
		add(hero);
		
		FlxG.worldBounds.y = hero.y -hero.backLeg.width;
		FlxG.worldBounds.width = hero.backLeg.width * 2;
		FlxG.worldBounds.height = hero.backLeg.width * 2;
		
		#if debug
		worldDebug = new Rect(Std.int(FlxG.worldBounds.width), Std.int(FlxG.worldBounds.height), 0x80ffff00);
		add(worldDebug);
		#end
		
		var poolSize = 100;
		dwarves = new FlxTypedGroup<Dwarf>(poolSize);
		
		FlxG.watch.add(hero, "x");
		FlxG.watch.add(FlxG.worldBounds, "x");
		hero.onStep.add(shake);
		for (i in 0...poolSize)
		{
			var dwarf = new Dwarf();
			dwarf.kill();
			dwarves.add(dwarf);
		}
		add(dwarves);
		
		
		FlxG.camera.follow(hero.head, FlxCamera.STYLE_PLATFORMER, new FlxPoint(-250, 0), 10);
		
		super.create();
		
	}
	
	function shake() 
	{
		//trace ("shake");
		FlxG.camera.shake(0.01, 0.1, null, true, FlxCamera.SHAKE_VERTICAL_ONLY);
		FlxG.sound.play("assets/sounds/step"+FlxRandom.intRanged(1,6)+".wav");
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
		generateDwarves();
		handleControls();
		
		FlxG.worldBounds.x = hero.backLeg.x;
		FlxG.overlap(hero.backLeg, dwarves, killDwarf);
		
		#if debug
		debugWorld();
		#end
		
		super.update();
		
		
	}
	
	
	function debugWorld()
	{
		worldDebug.x = FlxG.worldBounds.x;
		worldDebug.y = FlxG.worldBounds.y;
		worldDebug.width = FlxG.worldBounds.width;
		worldDebug.height = FlxG.worldBounds.height;
	}
	
	function generateDwarves()
	{
		var chance:Float = hero.state == Stepping?5:1;
		if (FlxRandom.chanceRoll(chance))
		{
			//trace("chance");
			//dwarves.recycle();
			var dwarf = dwarves.recycle(Dwarf);
			dwarf.setPosition(hero.body.x + 640, -dwarf.height);
			dwarf.velocity.x = FlxRandom.intRanged( -10, -30);
			add(dwarf);
			
		}
	}
	
	function killDwarf(leg:FlxSprite, dwarf:FlxSprite) 
	{
		if (hero.isSteppingDown())
		{
			dwarf.y=100;
		}
	}
	
	
	
	function handleControls()
	{
		if (FlxG.keys.pressed.SPACE)
		{
			hero.advance();
		}
		/*else if (FlxG.keys.justReleased.SPACE) {
				hero.advance();
		}*/
	}
}