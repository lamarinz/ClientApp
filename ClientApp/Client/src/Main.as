/**
 * Created by IntelliJ IDEA.
 * User: lamarin
 * Date: 04.09.11
 * Time: 22:21
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.system.Security;

public class Main extends Sprite {
    protected var _container:Sprite = new Sprite();
    protected var _scene:Scene;

    public function Main() {
        Security.allowDomain("*");
        Security.LOCAL_TRUSTED;
        stage.displayState = StageDisplayState.NORMAL;
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        _scene = new Scene();
        this.addChild(_container);
        _container.addChild(_scene);

        stage.addEventListener(Event.RESIZE, on_stage_resize);
        stage.addEventListener(Event.ACTIVATE, on_stage_activate);
    }

    protected function on_stage_resize(e:Event):void {
        _scene.set_scroll_rectangle(0, 0, stage.stageWidth, stage.stageHeight);
    }

    protected function on_stage_activate(e:Event):void {
        _scene.set_scroll_rectangle(0, 0, stage.stageWidth, stage.stageHeight);
    }
}
}
