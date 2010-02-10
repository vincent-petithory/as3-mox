package 
{
    
    import flash.events.MouseEvent;
    import flash.display.Sprite;
    
    import mox.ui.*;
    
    
    /**
     * This sample moves the styles of a circle to another and applies it.
     */
    public class SimpleDragInfoSample extends Sprite
    {
        private var f:uint = 0xA4F020;
        private var l:uint = 0x6EA115;
        private var circle:Sprite;
        private var rects:Vector.<TangoRect>;
    
        public function SimpleDragInfoSample()
        {
            super();
            var background:Sprite = new Sprite();
            background.graphics.beginFill(0xfefefe);
            background.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
            background.graphics.endFill();
            this.addChild(background);
            
            rects = new Vector.<TangoRect>();
            var n:int = 10;
            var x:int = 0;
            while (--n>-1)
            {
                var rect:TangoRect = new TangoRect(0xffffff*Math.random());
                rects.push(rect);
                rect.x = x;
                x += rect.width+1;
                addChild(rect);
                rect.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            }
            
            circle = new Sprite();
            circle.graphics.lineStyle(1,0x000000);
            circle.graphics.beginFill(0x000000);
            circle.graphics.drawCircle(0,0,50);
            circle.graphics.endFill();
            circle.addEventListener(DragEvent.FLASH_DRAG_ENTER, onDragEnter);
            circle.addEventListener(DragEvent.FLASH_DRAG_DROP, onDragDrop);
            circle.name = "circle";
            
            addChild(circle);
            circle.x = 250;
            circle.y = 150;
            
            var foreground:Sprite = new Sprite();
            foreground.graphics.beginFill(0xaeaeae);
            foreground.graphics.drawRect(100,150,300,300);
            foreground.graphics.endFill();
            this.addChild(foreground);
            var foreground2:Sprite = new Sprite();
            foreground2.graphics.beginFill(0x444444);
            foreground2.graphics.drawRect(100,150,250,100);
            foreground2.graphics.endFill();
            foreground.addChild(foreground2);
        }
        
        private function onDragDrop(event:DragEvent):void
        {
            if (event.dropAction != DragActions.COPY)
            {
                return;
            }
            var style:Object = event.dragData.getData("style")[0];
            circle.graphics.clear();
            circle.graphics.lineStyle(1,style.lineColor, style.lineAlpha);
            circle.graphics.beginFill(style.fillColor, style.fillAlpha);
            circle.graphics.drawCircle(0,0,50);
            circle.graphics.endFill();
        }
        
        private function onDragEnter(event:DragEvent):void
        {
            if (event.dragData.hasFormat("style"))
                FlashDragManager.acceptDragDrop(circle);
        }
        
        private function onMouseDown(event:MouseEvent):void
        {
            var rect:TangoRect = event.target as TangoRect;
            var data:DragData = new DragData();
            data.setData("style", rect.style);
            FlashDragManager.doDrag(rect,data,null,null,DragActions.COPY);
        }
        
    }
    
}

import flash.display.Sprite;

class TangoRect extends Sprite 
{

    private var _color:uint;
    
    public function TangoRect(color24:uint)
    {
        super();
        this._color = color24 & 0x00ffffff;
        var style:Object = this.style;
        this.graphics.lineStyle(1,style.lineColor, style.lineAlpha);
        this.graphics.beginFill(style.fillColor, style.fillAlpha);
        this.graphics.drawRect(0.5,0.5,19.5,19.5);
        this.graphics.endFill();
    }
    
    public function get style():Object
    {
        return {lineColor: 0x878787, lineAlpha: 0.4, fillColor: _color, fillAlpha: 1.0};
    }
    
    override public function get width():Number
    {
        return 20;
    }
    
    override public function get height():Number
    {
        return 20;
    }
    
}

