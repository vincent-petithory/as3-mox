/*
 * printf.as
 * This file is part of Tinker
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * Tinker is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Tinker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Tinker; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package tinker.strings 
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
