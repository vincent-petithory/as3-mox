/*
 * DragData.as
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

public class DragData 
{
	
	public function DragData() 
	{
		super();
		_content = new Object();
	}
	
	private var _content:Object;
	
	public function hasFormat(format:String, times:uint = 1):Boolean
	{
	    var esc:String = escape(format);
		return  _content[esc] != undefined && 
		        _content[esc].length >= times;
	}
	
	public function setData(format:String, data:Object):void
	{
		if (!hasFormat(format))
		{
			_content[escape(format)] = new Array();
		}
		_content[escape(format)].push(data);
	}
	
	public function getData(format:String):Array
	{
		if (hasFormat(format))
		{
			return _content[escape(format)].slice();
		}
		else
		{
			return null;
		}
	}
	
	public function clearData(format:String):void
	{
		if (hasFormat(format))
		{
			delete _content[escape(format)];
		}
	}
	
	public function get formats():Array
	{
		var formats:Array = new Array();
		for (var format:String in _content)
		{
			formats.push(unescape(format));
		}
		return formats;
	}
	
	public function clear():void
	{
		_content = new Object();
	}
	
	public static const EMPTY:DragData = new DragData();
	
	
}
	
}
