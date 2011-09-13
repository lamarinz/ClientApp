
package {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

import mx.controls.Alert;
import mx.controls.Image;
import mx.core.LayoutContainer;


public class MainClass extends LayoutContainer
  {
    public var _bgimage : LayoutContainer = new LayoutContainer();

    // запоминаем координаты, где произошел Click
    var _clicked_X : Number;
    var _сlicked_Y : Number;
    // адо помнить зажата кнопка мыши или нет изначально кнопка не зажата
    var _сlicked : Boolean = false;
    var _container : Sprite = new Sprite();

    // обработка нажатия левой кнопки мыши на бекграунде
    protected function on_mouse_down(e:MouseEvent) : void
    {
        if (e.buttonDown)
        {
            _сlicked   = true;
            _clicked_X  = e.localX;
            _сlicked_Y = e.localY;
        }
    }
    // перемещаем
    protected function BackGround_Move(x: Number, y: Number): void
    {
        this.horizontalScrollPosition += x;
        this.verticalScrollPosition += y;
    }
    public function on_mouse_move(e:MouseEvent) : void
    {
        const Speed: Number = 10;
        var newX: Number = ((e.localX - _clicked_X)/Speed)*(-1);
        var newY: Number = ((e.localY - _сlicked_Y)/Speed)*(-1);
        if (e.buttonDown && _сlicked)
            BackGround_Move(newX, newY);
    }
    protected function on_mouse_up(e:MouseEvent) : void
    {
        this._сlicked = false;
    }

/*    protected function on_mouse_click(e:MouseEvent)
    {
        var _x : int = e.localX;
        var _y : int = e.localY;
        var vImageURL: String = "/home/lamarin/IdeaProjects/GardenClient/src/Potato.png";
        var image : Image = new Image();
        image.load(vImageURL);
        image.x = _x;
        image.y = _y;
        Alert.show("asdf");
        _Image.addChild(image);

    }
  */
    protected function setApplicationSize()
    {
        this.width = 600;
        this.height = 600;
        this.horizontalScrollPolicy = "off";
        this.verticalScrollPolicy = "off";
    }

    public function MainClass()
    {
        super();
        this._addListeners();
        this.setApplicationSize();
        // кладем изображение бекграунда

        this.addChild(_bgimage);

        var vImageURL: String = "/home/lamarin/IdeaProjects/GardenClient/src/BG.jpg";
        var image : Image = new Image();
        image.load(vImageURL);
        _bgimage.addChild(image);

    }

    // добавляем слушателей для бекграунда
    protected function _addListeners() : void
    {
    //    _bgimage.addEventListener(MouseEvent.CLICK, on_mouse_click);
        _bgimage.addEventListener(MouseEvent.MOUSE_DOWN, on_mouse_down);
        _bgimage.addEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);
        _bgimage.addEventListener(MouseEvent.MOUSE_UP, on_mouse_up);
    }
    // убираем слушателей для бекграунда
    protected function _removeListeners() : void
    {
        _bgimage.removeEventListener(MouseEvent.MOUSE_DOWN, on_mouse_down);
        _bgimage.removeEventListener(MouseEvent.MOUSE_MOVE, on_mouse_move);
        _bgimage.removeEventListener(MouseEvent.MOUSE_UP, on_mouse_up);
    }


  }
}