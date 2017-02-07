package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;


enum GameState {
	Paused;
	Playing;
}

class Main extends Sprite {


	var inited:Bool;
	private var harvester:Harvester;
	private var loadFon:LoadFon;
	private var currentGameState:GameState;
	private var scorePlayer:Int;
	private var scoreField:TextField;
	private var messageField:TextField;
	private var arrowKeyUp:Bool;
	private var arrowKeyDown:Bool;
	private var harvesterSpeed:Int;
	function init()
	{
		if (inited) return;
		inited = true;
		arrowKeyUp = false;
		arrowKeyDown = false;
		harvesterSpeed = 7;


		var scoreFormat:TextFormat = new TextFormat("Verdana", 24, 0xbbbbbb, true);
		scoreFormat.align = TextFormatAlign.CENTER;

		scoreField = new TextField();
		addChild(scoreField);
		scoreField.width = 500;
		scoreField.y = 30;
		scoreField.defaultTextFormat = scoreFormat;
		scoreField.selectable = false;

		var messageFormat:TextFormat = new TextFormat("Verdana", 18, 0xbbbbbb, true);
		messageFormat.align = TextFormatAlign.CENTER;

		messageField = new TextField();
		addChild(messageField);
		messageField.width = 500;
		messageField.y = 450;
		messageField.defaultTextFormat = messageFormat;
		messageField.selectable = false;
		messageField.text = "Press SPACE to start";

		scorePlayer = 0;


		loadFon = new LoadFon();
		addChild(loadFon);
		harvester = new Harvester();
		addChild(harvester);

		setGameState(Paused);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		this.addEventListener(Event.ENTER_FRAME, everyFrame);
	}
	private function keyDown(event:KeyboardEvent):Void {
		if (currentGameState == Paused && event.keyCode == 32) { // Space
			setGameState(Playing);
		}else if (event.keyCode == 38) { // Up
			arrowKeyUp = true;
		}else if (event.keyCode == 40) { // Down
			arrowKeyDown = true;
		}
	}
	private function keyUp(event:KeyboardEvent):Void {
		if (event.keyCode == 38) { // Up
			arrowKeyUp = false;
		}else if (event.keyCode == 40) { // Down
			arrowKeyDown = false;
		}
	}

	private function setGameState(state:GameState):Void {
		currentGameState = state;
		updateScore();
		if (state == Paused) {
			messageField.alpha = 1;
		}else {
			messageField.alpha = 0;
			harvester.y = 200;
			harvester.y = 200;
		}
	}
	}


	private function everyFrame(event:Event):Void {
		if(currentGameState == Playing){
			if (arrowKeyUp) {
             harvester.y -= harvesterSpeed;
			}
			if (arrowKeyDown) {
             harvester.y += harvesterSpeed;
			}
			if (harvester.y < 5) harvester.y = 5;
			if (harvester.y > 395) harvester.y = 395;
		}
	}



    private function updateScore():Void {
         scoreField.text = scorePlayer+"\n";
    }


/* SETUP */
public function new()
{
super();
addEventListener(Event.ADDED_TO_STAGE, added);
}

function added(e)
{
removeEventListener(Event.ADDED_TO_STAGE, added);
stage.addEventListener(Event.RESIZE, resize);
	#if ios
haxe.Timer.delay(init, 100); // iOS 6
	#else
init();
	#end
}



	public function new () {

		super ();
		init();
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.addChild(new Main());



	}


}