///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2008 Vincent Petithory - http://blog.lunar-dev.net/
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE. 
///////////////////////////////////////////////////////////////////////////////

package coreutils.graphics.colors 
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
