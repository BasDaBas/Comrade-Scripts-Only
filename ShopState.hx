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
class ShopState extends FlxState
{
	public var _btnMemory:FlxButton;
	private var _sprBackGround1:FlxSprite;
	private var _btnBack:FlxButton;

	override public function create():Void 
	{
		//setup the background		
		_sprBackGround1 = new FlxSprite(0, 0, AssetPaths.BackgroundShop__png);
		add(_sprBackGround1);
		//adds HUD
		var _hud:HUD = new HUD();	
		add(_hud);			
		//adds a button to start the memory
		_btnMemory = new FlxButton(400, 660, "Memory",MenuState.GetInstance().clickMemory);
		_btnMemory.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnMemory.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnMemory.label.setFormat(null, 14, 0x4f3510, FlxTextAlign.CENTER);
		_btnMemory.scale.y = 3;
		_btnMemory.scale.x = 3;
		add(_btnMemory);
		
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