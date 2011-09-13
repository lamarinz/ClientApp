/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 08.09.11
 * Time: 19:36
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class Plant extends Sprite {
    private var _id:int;
    private var _name:String;
    private var _x:int;
    private var _y:int;
    private var _growStep:int;
    private var _timer:Timer = new Timer(10000, 5);
    private var _plant_type:PlantType;

    public function Plant(id:int, name:String, plant_type:PlantType, loaded:Boolean = false) {
        _id = id;
        _name = name;
        _plant_type = plant_type;
        _timer.addEventListener(TimerEvent.TIMER, on_timer_tick);
        if (!loaded){
            _timer.addEventListener(TimerEvent.TIMER, on_timer_tick);
            _timer.start();
        }
    }

    public function timer_start():void{
        _timer.start();
    }

    public function get id():int {
        return this._id;
    }
    public function set id(value:int):void{
        _id = value;
    }

    public function get plantname():String {
        return this._name;
    }

    public function get fieldX():int {
        return this._x;
    }

    public function set fieldX(value:int):void {
        this._x = value;
    }

    public function get fieldY():int {
        return this._y;
    }

    public function set fieldY(value:int):void {
        this._y = value;
    }

    public function get_growStep():int {
        return this._growStep;
    }

    public function set_growStep(value:int):void {
        if (value > 5)
            this._growStep = 5;
        else
            this._growStep = value;
    }

    public function get_image():void {
        var movie_clip:MovieClip = ImageCache.instance.GetImage(this._name + "/" + String(this._growStep) + ".png");
        this.y -= _plant_type.get_height_delta(_name + String(_growStep));
        this.addChild(movie_clip);
        ServerRelation.instance.plant_update(this._id, this._growStep, this.y);
    }

    protected function on_timer_tick(event:TimerEvent):void {
        this._growStep += 1;
        if (_growStep > 5) {
            _timer.stop();
            _timer = null;
            _growStep -= 1;
            return;
        }
        this.removeChildAt(0);
        this.get_image();
    }
}
}
