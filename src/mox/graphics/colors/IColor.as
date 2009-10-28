/*
 * IColor.as
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
package mox.graphics.colors 
{

public interface IColor 
{
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	/**
	 * Returns a RGB 24-bits color.
	 * @return a RGB 24-bits color.
	 */
	function getColor():uint;
	
	/**
	 * Returns an ARGB 32-bits color.
	 * @return an ARGB 32-bits color.
	 */
	function getColor32():uint;
	
	/**
	 * Converts this <code class="prettyprint">IColor</code> 
	 * in the specified color model.
	 * @param colorModel the color model to convert this color into.
	 * @return this <code class="prettyprint">IColor</code> 
	 * in the specified color model.
	 */
	function convertTo(colorModel:int):IColor;
	
	/**
	 * Compares this <code class="prettyprint">IColor</code> 
	 * to the specified color for equality.
	 * @param color the color to compare.
	 * @return true if this <code class="prettyprint">IColor</code> equals 
	 * the specified one. <code class="prettyprint">false</code> otherwise.
	 */
	function equals(color:IColor):Boolean;
	
	/**
	 * Returns a clone of this <code class="prettyprint">IColor</code>.
	 * @return a clone of this <code class="prettyprint">IColor</code>.
	 */
	function clone():IColor;
	
	/**
	 * Returns a string representation of this <code class="prettyprint">IColor</code>.
	 * @return a string representation of this <code class="prettyprint">IColor</code>.
	 */
	function toString():String;
	
	/**
	 * Returns the 32-bit hexadecimal value of this <code class="prettyprint">IColor</code>.
	 * @return the 32-bit hexadecimal value of this <code class="prettyprint">IColor</code>.
	 */
	function valueOf():uint;
	
}
	
}
