package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.mouse.FlxMouse;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxTimer;
import sys.FileStat;

/**
 * ...
 * @author Bas
 */
class MemoryState extends FlxState
{
	
	var check:Bool = true;
	var finished:Bool = false; // to check if the player finished the game on time or not.
	
	var _sprBackGround1:FlxSprite;
	var _sprCadre:FlxSprite;

	var _startButton:FlxButton;
	var _backButton:FlxButton;

	var score:Int = 0;
	var scoreText:FlxText;
	
	var memoryCards:Array<Card> = new Array();
	var clickedCards:Array<Card> = new Array();
	
	var _tmrDelay:FlxTimer;
	var _tmrGame:FlxTimer;
	var _timeleft:String;
	var _txtTimer:FlxText;
	
	private var _turned:Bool = false;	
	private static inline var TURNING_TIME:Float = 0.2;
	
	
	/*
	 * Creates a background,Startbutton, Backbutton, Cadre, scoreText and Timer.
	 * adds them all except for the _sprCadre and Timer
	 * */
	override public function create():Void
	{
		super.create();
		
		_sprBackGround1 = new FlxSprite(0, 0,AssetPaths.BackgroundShop__png);
		add(_sprBackGround1);
		
		_sprCadre  = new FlxSprite(0, 100, AssetPaths.cadre1__png);
		_sprCadre.x = (FlxG.width - _sprCadre.width) / 2 ;
		_sprCadre.visible = false;
		add(_sprCadre);
		
		_startButton = new FlxButton(0, 600, null, startGame);
		_startButton.x = (FlxG.width / 2) - _startButton.width;
		_startButton.loadGraphic(AssetPaths.StartButton__png,true,220,65);
		add(_startButton);
		
		_backButton = new FlxButton(1000, 630, null, MenuState.GetInstance().clickShop);
		_backButton.loadGraphic(AssetPaths.ExitButton__png,true,220,65);
		add(_backButton);
		
		scoreText = new FlxText(0, 50, 0, null, 30);
		scoreText.x = FlxG.width - 200;
		scoreText.text = "Score: " + score;	
		
		_tmrGame = new FlxTimer().start(60, endGame, 1);	//Adjust the time to make the game easier or harder	
		_timeleft = Std.string(Math.ceil(_tmrGame.timeLeft));
		_txtTimer = new FlxText(FlxG.width / 2 - 10, 40, 0, _timeleft, 28);

				
	}
	//updates everything that is in this function each frame
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		_timeleft = Std.string(Math.ceil(_tmrGame.timeLeft));
		_txtTimer.text = _timeleft;
	}
	
	//destroys all the objects in this function
	override public function destroy():Void
	{
		super.destroy();			
	}
	
	/* when called;
	 * Destroys the startbutton, reduces Energy with 10
	 * add, scoreText and TimerText
	 * Çalls the functions, CreateDeck,shuffleDeck and Createfield
	 * */
	public function startGame():Void
	{
			

		_startButton = FlxDestroyUtil.destroy(_startButton);
		BlobState.Energy = BlobState.Energy - 10;
		add(scoreText);	
		add(_txtTimer);	
		createDeck();		
		shuffleDeck();		
		createfield();
		
		
	}
	//creates 20 cards and pushes them in a Array
	public function createDeck():Void
	{
		
		for (i in 0...20)
		{
			var newCard:Card = new Card(i);
			memoryCards.push(newCard);			
		}
	}
	//Shuffles the cards in the Array
	public function shuffleDeck():Void
	{
		var n:Int = memoryCards.length;

		for (i in 0...n)
		{
			var change:Int = Math.floor(Math.random() * (n - 1));
			var tempCard = memoryCards[i];
			memoryCards[i] = memoryCards[change];
			memoryCards[change] = tempCard;			
		}		
	}
	//Places all the cards on the field in 4 rows
	public function createfield():Void
	{
		var n:Int = memoryCards.length;		 
		for (i in 0...n)
		{
			var card = memoryCards[i];	
			
			card.x = (130 * (i % 5)) + (FlxG.width / 2) - (5 * 70);			
			card.y = 150 + (card.height + 30) * Math.floor(i / 5);				
			
			FlxMouseEventManager.add(card, clickedOnCard);
			
			add(card);	
		}
	}
	/* Function that is called when you click on a card.
	 * 
	 * clicked card is pushed in an Array and the function changeToFront is called for that card
	 * 
	 * If there are 2 cards in the array it will set check to false.
	 * If first clicked card number is the same as the second they will be removed out of the Array and Check will be set to true
	 * Else there will start a Delay timer for 1 sec that calls the function delayTimer
	 * 
	 * */
	public function clickedOnCard(card:Card)
	{		
		if (check == true) 
		{			
			clickedCards.push(card);		
			card.changeToFront();
			
			if (clickedCards.length == 2)
			{
				check = false;
				
				if (clickedCards[0].cardNumber == clickedCards[1].cardNumber)
				{
					clickedCards.remove(clickedCards[1]);
					check = true;
				}
				else
				{				
					_tmrDelay = new FlxTimer().start(1, delayTimer, 1);					
				}
			}
		}
	}
	/*Function that compare the Cards
	 * If first card number is the same as the second card the score will increased with 10 points, Plays a sound, and uses FlxTween to move them to the Left top corner
	 * Both cards are removed out of the memoryCards Array
	 * 
	 * If memoryCards lenght = 0 (means all the cards are guessed good), The games plays a sound, sets Finished to true and calls the function EndGame
	 * 
	 * Else Call functions ChangetoBack for both cards.
	 * 
	 * Set Check to true
	 * */
	public function compareCards(first:Card, second:Card):Void
	{
		var x = first.cardNumber % 10;
		var y = second.cardNumber % 10;
		
		if (x == y)
		{
			addScore(10);
			
			FlxG.sound.play(AssetPaths.memoryRight__wav, 0.7, false);
			
			FlxTween.tween(first, {x:40, y:40}, 1.5 , {ease:FlxEase.backOut});
			FlxTween.tween(second, {x:40, y:40}, 1.5, {ease:FlxEase.backOut});
								
			memoryCards.remove(first);
			memoryCards.remove(second);
			
			if (memoryCards.length == 0)//Change to 18 so you don't have to finish the whole game
			{
				FlxG.sound.play(AssetPaths.memoryEnd__wav, 1, false);
				finished = true;
				callEndGame();				
			}			
		}
		else
		{
			first.changetoBack();
			second.changetoBack();		
		}
			
		clickedCards.splice(0, clickedCards.length); // removes them out of the array so it's empty again.
		
		check = true;
		
	}
	
	//Delay timer used to have some time between the cards changing back to their back
	public function delayTimer(Time:FlxTimer):Void
	{
		compareCards(clickedCards[0], clickedCards[1]);		
	}
	//Functions that updates the score depending on addedscore when called
	public function addScore(addedscore:Int)
	{
		score += addedscore;
		updateScoreText();
	}
	//updates the scoreText when called
	public function updateScoreText() 
	{
		scoreText.text = "Score: " + score;
	}
	//Function that calls another function called callEndGame. This is because the other function can't be used since it's called from a Timer
	public function endGame(Timer:FlxTimer):Void
	{
		callEndGame();	
	}
	/*
	 * Destroys the Array + timer(text)
	 * Changes the Score to the CurrentScore + Time Left
	 * Adds coin Depending on the Time / 20
	 * 
	 * if finished = true; Add Text that you win + score + coins
	 * Else  Add text that you lost + score
	 * */
	private function callEndGame():Void
	{
		FlxMouseEventManager.removeAll();
		FlxDestroyUtil.destroyArray(memoryCards);
		FlxDestroyUtil.destroy(_tmrGame);
		FlxDestroyUtil.destroy(_txtTimer);		
		_sprCadre.visible = true;
		
		score += Math.ceil(_tmrGame.timeLeft);
		
		var earnedCoins = Math.ceil(score / 20);
		BlobState.Coins += earnedCoins;
		
		
		trace(finished);
		if (finished == true)
		{
			scoreText.text = "           Well done! \n Your Score is: " + score + "\n You earned: " + earnedCoins + "  Coins!";
		}
		else
		{
			scoreText.text = "Time is up! \n Your Score is: " + score;
		}
		scoreText.x = (FlxG.width - scoreText.width ) / 2;
		scoreText.y = (FlxG.height / 2 - 70);
	}
	
}