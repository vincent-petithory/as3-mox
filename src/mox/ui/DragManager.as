﻿package mox.ui 
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mox.dev.varDump;
	
    /**
     * Dispatched when a drag gesture is accepted
     */
    [Event(name="flashDragAccept", type="mox.ui.DragManagerEvent")]

    /**
     * Dispatched when a previous drag gesture which was accepted is not valid anymore
     */
    [Event(name="flashDragAcceptDeprecated", type="mox.ui.DragManagerEvent")]
	
	/**
	 * The DragManager. Handles the drag gesture and dispatches events 
	 * that notify whether the drag operations are accepted or not.
	 */
    public class DragManager extends EventDispatcher 
    {
	
	    internal static const ACTION_UNSET:uint = 0xFFFFFFFF;
	
	    public function DragManager() 
	    {
		    super();
	    }
	
	    protected var $source:InteractiveObject;
	
	    public function get source():InteractiveObject
	    {
		    return $source;
	    }
	
	    private var _layer:DisplayObjectContainer;
	
	    protected var $draggable:Sprite;
	
	    private var _isDragging:Boolean = false;
	
	    public function get isDragging():Boolean { return _isDragging; }
	
	    public function get dropAction():uint { return _action; }
	
	    public function set dropAction(value:uint):void 
	    {
		    _action = value;
	    }
	
	    protected var $dragData:DragData;
	
	    private var _action:uint;
	
	    protected var $allowedActions:uint;
	
	    protected var $currentTarget:InteractiveObject;
	    protected var $currentDropAcceptor:InteractiveObject;
	
	    public function acceptDragDrop(object:InteractiveObject):void
	    {
		    $currentDropAcceptor = object;
		    _layer.stage.addEventListener(MouseEvent.MOUSE_UP, onDragDrop, false, 99);
		    this.dispatchEvent(new DragManagerEvent(DragManagerEvent.FLASH_DRAG_ACCEPT, $currentTarget, $currentDropAcceptor));
	    }
	
	    private var layerMouseEnabledBuffer:Boolean;
	    private var layerMouseChildrenBuffer:Boolean;
	
	    public function doDrag(
	                    object:InteractiveObject, 
	                    dragData:DragData, 
	                    dragImage:IBitmapDrawable = null, 
	                    offset:Point = null, 
	                    allowedActions:int = -1, 
	                    dragLayer:DisplayObjectContainer = null
                    ):void
	    {
	        if (this.isDragging)
	            return;
	        
		    this._layer = dragLayer;
		    if (this._layer == null)
		    {
			    this._layer = object.stage;
		    }
		    if (!(_layer is Stage)) 
		    {
			    try
			    {
				    layerMouseEnabledBuffer = this._layer.mouseEnabled;
				    layerMouseChildrenBuffer = this._layer.mouseChildren;
				    this._layer.mouseEnabled = false;
				    this._layer.mouseChildren = false;
			    }catch (e:Error)
			    {
				    // ignore
			    }
		    }
		    if (_layer != null && _layer.stage != null)
		    {
			    this.$source = object;
			    this.$dragData = dragData;
			    this._action = ACTION_UNSET;
			    this.$allowedActions = allowedActions;
			    if (allowedActions == -1)
				    $allowedActions = DragActions.MOVE | DragActions.COPY;
			    
			    $draggable = new Sprite();
			    if (!dragImage)
			    {
				    dragImage = $getDefaultDragImage(object);
			    }
				$draggable.addChild(new Bitmap($getDraggable(dragImage)));
				$draggable.mouseEnabled = $draggable.mouseChildren = false;
				
			    // set position of the dragImage
			    var position:Point = new Point(_layer.mouseX,_layer.mouseY);
			    if (offset != null)
			    {
				    position = position.add(offset);
			    }
			    _layer.addChild($draggable);
			    $draggable.x = position.x;
			    $draggable.y = position.y;
			
			    _layer.stage.addEventListener(MouseEvent.MOUSE_OVER, onDragOver, false, 99);
			    _layer.stage.addEventListener(MouseEvent.MOUSE_OUT, onDragOut, false, 99);
			    _layer.stage.addEventListener(MouseEvent.MOUSE_UP, onDragEnd, false, 98);
			    _layer.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragUpdate, false, 99);
			
			    $draggable.startDrag();
			    _isDragging = true;
			    this.$source.dispatchEvent(new DragEvent(DragEvent.FLASH_DRAG_START, true, $dragData, $allowedActions, _action));
		    }
		    else
		    {
			    throw new TypeError("No layer for dragging was specified, or it was not yet added on the stage.");
		    }
	    }
	
	    private function onDragEnd(e:MouseEvent):void 
	    {
		    $endDrag();
	    }
	
	    private function onDragOver(e:MouseEvent):void 
	    {
		    $currentTarget = e.target as InteractiveObject;
		    _layer.stage.addEventListener(MouseEvent.MOUSE_MOVE, onDragMove, false);
		    var event:DragEvent = new DragEvent(DragEvent.FLASH_DRAG_ENTER, false, $dragData, $allowedActions, _action);
		    $currentTarget.dispatchEvent(event);
	    }
	
	    private function onDragOut(e:MouseEvent):void 
	    {
		    var event:DragEvent = new DragEvent(DragEvent.FLASH_DRAG_EXIT, false, $dragData, $allowedActions, _action);
		    e.target.dispatchEvent(event);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragMove, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_UP, onDragDrop, false);
		    this.dispatchEvent(new DragManagerEvent(DragManagerEvent.FLASH_DRAG_ACCEPT_DEPRECATED, $currentTarget, $currentDropAcceptor));
		    $currentTarget = null;
		    $currentDropAcceptor = null;
		    this._action = ACTION_UNSET;
	    }
	
	    private function onDragDrop(e:MouseEvent):void 
	    {
		    if ($currentTarget && $currentDropAcceptor)
		    {
				if (this._action == ACTION_UNSET)
				{
					if (this.$currentTarget && this.$currentDropAcceptor)
					{
						if ($allowedActions == (DragActions.COPY | DragActions.MOVE)) 
						{
							this._action = DragActions.COPY;
						}
						else
						{
							this._action = $allowedActions;
						}
					}
					else
					{
						this._action = DragActions.NONE;
					}
				}
				
			    var dropEvent:DragEvent = new DragEvent(DragEvent.FLASH_DRAG_DROP, true, $dragData, $allowedActions, this._action);
			    $currentDropAcceptor.dispatchEvent(dropEvent);
		    }
	    }
	
	    protected function $endDrag():void
	    {
		    _layer.removeChild($draggable);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragMove, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDragUpdate, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_OVER, onDragOver, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_OUT, onDragOut, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_UP, onDragDrop, false);
		    _layer.stage.removeEventListener(MouseEvent.MOUSE_UP, onDragEnd, false);
		
		    if (!(_layer is Stage)) 
		    {
			    try
			    {
				    this._layer.mouseEnabled = layerMouseEnabledBuffer;
				    this._layer.mouseChildren = layerMouseChildrenBuffer;
			    }catch (e:Error)
			    {
				    // ignore 
			    }
		    }
		
		    _isDragging = false;
		    $draggable = null;
		    
            this.$source.dispatchEvent(new DragEvent(DragEvent.FLASH_DRAG_COMPLETE, false, $dragData, $allowedActions, this._action));
		    
		    // Clean data
		    this._layer = null;
		    this.$dragData = null;
		    this._action = ACTION_UNSET;
		    this.$source = null;
		    this.$currentTarget = null;
		    this.$currentDropAcceptor = null;
	    }
	
	    private function onDragUpdate(e:MouseEvent):void 
	    {
		    var initiatorEvent:DragEvent = new DragEvent(DragEvent.FLASH_DRAG_UPDATE, false, $dragData, $allowedActions, _action);
		    this.$source.dispatchEvent(initiatorEvent);
	    }
	
	    private function onDragMove(e:MouseEvent):void 
	    {
		    var overEvent:DragEvent = new DragEvent(DragEvent.FLASH_DRAG_OVER, true, $dragData, $allowedActions, _action);
		    $currentTarget.dispatchEvent(overEvent);
	    }
	
	    protected function $getDefaultDragImage(object:DisplayObject):BitmapData
	    {
		    var bounds:Rectangle = object.getBounds(object);
		    var bmp:BitmapData = new BitmapData(bounds.width-bounds.x,bounds.height-bounds.y,true,0x00000000);
		    bmp.draw(object, new Matrix(1,0,0,1,-bounds.x,-bounds.y));
		    return bmp;
	    }
	
	    protected function $getDraggable(drawable:IBitmapDrawable):BitmapData
	    {
		    if (drawable is BitmapData)
		    {
			    return (drawable as BitmapData).clone();
		    }
		    else if (drawable is Bitmap)
		    {
			    return (drawable as Bitmap).bitmapData.clone();
		    }
		    else // it is a DisplayObject
		    {
		    	var bounds:Rectangle = (drawable as DisplayObject).getBounds(drawable as DisplayObject);
		    	var bitmapData:BitmapData = new BitmapData(bounds.width,bounds.height,true,0x00000000);
		    	bitmapData.draw(drawable);
		        return bitmapData;
		    }
	    }
	}
}
