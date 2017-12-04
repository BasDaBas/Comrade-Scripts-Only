package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.util.FlxSave;
import flash.display.Sprite;

class Main extends Sprite
{
		
	public function new()
	{
		
		var startFullscreen:Bool = false;
		var _save:FlxSave = new FlxSave();		
		
		_save.bind("flixelGame");
		
		#if desktop
		if (_save.data.fullscreen != null)
		{
			startFullscreen = _save.data.fullscreen;
		}
		#end
		
		super();		
		
		addChild(new FlxGame(1280, 720, MenuState, 1, 60, 60, false, startFullscreen));	
		
		_save.close();
	}
	
}