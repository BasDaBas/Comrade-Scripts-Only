package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
import sys.db.Sqlite;

/**
 * ...
 * @author Bas
 */
class BlobState extends FlxState
{
	private var _btnBack:FlxButton;
	private var _sprBackGround:FlxSprite;
	private var _tmrText:FlxTimer;
	private var _sprArrow:FlxSprite;
	private var _sprCoin:FlxSprite;
	private var _sprTextBalloon:FlxSprite;

	public var _barHealth:FlxBar;
	public var _barHunger:FlxBar;
	public var _barStress:FlxBar;
	public var _barEnergy:FlxBar;
	
	public var _txtHealth:FlxText;
	public var _txtHunger:FlxText;
	public var _txtStress:FlxText;
	public var _txtEnergy:FlxText;
	public var _txtCoins:FlxText;

	private var tutorialArray:Array<TutorialText> = new Array<TutorialText>();
	private var keysArray:Array<FlxKey> = new Array<FlxKey>();	
	
	public static var Health:Int = 100;
	public static var Stress:Int = 100;
	public static var Hunger:Int = 100;
	public static var Energy:Int = 100;
	public static var Coins:Int = 0;
	
	public static var textState:Int = 0;
	
	private static var Instance:BlobState;

	/*
	 * Creates all the bars and text
	 * Depending on the textstate it will add a textbox with text animation
	 * updates the bar
	 * */
	override public function create():Void 
	{		
		
		Instance = this;
		
		
		restoreStats();
		
		
		keysArray.push(FlxKey.SPACE);
		//setup the background		
		_sprBackGround = new FlxSprite(0, 0, AssetPaths.BackGroundBloB__jpg);		
		add(_sprBackGround);		
		//Setup the HealthBar
		_barHealth  = new FlxBar(100, 520, LEFT_TO_RIGHT, 320, 66, null, null, 0, 100);
		_barHealth.value = 0;
		_barHealth.createImageBar(AssetPaths.HealthBarBackground__png, AssetPaths.HealthBar__png, null, null);
		add(_barHealth);
		//Setup the HealthText
		_txtHealth = new FlxText(_barHealth.x, 0, 300, Std.string(Health) + "%");	
		_txtHealth.setFormat(null, 14, FlxColor.BLACK, FlxTextAlign.CENTER, OUTLINE, null);		
		_txtHealth.y = _barHealth.y + (_barHealth.height / 2) - (_txtHealth.height / 2);
		add(_txtHealth);
		//Setup the HungerBar
		_barHunger  = new FlxBar((1160 - 300), 520, LEFT_TO_RIGHT, 320, 66, null, null, 0, 100);
		_barHunger.value = 0;
		_barHunger.createImageBar(AssetPaths.HungerBarBackground__png, AssetPaths.HungerBar__png, null, null);
		add(_barHunger);
		//Setup the HungerText
		_txtHunger = new FlxText(_barHunger.x, 0, 300, Std.string(Hunger) + "%");	
		_txtHunger.setFormat(null, 14, FlxColor.BLACK, FlxTextAlign.CENTER, OUTLINE, null);
		_txtHunger.y = _barHunger.y + (_barHunger.height / 2) - (_txtHunger.height / 2);
		add(_txtHunger);
		//Setup the StressBar
		_barStress  = new FlxBar(100, 620, LEFT_TO_RIGHT, 320, 66,null, null, 0, 100);
		_barStress.value = 0;
		_barStress.createImageBar(AssetPaths.StressBarBackground__png, AssetPaths.StressBar__png, null, null);
		add(_barStress);
		//Setup the StressText
		_txtStress = new FlxText(_barStress.x, 0, 300, Std.string(Stress) + "%",14);	
		_txtStress.setFormat(null, 14, FlxColor.BLACK, FlxTextAlign.CENTER, OUTLINE, null);
		_txtStress.y = _barStress.y + (_barStress.height / 2) - (_txtStress.height / 2);
		add(_txtStress);
		//Setup the EnergyBar
		_barEnergy  = new FlxBar((1160 - 300), 620, LEFT_TO_RIGHT, 320, 66, null, null, 0, 100);
		_barEnergy.value = 0;
		_barEnergy.createImageBar(AssetPaths.SleepBarBackground__png, AssetPaths.SleepBar__png, null, null);
		add(_barEnergy);		
		//Setup the EnergyText
		_txtEnergy = new FlxText(_barEnergy.x, 0, 300, Std.string(Energy) + "%");	
		_txtEnergy.setFormat(null, 14, FlxColor.BLACK, FlxTextAlign.CENTER, OUTLINE, null);
		_txtEnergy.y = _barEnergy.y + (_barEnergy.height / 2) - (_txtEnergy.height / 2);
		add(_txtEnergy);
		//Setup the Coin
		_sprCoin = new FlxSprite(0 , 10, AssetPaths.Coin__png);
		_sprCoin.x = FlxG.width - _sprCoin.width - 30;		
		add(_sprCoin);		
		_txtCoins = new FlxText(_sprCoin.x - 22, _sprCoin.y + 8, 0, Std.string(Coins), 30);
		add(_txtCoins);
		//setup button back
		_btnBack = new FlxButton(0,0, "", MenuState.GetInstance().clickPlay);
		_btnBack.x = FlxG.width - _btnBack.width - 10;
		_btnBack.y = FlxG.height - 80;
		_btnBack.loadGraphic(AssetPaths.returnIcon__png, true, 70, 70);
		add(_btnBack);
		
		//setup textBalloon
		_sprTextBalloon = new FlxSprite(0, 0, AssetPaths.TextBalloonSmall__png);
		_sprTextBalloon.x = 30;
		_sprTextBalloon.y = 255;	
		_sprTextBalloon.alpha = 0.8;
		
		trace(textState);
		//calls the function StartText if textstate == 0 to make sure it doesn't start again when you go to this state.
		if (textState == 0)//set to 1 to skip the textstate
		{				
			add(_sprTextBalloon);			
			StartText();
		}
		
		updateBars(Health,Hunger,Stress,Energy);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);		
	}
	
	override public function destroy():Void
	{
		super.destroy();
		_sprBackGround = FlxDestroyUtil.destroy(_sprBackGround);		
	}
	//updates all the bars
	public function updateBars(amountHealth:Int ,amountHunger:Int ,amountStress:Int ,amountEnergy:Int):Void
	{
		_barHealth.value = amountHealth;
		_barEnergy.value = amountEnergy;
		_barHunger.value = amountHunger;
		_barStress.value = amountStress;		
	}	
	
	/*
	 * If textState <= 2 
	 * This function calls requestText(), adds the Tutorial array and starts the text animation
	 *
	 * */
	public function StartText():Void
	{				
		if (textState <= 2)// use this to make sure it starts over but stops at the last text
		{
			requestText();// Calling the function that gets the text from the Sqlite DataBase				
			add(tutorialArray[textState]);
			tutorialArray[textState]._text.start(0.05, false, false,keysArray,EraseTimer);	
		}		
	}
	
	//time before the text starts to erase itself
	public function EraseTimer():Void
	{		
		_tmrText = new FlxTimer().start(2.0, EraseText, 1);		
					
	}
	
	//starts to auto erase the text when called
	public function EraseText(Timer:FlxTimer):Void
	{
		if (textState <= 1)// use this to make sure it starts over but stops at the last text
		{
			tutorialArray[textState]._text.erase(0.025, false, null ,StartText);				
		}
		textState ++;
		trace(textState);
	}
	
	//requests the text from the DataBase - BlobStatsText
	public function requestText()
	{
		var cnx = Sqlite.open("assets/data/Project1.db");
		var resultSet = cnx.request("SELECT * FROM BlobStatsText");
		
		for (row in resultSet)
		{
			var textWelcome:TutorialText = new TutorialText(90,290,350);			
									
			
			textWelcome._text.resetText ( row.text );
			tutorialArray.push(textWelcome);	
		
		}
		
		cnx.close();
	}	
	
	public static function GetInstance():BlobState
	{
		return Instance;
	}
	
	//This function is to make sure the Stats won't go under 0 and above 100
	private function restoreStats():Void
	{
		if (Health <= 0)
		{
			Health = 0;
		}
		if (Health >= 100)
		{
			Health = 100;
		}
		if (Stress <= 0)
		{
			Stress = 0;
		}
		if (Stress >= 100)
		{
			Stress = 100;
		}
		if (Hunger <= 0)
		{
			Hunger = 0;
		}
		if (Hunger >= 100)
		{
			Hunger = 100;
		}
		if (Energy <= 0)
		{
			Energy = 0;
		}
		if (Energy >= 100)
		{
			Energy = 100;
		}
	}
}

