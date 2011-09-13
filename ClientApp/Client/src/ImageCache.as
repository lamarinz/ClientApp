/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 08.09.11
 * Time: 18:08
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import flash.utils.Dictionary;

public class ImageCache {

    private static var _instance:ImageCache = new ImageCache();
    private var _imageCache:Dictionary = new Dictionary();

    public function ImageCache() {
    }

    public static function get instance():ImageCache {
        return _instance;
    }

    protected function get_from_loader(loader: Loader) : Bitmap{
        var bitmap:Bitmap = (loader.content as Bitmap);
        var new_bitmap:Bitmap = new Bitmap(bitmap.bitmapData);
        return new_bitmap;
    }

    public function GetImage(anImageURL:String):MovieClip {
        var movie_clip:MovieClip = new MovieClip();
        var vImageURL:String = "http://localhost:3000/images/" + anImageURL;
        var loader:Loader = _imageCache[vImageURL] as Loader;
        if (loader == null) {
            loader = new Loader();
            var url_request:URLRequest = new URLRequest(vImageURL);
            loader.load(url_request);
            _imageCache[vImageURL] = loader;
        }

        if (loader.content == null) {
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_load_complete);
            function on_load_complete(_event:Event):void {
                movie_clip.addChild(get_from_loader(loader));
            }
        } else {
            movie_clip.addChild(get_from_loader(loader));
        }
        return movie_clip;
    }
}
}
