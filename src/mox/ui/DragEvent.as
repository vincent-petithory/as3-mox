/*
 * DragEvent.as
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
	
import flash.events.Event;
	
public class DragEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const FLASH_DRAG_START:String = "flashDragStart";
	public static const FLASH_DRAG_UPDATE:String = "flashDragUpdate";
	public static const FLASH_DRAG_COMPLETE:String = "flashDragComplete";
	
	public static const FLASH_DRAG_OVER:String = "flashDragOver";
	public static const FLASH_DRAG_DROP:String = "flashDragDrop";
	public static const FLASH_DRAG_ENTER:String = "flashDragEnter";
	public static const FLASH_DRAG_EXIT:String = "flashDragExit";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _action:uint;
	
	public function get dropAction():uint { return _action; }
	
	private var _dragData:DragData;
	
	public function get dragData():DragData { return _dragData; }
	
	private var _allowedActions:uint;
	
	public function get allowedActions():uint { return _allowedActions; }
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	public function DragEvent(type:String, cancelable:Boolean, dragData:DragData, allowedActions:uint, action:int) 
	{
		super(type, false, cancelable);
		this._dragData = dragData;
		this._allowedActions = allowedActions;
		this._action = action;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------

	public override function clone():Event 
	{ 
		return new DragEvent(type, cancelable, _dragData, _allowedActions, _action);
	} 


}
	
}
