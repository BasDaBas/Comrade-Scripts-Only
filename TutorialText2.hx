package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxColor;
import flash.display.Sprite;

/**
 * ...
 * @author Bas
 * 
 * This function is used for the DataBase to give the Answers a x, y position, textwidth, format and borderStyle
 */
class TutorialText2 extends FlxState
{
	
	public var answer1:FlxText = new FlxText(0, 0, 0, null, 20);
	public var answer2:FlxText = new FlxText(0, 0, 0, null, 20);
	public var answer3:FlxText = new FlxText(0, 0, 0, null, 20);
	
	public var answerArray:Array<FlxText> = new Array();
	
	public function new(xPos:Int, yPos:Int, textWidth:Int) 
	{
		super();	
		
		answerArray.push(answer1);
		answerArray.push(answer2);
		answerArray.push(answer3);
		//give the answers a Mouse Event 
		FlxMouseEventManager.add(answer1, BarState.GetInstance().CheckAnswer1);
		FlxMouseEventManager.add(answer2, BarState.GetInstance().CheckAnswer2);
		FlxMouseEventManager.add(answer3, BarState.GetInstance().CheckAnswer3);
		showAnswers();
		
		
	}	
	/**
	 * creates the answers and adds them underneath eacht other.
	 */
	function showAnswers()
	{
		for (i in 0 ... 3)
		{
			var answerTextFields:FlxText = answerArray[i];
			answerTextFields.alignment = FlxTextAlign.CENTER;
			answerTextFields.x = 100;
			answerTextFields.y = 350 + i * 70;
			answerTextFields.width = 200;
			add(answerTextFields);
			
		}
	}
	
}