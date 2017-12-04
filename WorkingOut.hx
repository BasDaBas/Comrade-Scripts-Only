package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.Anchor;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISprite;
import flixel.addons.ui.interfaces.IFlxUIButton;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.addons.ui.FlxUITooltip;
import flixel.addons.ui.FlxUITooltipManager;




/**
 * ...
 * @author Sherwan van der Linden
 */
class WorkingOut extends FlxState
{
	private var _sprBackGround1:FlxSprite;
	private var _btnBack:FlxButton;
	public var _btnYoga:FlxButton;
	public var _btnCardio:FlxButton;	
	public var textEnergy:FlxText;
	
	
	
	public function new()
	{
		super();
	}

	override public function create():Void 
	{
		//setup the background		
		_sprBackGround1 = new FlxSprite(0, 0,AssetPaths.FitnessBackground__png);
		add(_sprBackGround1);	
		//adds HUD
		var _hud:HUD = new HUD();	
		add(_hud);		
		
		
		_btnYoga = new FlxButton(300,300, "",yoga);
		_btnYoga.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnYoga.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnYoga.label = new FlxText(0, 0, 0, "Yoga");
		_btnYoga.label.setFormat(null, 20, 0x4f3510, "center");
		_btnYoga.scale.y = 3;
		_btnYoga.scale.x = 3;
		add(_btnYoga);
		
		_btnCardio = new FlxButton(700,300, "",cardio);
		_btnCardio.onOver.sound = FlxG.sound.load(AssetPaths.hoverBut__wav);
		_btnCardio.onUp.sound = FlxG.sound.load(AssetPaths.clickBut__wav);
		_btnCardio.label = new FlxText(0, 0, 0, "Cardio");
		_btnCardio.label.setFormat(null, 20, 0x4f3510, "center");
		_btnCardio.scale.y = 3;
		_btnCardio.scale.x = 3;
		add(_btnCardio);		
		
	}
	/*
	 * Reduces or increase Stats when this function is called. 
	 * Adds Text to show which stats are increased or reduced using a FlxTween that lifts the text up and slowly fades away	
	 * */
	private function cardio():Void
	{
		
		_sprBackGround1.loadGraphic(AssetPaths.FitnessBackground__png);
		BlobState.Energy = BlobState.Energy - 15;
		BlobState.Hunger = BlobState.Hunger -10;
		BlobState.Health = BlobState.Health + 20;
		BlobState.Stress = BlobState.Stress - 5;
		
		
		textEnergy = new FlxText(_btnCardio.x, _btnCardio.y - 130, 0, "Energy - 15 \n Hunger - 10 \n Health + 20 \n Stress - 5 ", 16);
		add(textEnergy);		
		FlxTween.tween(textEnergy, {x: _btnCardio.x , y:_btnCardio.y - 180}, 2.0, {ease:FlxEase.backOut, onComplete:finishKill});
		
		
		
	}
	/*
	 * Reduces or increase Stats when this function is called. 
	 * Adds Text to show which stats are increased or reduced using a FlxTween that lifts the text up and slowly fades away	
	 * */
	private function yoga():Void
	{
		_sprBackGround1.loadGraphic(AssetPaths.gymBackground__png);

		BlobState.Energy = BlobState.Energy - 20;
		BlobState.Hunger = BlobState.Hunger - 10;
		BlobState.Health = BlobState.Health + 30;
		BlobState.Stress = BlobState.Stress - 5;
		
		textEnergy = new FlxText(_btnYoga.x, _btnYoga.y - 130, 0, "Energy - 15 \n Hunger - 10 \n Health + 20 \n Stress - 5 ", 16);
		add(textEnergy);		
		FlxTween.tween(textEnergy, {x: _btnYoga.x , y:_btnYoga.y - 180}, 2.5, {ease:FlxEase.backOut, onComplete:finishKill});
		
		
	}
	// Function that destroys the text when called
	private function finishKill(_):Void
	{
		textEnergy = FlxDestroyUtil.destroy(textEnergy);
	}

	
	
	
}