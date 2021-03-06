/*
 * printf.as
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
package mox.strings 
{
	
	/**
	 * Formats the specified string, using the specified values.
	 * @param str the string to format.
	 * @param values a collection of values to insert. 
	 * It can be an Array, Vector.&lt;*&gt;, Dictionary, Object, or any object that 
	 * matches the keys of the string.
	 */
    public function sprintf(string:String, values:* = undefined):String
	{
		regexpValues = values;
		var stringOut:String = string.replace(Patterns.SPRINTF, repFunc);
		regexpValues = null;
		return stringOut;
	}
    
}

/** 
 * @private
 */
internal var regexpValues:*;

/** 
 * @private
 */
internal const repFunc:Function = function():String 
{
	var token:String = arguments[0];
	return String(regexpValues[token.substring(1,token.length-1)]);
}
