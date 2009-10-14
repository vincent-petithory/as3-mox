/*
 * FileWatcherEvent.as
 * This file is part of as3-coreutils 
 *
 * Copyright (C) 2009 - Vincent
 *
 * as3-coreutils is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * as3-coreutils is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
 
package coreutils  
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
