package;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Assets;
class LoadFon extends Sprite
{

    public function new()
    {
        super();
        var bitmapData = Assets.getBitmapData ("assets/img/fon.png");
        var bitmap = new Bitmap (bitmapData);
        addChild (bitmap);


    }

}