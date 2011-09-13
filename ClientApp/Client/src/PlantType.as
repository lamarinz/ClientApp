/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 05.09.11
 * Time: 20:30
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.utils.Dictionary;

public class PlantType extends Sprite {
    private var _name:String;
    private var _image_path:String;
    private var _height_delta:Dictionary;

    public function PlantType(aName:String) {
        _name = aName;
        _image_path = _name + "/5.png";
        init_dict();
    }

    public function get_height_delta(name_grow_step:String):int{
        return _height_delta[name_grow_step];
    }

    public function set_height_delta(grow_step:int, value:int):void{
        _height_delta[grow_step] = value;
    }

    public function get_name():String {
        return _name;
    }

    public function get_image_path():String {
        return _image_path;
    }

    private function init_dict():void{
        _height_delta = new Dictionary();
        _height_delta["Potato1"] = 0;
        _height_delta["Potato2"] = 0;
        _height_delta["Potato3"] = 16;
        _height_delta["Potato4"] = 2;
        _height_delta["Potato5"] = 5;
        _height_delta["Sunflower1"] = 0;
        _height_delta["Sunflower2"] = 18;
        _height_delta["Sunflower3"] = 14;
        _height_delta["Sunflower4"] = 24;
        _height_delta["Sunflower5"] = 17;
        _height_delta["Clover1"] = 100;
        _height_delta["Clover2"] = -46;
        _height_delta["Clover3"] = 5;
        _height_delta["Clover4"] = 13;
        _height_delta["Clover5"] = 0;
    }
}
}
