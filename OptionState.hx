package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
using flixel.util.FlxSpriteUtil;
import flixel.util.FlxDestroyUtil;
import flixel.addons.ui.FlxSlider;
import flash.system.System;


/**
 * ...
 * @author Bas Benjamins
 * 
 * TODO Mute button is not working ATM.
 */
class OptionState extends FlxState
{
	
	private var _btnBack:FlxButton;
	private var _btnMute:FlxButton;
	private var _sprBackGround:FlxSprite;
	private var _barVolume:FlxBar;
	private var _txtVolume:FlxText;
	private var _txtVolumeAmt:FlxText;
	private var _btnVolumeDown:FlxButton;
	private var _btnVolumeUp:FlxButton;
	
	private var _save:FlxSave; // a save object for saving settings
	
	
	
	override public function create():Void 
	{
	
		// create and bind our save object to "flixel-tutorial"
		_save = new FlxSave();
		_save.bind("flixel-Sound");		
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0, AssetPaths.BackGroundBloB__jpg);
		add(_sprBackGround);
		
		//setup the button back
		_btnBack = new FlxButton((FlxG.width/2)+100, FlxG.height-58, "", MenuState.GetInstance().clickMainState);
		_btnBack.label = new FlxText(0, 0, 0, "Back");
		_btnBack.label.setFormat(null, 20, 0x4f3510, "center");
		_btnBack.scale.y = 3;
		_btnBack.scale.x = 3;
		_btnBack.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnBack.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		add(_btnBack);				
		//setup the button - bar
		_btnVolumeDown = new FlxButton(300,430, "-", clickVolumeDown);
		_btnVolumeDown.loadGraphic(AssetPaths.button__png, true, 0, 0);
		_btnVolumeDown.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnVolumeDown.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnVolumeDown.scale.x = 3;
		_btnVolumeDown.scale.y = 3;
		add(_btnVolumeDown);
		//setup the button + bar
		_btnVolumeUp = new FlxButton(FlxG.width - 400,440, "+", clickVolumeUp);
		_btnVolumeUp.loadGraphic(AssetPaths.button__png, true, 0,0);
		_btnVolumeUp.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		_btnVolumeUp.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnVolumeUp.scale.x = 3;
		_btnVolumeUp.scale.y = 3;
		add(_btnVolumeUp);
		//setup the volume bar
		_barVolume = new FlxBar((FlxG.width - 602) / 2, 400, FlxBarFillDirection.LEFT_TO_RIGHT, 500, 90, null, null, 0, 100, false);
		_barVolume.value = 0;
		//_barVolume.createFilledBar(FlxColor.GREEN, FlxColor.WHITE, true, FlxColor.BLACK);	
		_barVolume.createImageBar(AssetPaths.MusicBarBackground__png, AssetPaths.MusicBar__png, null, null);
		_barVolume.screenCenter;
		add(_barVolume);
		//setup the text for the volume bar
		_txtVolumeAmt = new FlxText(0,0, 200, Std.string( FlxG.sound.volume * 100) + "%", 16);
		_txtVolumeAmt.alignment = "center";
		_txtVolumeAmt.borderStyle = FlxTextBorderStyle.OUTLINE;
		_txtVolumeAmt.borderColor = FlxColor.BLACK;
		_txtVolumeAmt.x = (FlxG.width - _txtVolumeAmt.width) / 2;
		_txtVolumeAmt.y = _barVolume.y + (_barVolume.height / 2) - (_txtVolumeAmt.height / 2);
		add(_txtVolumeAmt);
				
		//Camera fade in and out		
		FlxG.camera.fade(FlxColor.BLACK, .33, true);
		
		updateVolume();
		
		super.create();	
	}

	/**
	 * The user clicked the down button for volume - we reduce the volume by 10% and update the bar
	 */
	private function clickVolumeDown():Void
	{
		FlxG.sound.volume -= 0.1;
		_save.data.volume = FlxG.sound.volume;
		updateVolume();
	}	
	/**
	 * The user clicked the up button for volume - we increase the volume by 10% and update the bar
	 */
	private function clickVolumeUp():Void
	{
		FlxG.sound.volume += 0.1;
		_save.data.volume = FlxG.sound.volume;
		updateVolume();
	}	
	/**
	 * Whenever we want to show the value of volume, we call this to change the bar and the amount text
	 */
	private function updateVolume():Void
	{
		var vol:Int = Math.round(FlxG.sound.volume * 100);
		_barVolume.value = vol;
		trace(_barVolume.value);
		_txtVolumeAmt.text = Std.string(vol) + "%";
	}	
	
	//destroys all the objects in this function
	override public function destroy():Void 
	{
		super.destroy();
		
		// cleanup all our objects!	
		_btnBack = FlxDestroyUtil.destroy(_btnBack);
		_txtVolumeAmt = FlxDestroyUtil.destroy(_txtVolumeAmt);
		_btnVolumeDown = FlxDestroyUtil.destroy(_btnVolumeDown);
		_btnVolumeUp = FlxDestroyUtil.destroy(_btnVolumeUp);
		_sprBackGround = FlxDestroyUtil.destroy(_sprBackGround);
		_save.destroy();
		_save = null;
		
	}
}