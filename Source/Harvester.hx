package;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
class Harvester extends Sprite
{

    public function new()
    {
        super();
        var bitmapData = Assets.getBitmapData ("assets/img/harvester_up.png");
        var bitmap = new Bitmap (bitmapData);
        addChild (bitmap);

        bitmap.x = 170;
        bitmap.y = 50;
    }

}