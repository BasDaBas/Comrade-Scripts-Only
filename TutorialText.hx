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
 * This function is used for the DataBase to give the text a x, y position, textwidth, format and borderStyle
 */
class TutorialText extends FlxState
{
	public var _text:FlxTypeText = new FlxTypeText(0, 0, 0, "", 20, true);	
	
	public function new(xPos:Int, yPos:Int, textWidth:Int) 
	{
		super();		
		
		_text.x = xPos;
		_text.y = yPos;
		_text.fieldWidth = textWidth;
		_text.setFormat(AssetPaths.ponde_____ttf, 20, FlxColor.WHITE, FlxTextAlign.CENTER);
		_text.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);		
		add(_text);	
	}	

	
}