/*
 * FileWatcherEvent.as
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
package mox.io 
{
	
import flash.events.Event;
import flash.filesystem.File;
	
public class FileWatcherEvent extends Event 
{

	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const FILE_CREATE:String = "fileCreate";
	public static const FILE_DELETE:String = "fileDelete";
	public static const FILE_UPDATE:String = "fileUpdate";
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _file:File;
	
	public function get file():File
	{
		return _file;
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------

	public function FileWatcherEvent(type:String, bubbles:Boolean = false, file:File = null) 
	{ 
		super(type, bubbles, false);
		this._file = file;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------

	public override function clone():Event 
	{ 
		return new FileWatcherEvent(type, bubbles, _file);
	} 

	public override function toString():String 
	{ 
		return formatToString("FileWatcherEvent", "type", "bubbles", "cancelable", "eventPhase", "file"); 
	}
	
	

}
	
}
