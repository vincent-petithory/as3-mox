package mox.ui 
{
	
import flash.display.InteractiveObject;
import flash.events.Event;
	
public class DragManagerEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const FLASH_DRAG_ACCEPT:String = "flashDragAccept";
	public static const FLASH_DRAG_ACCEPT_DEPRECATED:String = "flashDragAcceptDeprecated";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _dragTargetAcceptor:InteractiveObject;
	
	public function get dragTargetAcceptor():InteractiveObject { return _dragTargetAcceptor; }
	
	private var _dragTarget:InteractiveObject;
	
	public function get dragTarget():InteractiveObject { return _dragTarget; }
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------


	public function DragManagerEvent(type:String, dragTarget:InteractiveObject, dragTargetAcceptor:InteractiveObject = null) 
	{ 
		super(type, false, false);
		this._dragTarget = dragTarget;
		this._dragTargetAcceptor = dragTargetAcceptor;
		if (this._dragTargetAcceptor == null)
			this._dragTargetAcceptor = _dragTarget;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------

	public override function clone():Event 
	{ 
		return new DragManagerEvent(type, _dragTargetAcceptor);
	} 
	
	

}
	
}
