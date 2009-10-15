/*
 * isPrimitive.as
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
 
package coreutils 
{

	/**
	 * Returns <code>true</code> if the provided parameter 
	 * is of one of these types :
	 * 
	 * <ul>
	 * <li>Boolean</li>
	 * <li>int</li>
	 * <li>Number</li>
	 * <li>String</li>
	 * <li>uint</li>
	 * </ul>
	 * 
	 * Thoses types are passed by value.
	 * 
	 * @param obj The object to test.
	 * @return <code class="prettyprint">true</code> if the provided parameter 
	 * pass is of one of the quoted types.
	 */
	public const isPrimitive:Function = function(obj:Object):Boolean
	{
		if (obj is Boolean || 
			obj is int || obj is Number || 
			obj is String || obj is uint
		)
		{
			return true;
		}
		return false;
	}
	
}
