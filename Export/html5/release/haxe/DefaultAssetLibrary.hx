package;


import haxe.Resource;
import haxe.Timer;
import haxe.Unserializer;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.AssetType;
import lime.utils.Bytes;
import lime.utils.Log;

#if sys
import haxe.io.Path;
import sys.FileSystem;
#end


@:keep @:dox(hide) class DefaultAssetLibrary extends AssetLibrary {
	
	
	private var lastModified:Float;
	private var rootPath:String;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		if (ApplicationMain.config != null && Reflect.hasField (ApplicationMain.config, "assetsPrefix")) {
			
			rootPath = Reflect.field (ApplicationMain.config, "assetsPrefix");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos)
			rootPath = "assets/";
			#elseif (windows && !cs)
			rootPath = FileSystem.absolutePath (Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		#if (openfl && !flash && !display)
		
		#end
		
		var useManifest = #if html5 true #else false #end;
		var id;
		id = "assets/psd/harvester_right.psd";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_psd_harvester_right_psd);
		types.set (id, AssetType.BINARY);
		#end
		id = "assets/psd/harvester_down.psd";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_psd_harvester_down_psd);
		types.set (id, AssetType.BINARY);
		#end
		id = "assets/psd/earth.psd";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_psd_earth_psd);
		types.set (id, AssetType.BINARY);
		#end
		id = "assets/psd/harvester_up.psd";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_psd_harvester_up_psd);
		types.set (id, AssetType.BINARY);
		#end
		id = "assets/psd/harvester_left.psd";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_psd_harvester_left_psd);
		types.set (id, AssetType.BINARY);
		#end
		id = "assets/img/harvester_right.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_harvester_right_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/earth.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_earth_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/harvester_up.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_harvester_up_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/fon.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_fon_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/harvester1.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_harvester1_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/harvester_down.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_harvester_down_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/harvester_left.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_harvester_left_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/nod_harvester__ingame_183.png";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_nod_harvester__ingame_183_png);
		types.set (id, AssetType.IMAGE);
		#end
		id = "assets/img/start.jpg";
		#if html5
		preload.set (id, true);
		#elseif (desktop || cpp || flash)
		classTypes.set (id, __ASSET__assets_img_start_jpg);
		types.set (id, AssetType.IMAGE);
		#end
		
		
		if (useManifest) {
			
			loadManifest ();
			
			#if sys
			if (false && Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath (rootPath + "manifest");
				
				if (FileSystem.exists (path)) {
					
					lastModified = FileSystem.stat (path).mtime.getTime ();
					
					timer = new Timer (2000);
					timer.run = function () {
						
						var modified = FileSystem.stat (path).mtime.getTime ();
						
						if (modified > lastModified) {
							
							lastModified = modified;
							loadManifest ();
							
							onChange.dispatch ();
							
						}
						
					}
					
				}
				
			}
			#end
			
		}
		
	}
	
	
	private function loadManifest ():Void {
		
		var bytes = Resource.getBytes ("__ASSET_MANIFEST__");
		var manifest;
		
		if (bytes != null) {
			
			var manifest = AssetManifest.fromBytes (bytes);
			manifest.basePath = rootPath;
			__fromManifest (manifest);
			
		} else {
			
			// TODO: Make asynchronous
			
			var manifest = AssetManifest.fromFile (rootPath + "manifest");
			
			if (manifest != null) {
				
				manifest.basePath = rootPath;
				__fromManifest (manifest);
				
			} else {
				
				Log.warn ("Could not load asset manifest (bytes was null)");
				
			}
			
			//AssetManifest.loadFromFile (rootPath + "manifest").onComplete (function (manifest:AssetManifest) {
				//
				//if (manifest != null) {
					//
					//__fromManifest (manifest);
					//
				//} else {
					//
					//Log.warn ("Could not load asset manifest (bytes was null)");
					//
				//}
				//
				//__fromManifest (manifest);
				//
			//}).onError (function (e:Dynamic) {
				//
				//Log.warn ('Could not load asset manifest (${e})');
				//
			//});
			
		}
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_psd_harvester_right_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_psd_harvester_down_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_psd_earth_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_psd_harvester_up_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_psd_harvester_left_psd extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_img_harvester_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_earth_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_harvester_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_fon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_harvester1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_harvester_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_harvester_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_nod_harvester__ingame_183_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_img_start_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif (desktop || cpp)

@:file("Assets/psd/harvester_right.psd") #if display private #end class __ASSET__assets_psd_harvester_right_psd extends haxe.io.Bytes {}@:file("Assets/psd/harvester_down.psd") #if display private #end class __ASSET__assets_psd_harvester_down_psd extends haxe.io.Bytes {}@:file("Assets/psd/earth.psd") #if display private #end class __ASSET__assets_psd_earth_psd extends haxe.io.Bytes {}@:file("Assets/psd/harvester_up.psd") #if display private #end class __ASSET__assets_psd_harvester_up_psd extends haxe.io.Bytes {}@:file("Assets/psd/harvester_left.psd") #if display private #end class __ASSET__assets_psd_harvester_left_psd extends haxe.io.Bytes {}@:image("Assets/img/harvester_right.png") #if display private #end class __ASSET__assets_img_harvester_right_png extends lime.graphics.Image {}
@:image("Assets/img/earth.png") #if display private #end class __ASSET__assets_img_earth_png extends lime.graphics.Image {}
@:image("Assets/img/harvester_up.png") #if display private #end class __ASSET__assets_img_harvester_up_png extends lime.graphics.Image {}
@:image("Assets/img/fon.png") #if display private #end class __ASSET__assets_img_fon_png extends lime.graphics.Image {}
@:image("Assets/img/harvester1.png") #if display private #end class __ASSET__assets_img_harvester1_png extends lime.graphics.Image {}
@:image("Assets/img/harvester_down.png") #if display private #end class __ASSET__assets_img_harvester_down_png extends lime.graphics.Image {}
@:image("Assets/img/harvester_left.png") #if display private #end class __ASSET__assets_img_harvester_left_png extends lime.graphics.Image {}
@:image("Assets/img/nod_harvester__ingame_183.png") #if display private #end class __ASSET__assets_img_nod_harvester__ingame_183_png extends lime.graphics.Image {}
@:image("Assets/img/start.jpg") #if display private #end class __ASSET__assets_img_start_jpg extends lime.graphics.Image {}




#else



#end

#if (openfl && !flash)



#end
#end