/*
 * formatToString.as
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

import flash.utils.getQualifiedClassName;

/**
 * A utility function that helps implementing the <code class="prettyprint">toString()</code> 
 * method of Object suclasses.
 * 
 * <p>If you specify an array as the unique additional parameter, 
 * the elements of this array will be considered.</p>
 * 
 * @param object the object to describe
 * @param ...args The name of the properties of the specified object 
 * that should appear in the representation
 * @return A detail string representation of the object, 
 * including its class name and the specified properties
 */
public function formatToString(object:Object, ...args):String
{
	var qualifiedClassName:String = getQualifiedClassName(object);
	var patternIndex:int = qualifiedClassName.lastIndexOf("::");
	if (patternIndex == -1) // Top-level class
	{
		patternIndex = 0;
	}
	else
	{
		patternIndex += 2;
	}
	var className:String = qualifiedClassName.substring(patternIndex);
	var string:String = "["+className+" ";
	var property:String;
	
	if (args.length == 1 && args[0] is Array)
	{
		args = args[0];
	}
	
	for each (property in args)
	{
		string = string.concat(property+"=\""+object[property]+"\", ");
	}
	string = string.substr(0, string.length - 2);
	return string.concat("]");
}
	
}
