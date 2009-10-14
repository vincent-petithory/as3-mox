/*
 * getClassName.as
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

	import flash.utils.getQualifiedClassName;

    public const getClassName:Function = function(object:Object):String
	{
		var qn:String = getQualifiedClassName(object);
		var sepIndex:int = qn.lastIndexOf("::");
		if (sepIndex == -1) // Top-level class
		{
			sepIndex = qn.lastIndexOf(".")+1;
		}
		else
		{
			sepIndex+=2;
		}
		return qualifiedClassName.substring(sepIndex);
    }
    
}

