/*
 * DragManagerEvent.as
 * This file is part of Mox
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * Mox is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Mox is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Mox; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
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
