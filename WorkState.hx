package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.ui.FlxBitmapTextButton;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
import sys.db.Sqlite;

/**
 * ...
 * @author Bas
 */
class WorkState extends FlxState
{
	private var _sprBackGround1:FlxSprite;
	private var _sprAnimation:FlxSprite;
	private var imageCount:Int = 3;
	private var _tmrGame:FlxTimer;
	
	private var tutorialArray:Array<TutorialText> = new Array<TutorialText>();	
	private var keysArray:Array<FlxKey> = new Array<FlxKey>();
	
	private var _tmrText:FlxTimer;
	private var _sprTextBalloon:FlxSprite;
		
	
	public static var textState:Int = 0;

	/*
	 * Depending on the textState it will add a background or adds a Hud or Timer
	 * */
	override public function create():Void 
	{
		//puts the Space key in the Array which is used to skip the FlxTypeText
		keysArray.push(FlxKey.SPACE);	
		
		
		
		//setup textBalloon
		_sprTextBalloon = new FlxSprite(0, 0, AssetPaths.TextBalloonLongRight__png);
		_sprTextBalloon.x = FlxG.width - _sprTextBalloon.width - 85;
		_sprTextBalloon.y = 210;
		_sprTextBalloon.alpha = 0.8;
		
		if (textState >= 2) 
		{
			_sprAnimation = new FlxSprite(0, 0, AssetPaths.workBackground__png);			
			add(_sprAnimation);			
			
			//adds HUD
			var _hud:HUD = new HUD();	
			add(_hud);	
		}
		else
		{
			_sprAnimation = new FlxSprite(0, 0, AssetPaths.workBackground1__png);
			add(_sprAnimation);
			
			_tmrGame = new FlxTimer().start(0.5, spriteAnimation, 4);
		}	
		
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
	/*
	 * if imagecount = 6 Adds SprTextBallon and calls the Function StartText
	 * Else Loads Image depending on ImageCount and increases the ImageCount with 1
	 * 
	 * */
	private function spriteAnimation(timer:FlxTimer):Void
	{		
		
		if (imageCount == 6)
		{
			add(_sprTextBalloon);			
			StartText();
		}
		else
		{
			_sprAnimation.loadGraphic("assets/images/Backgrounds/workBackground" + imageCount + ".png");	
			imageCount++;
		}
	}
	/*
	 * This function calls requestText(), adds the Tutorial array and starts the animation
	 * 
	 * */
	public function StartText():Void
	{				
		if (textState <= 2)// use this to make sure it starts over but stops at the last text
		{
			requestText();			
			add(tutorialArray[textState]);
			tutorialArray[textState]._text.start(0.05, false, false,keysArray, EraseTimer);	
			
		}		
	}
	//time before the text starts to erase itself
	public function EraseTimer():Void
	{		
		_tmrText = new FlxTimer().start(2.0, EraseText, 1);		
					
	}
	/*
	 * if Textstate <=1 Erases Text
	 * Else Create a Button with Yes and No
	 * 
	 * Increases the TextState with 1 
	 * */
	public function EraseText(Timer:FlxTimer):Void
	{
		if (textState <= 1)// use this to make sure it starts over but stops at the last text
		{
			tutorialArray[textState]._text.erase(0.025, false, null ,StartText);				
		}
		else
		{
			
			var _btnYes:FlxButton = new FlxButton((FlxG.width / 2) - 200, FlxG.height - 58, "YES",MenuState.GetInstance().clickWork );
			_btnYes.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			_btnYes.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);		
			_btnYes.label = new FlxText(0, 0, 0, "          YES");
			_btnYes.label.setFormat(null, 20, 0x4f3510, FlxTextAlign.CENTER);
			_btnYes.scale.y = 3;
			_btnYes.scale.x = 3;
			_btnYes.updateHitbox();
			add(_btnYes);
			
			
			var _btnNo:FlxButton = new FlxButton((FlxG.width/2) +100, FlxG.height-58, "",MenuState.GetInstance().clickPlay);
			_btnNo.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
			_btnNo.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
			_btnNo.label = new FlxText(0, 0, 0, "             NO");
			_btnNo.label.setFormat(null, 20, 0x4f3510, FlxTextAlign.CENTER);
			_btnNo.scale.y = 3;
			_btnNo.scale.x = 3;
			_btnNo.updateHitbox();
			add(_btnNo);
		}
		textState ++;
	}
	
	//requests the text from the DataBase
	public function requestText()
	{
		var cnx = Sqlite.open("assets/data/Project1.db");
		var resultSet = cnx.request("SELECT * FROM WorkState");
		
		for (row in resultSet)
		{
			var textWelcome:TutorialText = new TutorialText(FlxG.width - 560,250,450);			
			textWelcome._text.resetText ( row.text );			
			
			tutorialArray.push(textWelcome);
		}
		cnx.close();
	}		
}