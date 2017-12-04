package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
import sys.db.Sqlite;
import sys.db.Connection;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;







class PlayState extends FlxState 
	

{
	private var _sprBackGround1:FlxSprite; // Background
	
	
	private var autoErase:Bool = false;
	
	private var tutorialArray:Array<TutorialText> = new Array<TutorialText>();	
	private var keysArray:Array<FlxKey> = new Array<FlxKey>();	
	
	private var _Clock:FlxText;
	private var currentTime:String;
	private var _tmrText:FlxTimer;	
	private var _btnWork:FlxButton;
	private var _btnShop:FlxButton;
	private var _btnHouse:FlxButton;
	private var _btnBack:FlxButton;
	private var _btnBar:FlxButton;
	private var _btnGym:FlxButton;
	private var _sprTextBalloon:FlxSprite;
	private var _sprBlob:FlxSprite;
	private var _sprArrow:FlxSprite;
	private var bgMusic:FlxSound;
	private var playing:Bool = false;
	private var _btnSettings:FlxButton;
	private var _btnStats:FlxButton;
	private var _btnSun:FlxButton;
	private var dark:Bool = false;

	public static var textState:Int = 0;
	
	
	
	override public function create():Void 
	{
		
		//puts the Space key in the Array which is used to skip the FlxTypeText
		keysArray.push(FlxKey.SPACE);
		//setup the background		
		_sprBackGround1 = new FlxSprite(0, 0, AssetPaths.BackgroundPlayState__png);
		add(_sprBackGround1);
			
		//Setup a clock with the Current Date and Time
		_Clock = new FlxText(0, 0, 300, Std.string(Date.now()), 20, false);
		_Clock.x = -150;
		_Clock.y = 30;
		add(_Clock);
		//return
		_btnBack = new FlxButton(FlxG.width - 80, FlxG.height - 80, "", MenuState.GetInstance().clickMainState);
		_btnBack.loadGraphic(AssetPaths.returnIcon__png, true, 70, 70);		
		add(_btnBack);
		//settings
		_btnSettings = new FlxButton(_btnBack.x - 70, FlxG.height - 80, "", MenuState.GetInstance().clickOptions);
		_btnSettings.loadGraphic(AssetPaths.SettingsButton__png,true,70,70);
		add(_btnSettings);
		//stats
		_btnStats = new FlxButton(_btnSettings.x - 70, FlxG.height - 80, "", MenuState.GetInstance().clickStats);
		_btnStats.loadGraphic(AssetPaths.Stats__png, true, 50, 58);			
		add(_btnStats);
		
		//calls the function StartText if textstate == 0 to make sure it doesn't start again when you go to this state.
		if (textState == 0)// !!!!!!!!!! Set to 1 to skip the TextAnimation
		{				
			//setup textBalloon
			_sprTextBalloon = new FlxSprite(0, 0, AssetPaths.TextBalloonBig__png);
			_sprTextBalloon.x = (FlxG.width - _sprTextBalloon.width) / 2 - 70;
			_sprTextBalloon.y = 500;	
			_sprTextBalloon.alpha = 0.8;
			//setup Blob
			_sprBlob = new FlxSprite(0, 0, AssetPaths.Blob2__png);
			_sprBlob.x = 10;
			_sprBlob.y = 400;
			//setup Arrow
			_sprArrow = new FlxSprite(0, 0, AssetPaths.Arrow__png);
			_sprArrow.x = _btnStats.x;
			_sprArrow.y = _btnStats.y - 100;
			
			add(_sprBlob);
			add(_sprTextBalloon);			
			StartText();
			
		}
		else
		{					
			
			// setup the Bar button --------------- Just to test the game
			_btnBar = new FlxButton(0, 0, "", MenuState.GetInstance().clickBar);
			_btnBar.loadGraphic(AssetPaths.ButtonBar__png,true,140,174);
			_btnBar.x = 460;
			_btnBar.y = 210;	
			_btnBar.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnBar.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			add(_btnBar);		
			// setup the _btnGym button --------------- Just to test the game
			_btnGym = new FlxButton(0, 0, "", MenuState.GetInstance().clickGym);
			_btnGym.loadGraphic(AssetPaths.ButtonGym__png,true,135,186);
			_btnGym.x = 330;
			_btnGym.y = 290;	
			_btnGym.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnGym.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			add(_btnGym);		
			// setup the _btnHouse button --------------- Just to test the game
			_btnHouse = new FlxButton(0, 0, "", MenuState.GetInstance().clickHouse);
			_btnHouse.loadGraphic(AssetPaths.buttonHouse__png,true,305,288);
			_btnHouse.x = FlxG.width - _btnHouse.width;
			_btnHouse.y = 260;	
			_btnHouse.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnHouse.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			add(_btnHouse);
			// setup the _btnWork button --------------- Just to test the game
			_btnWork = new FlxButton(0, 0, "", MenuState.GetInstance().clickWork);
			_btnWork.loadGraphic(AssetPaths.ButtonWork__png,true,357,650);
			_btnWork.x = 0;
			_btnWork.y = 30;	
			_btnWork.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnWork.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			add(_btnWork);	
			// setup the _btnShop button --------------- Just to test the game
			_btnShop = new FlxButton(0, 0, "", MenuState.GetInstance().clickShop);
			_btnShop.loadGraphic(AssetPaths.ShopButton__png,true,153,152);
			_btnShop.x = FlxG.width - _btnShop.width;
			_btnShop.y = 90;	
			_btnShop.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnShop.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			add(_btnShop);	
			// setup the sun button --------------- Just to test the game
			_btnSun = new FlxButton(0, 0, "", changeToDark);
			_btnSun.loadGraphic(AssetPaths.SunButton__png,true,231,108);
			_btnSun.x = 300;
			_btnSun.y = 0;	
			add(_btnSun);	
			
		}		
		
		super.create();
	}
	/*
	 * Function that changes the images of all the Buildings in the game Depending on if Dark = false or true
	 * changes the x of _btnSun since the Sun get changed witha moon.
	 * */
	function changeToDark() 
	{
		if (dark == false)
		{
			_sprBackGround1.loadGraphic(AssetPaths.BackGroundPlayStateDark__png);
			_btnBar.loadGraphic(AssetPaths.BarButtonDark__png, true, 140, 174);
			_btnGym.loadGraphic(AssetPaths.GymButtonDark__png, true, 135, 186);
			_btnHouse.loadGraphic(AssetPaths.HouseButtonDark__png, true, 305, 288);
			_btnWork.loadGraphic(AssetPaths.WorkButtonDark__png, true, 357, 650);
			_btnShop.loadGraphic(AssetPaths.ShopButtonDark__png, true, 153, 152);
			_btnSun.loadGraphic(AssetPaths.MoonButton__png, true, 66, 72);
			_btnSun.x = 369;
			dark = true;
		}
		else
		{
			_sprBackGround1.loadGraphic(AssetPaths.BackgroundPlayState__png);
			_btnBar.loadGraphic(AssetPaths.ButtonBar__png,true,140,174);
			_btnGym.loadGraphic(AssetPaths.ButtonGym__png, true, 135, 186);
			_btnHouse.loadGraphic(AssetPaths.buttonHouse__png, true, 305, 288);
			_btnWork.loadGraphic(AssetPaths.ButtonWork__png, true, 357, 650);
			_btnShop.loadGraphic(AssetPaths.ShopButton__png, true, 153, 152);
			_btnSun.loadGraphic(AssetPaths.SunButton__png,true,231,108);
			_btnSun.x = 300;
			dark = false;
			
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);	
		updateTime();
		
	}	
	//destroys all the objects in this function
	override public function destroy():Void
	{
		super.destroy();
		_sprBackGround1 = FlxDestroyUtil.destroy(_sprBackGround1);		
			
	}
	//requests the text from the DataBase
	public function requestText()
	{
		var cnx = Sqlite.open("assets/data/Project1.db");
		var resultSet = cnx.request("SELECT * FROM WelcomeText");
		
		for (row in resultSet)
		{
			var textWelcome:TutorialText = new TutorialText(Math.ceil((FlxG.width / 2) - 250),550,470);			
			
			textWelcome._text.resetText ( row.text );			
			
			tutorialArray.push(textWelcome);
		}
		cnx.close();
	}		
	/*
	 * This function calls requestText(), adds the Tutorial array and starts the animation 
	 * 
	 * */
	public function StartText():Void
	{				
		if (textState <= 2)// use this to make sure it starts over but stops at the last text
		{
			requestText();// Calling the function that gets the text from the Sqlite DataBase				
			add(tutorialArray[textState]);
			tutorialArray[textState]._text.start(0.05, false, false,keysArray, EraseTimer);	
			
		}
		
	}
	//time before the text starts to erase itself
	public function EraseTimer():Void
	{		
		_tmrText = new FlxTimer().start(2.0, EraseText, 1);		
					
	}
	//This functions gets the Date when called and change the _Clock.text with the current Date + time
	public function updateTime()
    {
		var currentDate:Date;
		
		currentTime = Std.string(Date.now());
		_Clock.text = currentTime;
		
		
    }
	//starts to auto erase the text when called
	public function EraseText(Timer:FlxTimer):Void
	{
		if (textState <= 1)// use this to make sure it starts over but stops at the last text
		{
			tutorialArray[textState]._text.erase(0.025, false, null ,StartText);				
		}
		else
		{
			add(_sprArrow);
		}
		textState ++;
	}
	//function that destroys the _sprTextBalloon when called
	public function EraseTextBalloon(Tween:FlxTween):Void
	{
		FlxDestroyUtil.destroy(_sprTextBalloon);
	}	
	
}
	