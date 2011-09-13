/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 04.09.11
 * Time: 11:58
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.utils.Dictionary;

import mx.controls.Alert;

import mx.controls.Image;

public class Cach
{
    public function Cach()
    {
    }

    private static var _instance : Cach = new Cach();
    private var _ImageCach : Dictionary = new Dictionary;

    public static function get instance():Cach
    {
        return _instance;
    }

    public function GetImage(aURL:String): Image
    {
        var vImageURL: String = "/home/lamarin/IdeaProjects/GardenClient/src/" + aURL;
        // для отладки -------------------------------------------------------------------------------------------------
//        Alert.show(vImageURL);
        // для отладки -------------------------------------------------------------------------------------------------
        if (_ImageCach[vImageURL] == null)
        {
            var vImage:Image = new Image();

            vImage.load(vImageURL);
            _ImageCach[vImageURL] = vImage;

            return Image(vImage);
        }
        else
        {
            return Image(_ImageCach[vImageURL]);
        }
    }

}
}
