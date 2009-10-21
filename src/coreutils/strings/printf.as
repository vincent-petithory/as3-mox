/*
 * printf.as
 * This file is part of as3-coreutils 
 *
 * Copyright (C) 2009 - Vincent Petithory
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
 
package coreutils.strings 
{

    public const printf:Function = function(str:String, ...values):String
	{
		regexp_values = values;
		var strOut:String = str.replace(regexp, repFunc);
		regexp_values = null;
		return strOut;
	}
    
}

internal var regexp_values:Array;
internal var regexp:RegExp = new RegExp("%\\d+","g");

internal const repFunc:Function = function():String 
{
	return String(regexp_values[parseInt(arguments[0].substr(1))+1]);
}