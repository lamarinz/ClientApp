/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 08.09.11
 * Time: 19:39
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.geom.Point;
import flash.utils.Dictionary;

public class PlantList {
    protected var _id_counter:int = -1;
    private var _plant_list: Dictionary = new Dictionary();
    private static var _instance:PlantList = new PlantList();

    public function PlantList() {
    }

    public static function get instance():PlantList {
        return _instance;
    }

    public function remove_by_id(id: int):void{
        _plant_list[id] = null;
    }

    public function get_by_point(point: Point):Plant{
        if (_id_counter >= 0){
            for (var i:int = 0; i <= _id_counter; i++){
                var plant : Plant = _plant_list[i] as Plant;
                if ((plant != null) && (plant.fieldX == point.x) && (plant.fieldY == point.y)){
                    return plant;
                }
            }
        }
        return null;
    }

    public function load_plant(name:String, point:Point, plant_type:PlantType, id:int, grow_step:int):Plant{
        var plant:Plant = new Plant(_id_counter, name, plant_type, true);
        plant.x   = point.x;
        plant.y   = point.y;
        plant.set_growStep(grow_step);
        _id_counter = id;
        plant.id = id;
        if (plant.get_growStep() < 5)
            plant.timer_start();
        plant.get_image();
        _plant_list[_id_counter] = plant;
        return plant;
    }

    public function add_plant(name:String, point:Point, plant_type:PlantType):Plant {
        _id_counter += 1;
        var plant:Plant = new Plant(_id_counter, name, plant_type);
        plant.fieldX = point.x;
        plant.fieldY = point.y;
        plant.set_growStep(1);
        plant.get_image();
        _plant_list[_id_counter] = plant;
        return plant;
    }

}
}
