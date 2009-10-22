/*
 * hash.as
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
package tinker 
{

    public const hash:Function = function hash(source:*):int
	{
		if (source)
		{
			if (source is Number && !isNaN(Number(source)))
			{
				return int(source).valueOf();
			}
			else 
			{
				var string:String = String(source);
				var length:int = string.length;
		        var hash:int = 0;
		
		        // Prime numbers
		        // we take high values to 
		        // spread the possible results
		
		        // Fermat 3
		        var a:int = 257;
		        // Fermat 4
		        var b:int = 65537;
		
		        var i:int = 0;
		        while (i < length)
		        {
			        // multiplying the hash by the variable a allows 
			        // to have a different hash if 2 strings contains 
			        // the sames chars in a different order.
			        hash = a*hash + string.charCodeAt(i);
			        a = a * b;
			        i++;
		        }
		        return hash;
			}
		}
		else
		{
			return 0;
		}
	}
    
}
