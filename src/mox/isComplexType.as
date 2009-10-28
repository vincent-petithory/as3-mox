/*
 * isComplexType.as
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
	public function isComplexType(obj:Object):Boolean
	{
		return !isSimpleType(obj);
	}
	
}
