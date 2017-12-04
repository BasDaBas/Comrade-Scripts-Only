package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;



/**
 * ...
 * @author Bas Benjamins
 */
class HUD extends FlxTypedGroup<FlxSprite>
{
	private var _btnSettings:FlxButton;
	private var _btnStats:FlxSprite;
	private var _btnVideo:FlxSprite;
	private var _dateTime:DateTools;
	private var _btnBack:FlxButton;
	
	
	/*
	 * This class is used to add the back,setting and stats button to the screen when ever this class is added. 
	 * */
	public function new()
	{
		super();
		
		_btnBack = new FlxButton(FlxG.width - 80, FlxG.height - 80,"", MenuState.GetInstance().clickPlay);		
		_btnBack.loadGraphic(AssetPaths.returnIcon__png,true,70,70);	
		
		_btnSettings = new FlxButton(_btnBack.x - 70, FlxG.height - 80, "", MenuState.GetInstance().clickOptions);
		_btnSettings.loadGraphic(AssetPaths.SettingsButton__png,true,70,70);
		
		_btnStats = new FlxButton(_btnSettings.x - 70, FlxG.height - 80, "", MenuState.GetInstance().clickStats);
		_btnStats.loadGraphic(AssetPaths.Stats__png, true, 50, 58);			
		
		add(_btnSettings);
		add(_btnStats);
		add(_btnBack);
				
		
	}
	
	
	
	
	
	
	
}