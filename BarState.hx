package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
import sys.db.Sqlite;

/**
 * ...
 * @author Bas
 */
class BarState extends FlxState
{
	private var _sprBackGround:FlxSprite;
	private var _btnBack:FlxButton;
	private var _btnDrunk:FlxButton;
	private var _tmrText:FlxTimer;
	private var _sprTextBalloon:FlxSprite;
	
	private var tutorialArray:Array<TutorialText> = new Array<TutorialText>();	
	private var answerArray:Array<TutorialText2> = new Array<TutorialText2>();	
	private var keysArray:Array<FlxKey> = new Array<FlxKey>();
	
	public static var textState:Int = 0;	
	private static var Instance:BarState;

	override public function create():Void 
	{
		Instance = this;
		
		//puts the Space key in the Array which is used to skip the FlxTypeText
		keysArray.push(FlxKey.SPACE);
		//setup the background depending on the textState	
		if (textState == 0) 
		{
			_sprBackGround = new FlxSprite(0, 0,AssetPaths.BarBackground1__png);
			add(_sprBackGround);
		}
		else
		{
			_sprBackGround = new FlxSprite(0, 0,AssetPaths.BarBackground2__jpg);
			add(_sprBackGround);
		}		
		//setup the buttons
		_btnDrunk = new FlxButton(800, 500, "",getDrunk);
		_btnDrunk.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnDrunk.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnDrunk.label = new FlxText(0, 0, 0, "Get Drunk");
		_btnDrunk.label.setFormat(null, 20, 0x4f3510, "center");
		_btnDrunk.scale.y = 3;
		_btnDrunk.scale.x = 3;		
		//setup textBalloon
		_sprTextBalloon = new FlxSprite(0, 0, AssetPaths.TextBalloonLongRight__png);
		_sprTextBalloon.x = FlxG.width - _sprTextBalloon.width - 35;
		_sprTextBalloon.y = 330;
		_sprTextBalloon.scale.y = 1.4;
		_sprTextBalloon.scale.x = 1.1;		
		_sprTextBalloon.alpha = 0.8;
		
		
		/*
		* if Textstate == 0
		* calls the function StartText if textstate == 0 to make sure it doesn't start again when you go to this state.
		* 
		* Else:
		* adds the Hud and btnDrunk
		* */
		
		if (textState == 0)
		{				
			add(_sprTextBalloon);			
			StartText();
		}
		else
		{
			var _hud:HUD = new HUD();	
			add(_hud);
			add(_btnDrunk);
		}
		
		super.create();
	}
	
	public function CheckAnswer1(answer:FlxObject) 
	{
		trace("test1");
		EraseText();
	}
	public function CheckAnswer2(answer:FlxObject) //Has no answer 2 yet
	{
		trace("test2");
		EraseText();
	}
	public function CheckAnswer3(answer:FlxObject) //Has no answer 3 yet
	{
		trace("test3");
		EraseText();
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
	//Shakes the camera and changes the background
	public function getDrunk():Void
	{
		FlxG.camera.shake(0.009, 3);
		_sprBackGround.loadGraphic(AssetPaths.BarDrunk__png);
		_btnDrunk = FlxDestroyUtil.destroy(_btnDrunk);
		
	}	
	//requests the text from the DataBase
	public function requestText()
	{
		var cnx = Sqlite.open("assets/data/Project1.db");
		var resultSet = cnx.request("SELECT * FROM BarState");
		
		for (row in resultSet)
		{
			var textWelcome:TutorialText = new TutorialText(FlxG.width - 500,350,450);			
			textWelcome._text.resetText ( row.text );
			
			var answers:TutorialText2 = new TutorialText2(300, 300, 500);
			answers.answer1.text = ( row.Answer1);
			answers.answer2.text = ( row.Answer2);
			answers.answer3.text = ( row.Answer3);
			
			tutorialArray.push(textWelcome);
			answerArray.push(answers);
		}
		cnx.close();
	}	
	
	
	
	/*
	 * This function calls requestText(), adds the Tutorial array and starts the animation
	 * 
	 * */
	public function StartText():Void
	{				
		trace(textState);
		if (answerArray != null) 
		{
			remove(answerArray[textState - 1],true);
		}
		
		if (textState == 5)
		{
			_sprBackGround.loadGraphic(AssetPaths.BarDrunk__png);
			BlobState.Energy = BlobState.Energy - 5;
			BlobState.Stress = BlobState.Stress + 10;
			BlobState.Health = BlobState.Health - 15;
			
		}
		if (textState <= 7) 
		{
			requestText();// Calling the function that gets the text from the Sqlite DataBase				
			add(tutorialArray[textState]);			
			 
			if (textState >= 4) 
			{
				tutorialArray[textState]._text.start(0.05, false, false, keysArray, EraseTimer);
			}
			else
			{
				tutorialArray[textState]._text.start(0.05, false, false, keysArray, addText);
			}
		}
		else
		{
			FlxDestroyUtil.destroy(_sprTextBalloon);
			//adds HUD
			var _hud:HUD = new HUD();	
			add(_hud);
		}
	}
	//adds the answerArray to the game (depending on the textState)
	function addText() 
	{
		add(answerArray[textState]);
	}
	//time before the text starts to erase itself
	public function EraseTimer():Void
	{		
		_tmrText = new FlxTimer().start(2.0, EraseTimerText, 1);		
					
	}	
	//starts to auto erase the text when called
	public function EraseText():Void
	{
		
		tutorialArray[textState]._text.erase(0.025, false, null ,StartText);				
		textState ++;
	}
	//Function that erases the text
	public function EraseTimerText(event:FlxTimer):Void
	{
		
		tutorialArray[textState]._text.erase(0.025, false, null ,StartText);				
		textState ++;		
	}	
	
	public static function GetInstance() : BarState
	{
		return Instance;
	}

}