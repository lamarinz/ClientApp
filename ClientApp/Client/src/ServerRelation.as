/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 12.09.11
 * Time: 0:30
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

import mx.messaging.config.ServerConfig;

public class ServerRelation {
    private const _srv_url: String = "http://localhost:3000/garden/";
    private static var _instance: ServerRelation = new ServerRelation();

    public function ServerRelation() {
    }

    public static function get instance():ServerRelation{
        return _instance;
    }

    public function get_avaliable_plants(anObr : Function): void{
        var url_request:URLRequest = new URLRequest(_srv_url + "get_plants_list");
        var url_loader:URLLoader = new URLLoader();
        url_loader.load(url_request);
        url_loader.addEventListener(Event.COMPLETE, on_plantlist_loaded);
        function on_plantlist_loaded(event:Event):void {
            var xml:XML = new XML(event.target.data);
            anObr(xml);
        }
    }
    public function get_field_state(anObr : Function): void{
        var url_request:URLRequest = new URLRequest(_srv_url + "get_garden_state");
        var url_loader:URLLoader = new URLLoader();
        url_loader.load(url_request);
        url_loader.addEventListener(Event.COMPLETE, on_xml_state_loaded);
        function on_xml_state_loaded(event:Event):void {
            var xml:XML = new XML(event.target.data);
            anObr(xml);
        }
    }
    public function grow_plant(plant:Plant):void{
        var request:URLRequest=new URLRequest(_srv_url + "plant_add");

        request.method = URLRequestMethod.POST;

        var vars:URLVariables = new URLVariables();
        vars['id']   = String(plant.id);
        vars['name'] = plant.plantname;
        vars['step'] = String(plant.get_growStep());
        vars['x']    = String(plant.x);
        vars['y']    = String(plant.y);
        request.data=vars;

        var loader:URLLoader = new URLLoader();
        loader.load(request);
        loader.addEventListener(Event.COMPLETE, onComplete);

        function onComplete(event:Event):void {
        }
    }

    public function plant_update(id:int, nex_tstep:int,  y:int):void{
        var request:URLRequest=new URLRequest(_srv_url + "plant_growup");
        request.method = URLRequestMethod.POST;

        var vars:URLVariables = new URLVariables();
        vars['id']   = String(id);
        vars['step'] = String(nex_tstep);
        vars['y'] = String(y);

        request.data=vars;

        var loader:URLLoader = new URLLoader();
        loader.load(request);
        loader.addEventListener(Event.COMPLETE, onComplete);
        function onComplete(event:Event):void {
        }
    }

    public function plant_collect(id:int):void{
        var request:URLRequest=new URLRequest(_srv_url + "plant_collect?id=" + String(id));
        var loader:URLLoader = new URLLoader();
        loader.load(request);
        loader.addEventListener(Event.COMPLETE, onComplete);
        function onComplete(event:Event):void {
        }
    }
}
}
