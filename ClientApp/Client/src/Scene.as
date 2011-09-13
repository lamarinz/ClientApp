/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 06.09.11
 * Time: 18:09
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Scene extends Sprite {
    private var _plant_example_list:Array;
    private var _plant_for_grow:PlantType;
    public var _container:Sprite;
    private var _sprite_for_move:Sprite;
    private var clicked_x:int;
    private var clicked_y:int;
    private var _first:Boolean;
    private var _field_width:int = 0;
    private var _field_height:int = 0;
    private var _i_want_to_collect : Boolean = false;
    private var _moved : Boolean = false;

    public function Scene() {
        _first = false;
        _container = new Sprite();
        this.addChild(_container);
        _container.cacheAsBitmap = true;
        var movie_clip:MovieClip = ImageCache.instance.GetImage("GardenField/BG.jpg");
        _container.addChild(movie_clip);
        this.get_available_plantType();
        this.addEventListener(MouseEvent.CLICK, _scene_on_mouse_click);
        this.addEventListener(MouseEvent.MOUSE_MOVE, _scene_on_mouse_move);
        this.addEventListener(MouseEvent.MOUSE_DOWN, _scene_on_mouse_down);
        this.addEventListener(MouseEvent.MOUSE_UP, _scene_on_mouse_up);
    }

    protected function get_available_plantType():void {
        ServerRelation.instance.get_avaliable_plants(on_plantlist_loaded);
    }

    public function on_plantlist_loaded(xml:XML):void {
       var length:int = xml.children().length();
       _plant_example_list = new Array(length);
       for (var i:int = 0; i < length; i++)
           _plant_example_list[i] = new PlantType(String(xml.Plant[i].@name));
       set_example_plant_on_bg();
       _plant_for_grow = _plant_example_list[0];
       get_state_field();
    }

    protected function set_example_plant_on_bg():void {
        var _length:int = _plant_example_list.length;
        var movie_clip:MovieClip;
        for (var i:int = 0; i < _length; i++) {
            movie_clip = ImageCache.instance.GetImage(PlantType(_plant_example_list[i]).get_image_path());
            _plant_example_list[i].addChild(movie_clip);
            _plant_example_list[i].x = 100 * i;
            _plant_example_list[i].y = 0;
            this.addChild(_plant_example_list[i]);
            _plant_example_list[i].addEventListener(MouseEvent.CLICK, on_plant_example_click)
        }
        movie_clip = ImageCache.instance.GetImage("GardenField/remover.PNG");
        var _sprite:Sprite = new Sprite();
        _sprite.addChild(movie_clip);
        _sprite.x = 300;
        _sprite.y = 0;
        this.addChild(_sprite);
        _sprite.addEventListener(MouseEvent.CLICK, on_remover_click);
        function on_remover_click(event:MouseEvent):void {
            if (_sprite_for_move != null) {
                _container.removeChild(_sprite_for_move);
                _sprite_for_move = null;
                _i_want_to_collect = false;
            }
        }
        movie_clip = ImageCache.instance.GetImage("GardenField/basket.PNG");
        _sprite = new Sprite();
        _sprite.addChild(movie_clip);
        _sprite.x = 400;
        _sprite.y = 0;
        this.addChild(_sprite);
        _sprite.addEventListener(MouseEvent.CLICK, on_collecter_click);
        function on_collecter_click(event:MouseEvent):void {
            removeSpriteForMove();
            _i_want_to_collect = true;
            event.stopPropagation();
        }
    }

    private function get_state_field():void{
        ServerRelation.instance.get_field_state(on_state_loaded);
    }

    private function on_state_loaded(xml:XML):void{
        var length:int = xml.children().length();
        for (var i:int = 0; i < length; i++){
            var point: Point = new Point(int(xml.Plant[i].@x),  int(xml.Plant[i].@y));
            for (var j:int = 0; j < _plant_example_list.length; j++)
                if (PlantType(_plant_example_list[j]).get_name() == xml.Plant[i].@name) {
                    _plant_for_grow = _plant_example_list[j];
                    break;
                }

            var plant:Plant = PlantList.instance.load_plant(xml.Plant[i].@name, point, _plant_for_grow, int(xml.Plant[i].@ID), int(xml.Plant[i].@step));
            plant.x = point.x;
            plant.y = point.y;
            plant.addEventListener(MouseEvent.CLICK, on_plant_collect);
            _container.addChild(plant);
            sort_field();
        }
    }

    private function getSpriteForMove(aName:String, x:int, y:int):Sprite {
        _sprite_for_move = new Sprite();
        var movie_clip:MovieClip;
        movie_clip = ImageCache.instance.GetImage(aName + "/" + "1.png");
        _sprite_for_move.addChildAt(movie_clip, 0);
        _sprite_for_move.alpha = 0.5;
        _sprite_for_move.x = x;
        _sprite_for_move.y = y;
        return _sprite_for_move;
    }

    private function removeSpriteForMove():void {
        if (_sprite_for_move != null) {
            _container.removeChild(_sprite_for_move);
            _sprite_for_move = null;
        }
    }

    protected function on_plant_example_click(_event:MouseEvent):void {
        removeSpriteForMove();
        _plant_for_grow = PlantType(_event.currentTarget);
        getSpriteForMove(_plant_for_grow.get_name(), _event.stageX - 40 + _container.scrollRect.x, _event.stageY - 35 + _container.scrollRect.y);
        _container.addChildAt(_sprite_for_move, _container.numChildren);
        _i_want_to_collect = false;
        _event.stopPropagation()
    }

    public function set_scroll_rectangle(_x:int, _y:int, _width:int, _height:int):void {
        _container.scrollRect = new Rectangle(_x, _y, _width, _height);
    }

    protected function equation_for_lineA(point : Point, _const:int = 345):int {
        var _lineA:int = _field_height / (_field_width + 150) * point.x - point.y + _const;
        return _lineA;
    }

    protected function equation_for_lineB(point : Point, _const:int = -465):int {
        var _lineB:int = _field_height / (_field_width + 150) * point.x + point.y + _const;
        return _lineB;
    }

    protected function check_field(point: Point):Boolean{
        if (PlantList.instance.get_by_point(point) != null)
            return false;
        else
            return true;
    }

    private function sort_field():void{
        if (_sprite_for_move != null)
            var child_count:int = _container.numChildren - 1;
        else
            var child_count:int = _container.numChildren;
        for (var i:int = 1; i < child_count; i++){
            for (var j:int = 1; j < child_count; j++){
                var plant_i:Plant = _container.getChildAt(i) as Plant;
                var plant_j:Plant = _container.getChildAt(j) as Plant;
                if (plant_i.y < plant_j.y){
                    _container.setChildIndex(plant_i, j);
                    _container.setChildIndex(plant_j, i);
                }
            }
        }
    }

    protected function _scene_on_mouse_click(event:MouseEvent):void {
        if (!_moved && _sprite_for_move != null) {
            event.stopPropagation();
            var point: Point = new Point(_sprite_for_move.x, _sprite_for_move.y);
            if (check_field(point)){
                if ((this.equation_for_lineA(point) > 0) &&
                     (this.equation_for_lineA(point, -270) < 0) &&
                       (this.equation_for_lineB(point) > 0) &&
                        (this.equation_for_lineB(point, -1075) < 0)) {
                    var plant:Plant = PlantList.instance.add_plant(_plant_for_grow.get_name(), point, _plant_for_grow);
                    plant.x = point.x;
                    plant.y = point.y;
                    plant.addEventListener(MouseEvent.CLICK, on_plant_collect);
                    _container.addChild(plant);
                    _container.setChildIndex(plant, _container.getChildIndex(_sprite_for_move));
                    _container.setChildIndex(_sprite_for_move, _container.numChildren - 1);
                    sort_field();
                    ServerRelation.instance.grow_plant(plant);
                }
                else{
                    _sprite_for_move.visible = false;
                }
            }
        }
    }

    private function on_plant_collect(event:MouseEvent):void{
        event.stopPropagation();
        var clicked_plant: Plant = event.currentTarget as Plant;
        if (_i_want_to_collect){
            if (clicked_plant.get_growStep() == 5){
                PlantList.instance.remove_by_id(clicked_plant.id);
                _container.removeChild(clicked_plant);
                ServerRelation.instance.plant_collect(clicked_plant.id);
            }
        }
    }

    protected function to_i_j(x: int, y: int):Point {
        var new_x : int = (x - 120)/50;
        var new_y : int = (y - 435)/25;

        var i : int = (new_x + new_y)/2;
        var j : int = (new_x - new_y)/2;

        return new Point(i, j);
    }

    protected function to_x_y(point: Point):Point {
        var new_x:int = 120 + 50 * (point.x + point.y);
        var new_y:int = 435 + 25 * (point.x - point.y);
        return new Point(new_x, new_y);
    }

    protected function _scene_on_mouse_move(event:MouseEvent):void {
        if (!_first) {
            _field_width = _container.getChildAt(0).width;
            _field_height = _container.getChildAt(0).height;
        }
        if (_sprite_for_move != null) {
            var new_x:int = event.stageX - 50 + _container.scrollRect.x;
            var new_y:int = event.stageY - 25 + _container.scrollRect.y;
            var point:Point = to_i_j(new_x, new_y);
            var new_point:Point = to_x_y(point);

            if ((this.equation_for_lineA(new_point) > 0) &&
                 (this.equation_for_lineA(new_point, -270) < 0) &&
                   (this.equation_for_lineB(new_point) > 0) &&
                    (this.equation_for_lineB(new_point, -1075) < 0)) {
                _sprite_for_move.visible = true;
            }
            else
            {
                _sprite_for_move.visible = false;
            }
            _sprite_for_move.x = new_point.x;
            _sprite_for_move.y = new_point.y;
        }
        if (event.buttonDown) {
            new_x = (event.stageX + _container.scrollRect.x - clicked_x) * (-1);
            new_y = (event.stageY + _container.scrollRect.y - clicked_y) * (-1);
            var _rect:Rectangle = _container.scrollRect;
            if ((_rect.x + new_x >= 0) && (_rect.x + new_x <= _field_width - _rect.width))
                _rect.x += new_x;
            if ((_rect.y + new_y >= 0) && (_rect.y + new_y <= _field_height - _rect.height))
                _rect.y += new_y;
            _container.scrollRect = _rect;
            if (_sprite_for_move != null){
                _sprite_for_move.x += new_x;
                _sprite_for_move.y += new_y;
            }
            _moved = true;
        }
    }

    protected function _scene_on_mouse_down(event:MouseEvent):void {
        event.stopPropagation();
        clicked_x = event.stageX + _container.scrollRect.x;
        clicked_y = event.stageY + _container.scrollRect.y;
    }

    protected function _scene_on_mouse_up(event:MouseEvent):void{
        _moved = false;
    }
}
}
