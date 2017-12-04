package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;
import flash.system.System;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var _btnStart:FlxButton; // Play Button
	private var _txtTitle:FlxText;	// Title
	private var _btnOptions:FlxButton;	// Option Button
	private var _sprBackGround1:FlxSprite; // Background
	private var _btnExit:FlxButton;	// Exit Button
	
	private static var Instance:MenuState;
	
	public var _sprTextBalloon:FlxSprite;
	public var _btnBack:FlxButton;	
	
	
	/**
	* Function that is called up when to state is created to set it up. 
	*/
	public function new()
	{
		super();
		Instance = this;
	}
	
	override public function create():Void
	{
		
		//Background Music		
		FlxG.sound.playMusic(AssetPaths.bensound_funnysong__wav,0.7, true);
		
		//setup the background		---
		_sprBackGround1 = new FlxSprite(0, 0, AssetPaths.BackGroundMain__png);		
		// setup the play button
		_btnStart = new FlxButton(0, 0, "", clickPlay);
		_btnStart.loadGraphic(AssetPaths.StartButton2__png,true,437,84);
		_btnStart.x = 460;
		_btnStart.y = 285;	
		_btnStart.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnStart.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		//setup the Option button
		_btnOptions = new FlxButton(_btnStart.x + 10, _btnStart.y + 112, "", clickOptions);
		_btnOptions.loadGraphic(AssetPaths.OptionButton2__png,true,426,90);		
		_btnOptions.updateHitbox;
		_btnOptions.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnOptions.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		//setup exit button
		_btnExit = new FlxButton(_btnStart.x + 10, _btnStart.y + 222, "", clickExit);	
		_btnExit.loadGraphic(AssetPaths.ExitButton2__png, true, 427, 87);
		_btnExit.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnExit.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnExit.updateHitbox;			
		//Camera fade in and out
		FlxG.camera.fade(FlxColor.BLACK, .33, true);				
		
		//add the objects to the State
		add(_sprBackGround1);
		add(_btnStart);
		add(_btnOptions);
		add(_btnExit);
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		
		super.destroy();
		_btnStart = FlxDestroyUtil.destroy(_btnStart); 
		_btnOptions = FlxDestroyUtil.destroy(_btnOptions);
		_btnExit = FlxDestroyUtil.destroy(_btnExit);
		_sprBackGround1 = FlxDestroyUtil.destroy(_sprBackGround1);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	//function that change the state to MenuState when called
	public function clickMainState():Void
	{
			FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new MenuState());
		});
	}
	//function that change the state to Playstate when called
	public function clickPlay():Void
	{
		
			FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new PlayState());
		});			
	}	
	
	//function that change the state to OptionsState when called
	public function clickOptions():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new OptionState());
		});	
		
	}
	
	//function that change the state to BlobState when called
	public function clickStats():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new BlobState());
		});	
	}
	//function that change the state to BarState when called
	public function clickBar():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new BarState());
		});			
	}
	//function that change the state to GymState when called
	public function clickGym():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new GymState());
		});			
	}
	//function that change the state to HouseState when called
	public function clickHouse():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new HouseState());
		});			
	}
	//function that change the state to WorkState when called
	public function clickWork():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new WorkState());
		});					
	}
	//function that change the state to ShopState when called
	public function clickShop():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new ShopState());
		});			
	}
	//function that change the state to MemoryState when called
	public function clickMemory():Void
	{
		FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new MemoryState());
		});			
	}	
	//exit the system(Game) when called	
	private function clickExit():Void
	{
		System.exit(0);
	}
	 
	public static function GetInstance() : MenuState
	{
		return Instance;
	}
	
}
