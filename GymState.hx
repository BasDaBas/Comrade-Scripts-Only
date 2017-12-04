package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author Bas
 */
class GymState extends FlxState
{
	private var _sprBackGround1:FlxSprite;
	private var _workOut:FlxButton;
	
	override public function create():Void 
	{
		//setup the background		
		_sprBackGround1 = new FlxSprite(0, 0,AssetPaths.gymBackground__png);
		_sprBackGround1.setSize(1280, 720);
		add(_sprBackGround1);
		//adds HUD
		var _hud:HUD = new HUD();	
		add(_hud);			
		//setup button for workout
		_workOut = new FlxButton(400, 660, "Work Out",clickTrain);		
		_workOut.scale.y = 3;
		_workOut.scale.x = 3;
		add(_workOut);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);			
	}
	
	//destroys all the objects in this function
	override public function destroy():Void
	{
		super.destroy();			
	}
	//Fade in and goes to the WorkingOut State
	private function clickTrain():Void
	{		
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new WorkingOut());
		});
	}
}