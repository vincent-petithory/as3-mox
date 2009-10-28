/*
 * getClass.as
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
package mox 
{

    import flash.errors.IllegalOperationError;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

    public const getClass:Function = function(object:Object):Class
    {
        var type:*;
		if (object is Class)
		{
			type = object as Class;
		}
		else if (object is String)
		{
			var string:String = object as String;
			try	{
				type = getDefinitionByName(string) as Class;
			} catch (e:ReferenceError)
			{
				type = String;
			}
			finally
			{
				return type;
			}
		}
		else 
		{
			try {
				type = getDefinitionByName(
					getQualifiedClassName(object)
				) as Class;
			} catch (e:ReferenceError)
			{
				throw new IllegalOperationError(
					"Local classes cannot be resolved"
				);
			}
		}
		return type;
    }
    
}
