/*
 * centerObject.as
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

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

    public function centerObject(
			toCenter:DisplayObject, 
			inContainer:DisplayObjectContainer, 
			offsetX:Number = 0, 
			offsetY:Number = 0 
    	):void
	{
		var w:String;
		var h:String;
		if (inContainer is Stage)
		{
			w = "stageWidth";
			h = "stageHeight";
		}
		else
		{
			w = "width";
			h = "height";
		}
		toCenter.x = offsetX + (inContainer[w] - toCenter.width)/2;
		toCenter.y = offsetY + (inContainer[h] - toCenter.height)/2;
	}

}
