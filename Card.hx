package;

import flixel.FlxSprite;
import flixel.addons.display.FlxExtendedSprite;
import flixel.input.mouse.FlxMouseEventManager;

/**
 * ...
 * @author Bas
 */
class Card extends FlxSprite
{
	public var cardNumber:Int;	

	public function new(number:Int) 
	{
		super(0, 0, AssetPaths.cardBack__png);		
		
		cardNumber = number;			
		
	}
	//changes the image of the card to the back if called
	public function changetoBack()
	{
		this.loadGraphic(AssetPaths.cardBack__png);
	}
	//changes the image of the card to the front if called
	public function changeToFront()
	{
		
		this.loadGraphic("assets/images/cards/card" + (cardNumber % 10 + 1) + ".png");
	}
	
	
		
}