/*
 * vectorToArray.as
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
package mox.lists 
{
	
	/**
	 * Creates an array from a vector.
	 * 
	 * @param vector The vector to process.
	 * @return An Array with the elements of the vector.
	 */
	public function vectorToArray(vector:*):Array
	{
		var n:int = vector.length;
		var array:Array = new Array(n);
		while (--n>-1)
		{
			array[n] = vector[n];
		}
		return array;
	}
	
}
