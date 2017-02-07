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
class Main extends Sprite {

	var inited:Bool;
	private var harvester:Harvester;
	private var loadFon:LoadFon;

	function init()
	{
		if (inited) return;
		inited = true;

		loadFon = new LoadFon();
		addChild(loadFon);
		harvester = new Harvester();
		addChild(harvester);

	}

	public function new () {

		super ();
		init();


		/*
		var bitmapData = Assets.getBitmapData ("assets/img/harvester_up.png");
		var bitmap = new Bitmap (bitmapData);
		addChild (bitmap);

		bitmap.x = 100;
		bitmap.y = 200;
         */

	}


}