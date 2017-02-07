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

	function init()
	{
		if (inited) return;
		inited = true;
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
	}
	private function keyDown(event:KeyboardEvent):Void {
		if (currentGameState == Paused && event.keyCode == 32) {
			setGameState(Playing);
		}
	}
	private function updateScore():Void {
		scoreField.text = scorePlayer+"\n";
	}

	private function setGameState(state:GameState):Void {
		currentGameState = state;
		updateScore();
		if (state == Paused) {
			messageField.alpha = 1;
		}else {
			messageField.alpha = 0;
		}
	}


	public function new () {

		super ();
		init();




	}


}