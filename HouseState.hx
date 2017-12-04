package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * ...
 * @author Bas
 */
class HouseState extends FlxState
{
	private var _sprBackGround1:FlxSprite;
	private var _btnBack:FlxButton;

	override public function create():Void 
	{
		//setup the background		
		_sprBackGround1 = new FlxSprite(0, 0,AssetPaths.houseBackground__png);
		_sprBackGround1.setSize(1280, 720);
		add(_sprBackGround1);
		//adds HUD
		var _hud:HUD = new HUD();	
		add(_hud);		
		
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
}