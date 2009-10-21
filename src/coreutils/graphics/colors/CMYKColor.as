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
	

public class CMYKColor implements IColor
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const CMYK_MIN_VALUE:uint = 0;
	public static const CMYK_MAX_VALUE:uint = 100;
	public static const MIN_ALPHA:uint = 0;
	public static const MAX_ALPHA:uint = 255;
	
	/**
	 * Creates an <code class="prettyprint">IColor</code> object 
	 * from an hexadecimal color.
	 * 
	 * @param color The hexa color.
	 * @return an <code class="prettyprint">IColor</code> object 
	 * from an hexadecimal color.
	 */
	public static function createFromHexa(color:uint):CMYKColor
	{
		return RGBColor.createFromHexa(color).convertTo(ColorSpace.CMYK) as CMYKColor;
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _c:Number;
	
	public function get c():Number { return _c; }
	
	public function set c(value:Number):void {
		_c = Math.min(Math.max(value, CMYK_MIN_VALUE), CMYK_MAX_VALUE);
	}
	
	private var _m:Number;
	
	public function get m():Number { return _m; }
	
	public function set m(value:Number):void {
		_m = Math.min(Math.max(value, CMYK_MIN_VALUE), CMYK_MAX_VALUE);
	}
	
	private var _y:Number;
	
	public function get y():Number { return _y; }
	
	public function set y(value:Number):void {
		_y = Math.min(Math.max(value, CMYK_MIN_VALUE), CMYK_MAX_VALUE);
	}
	
	private var _k:Number;
	
	public function get k():Number { return _k; }
	
	public function set k(value:Number):void {
		_k = Math.min(Math.max(value, CMYK_MIN_VALUE), CMYK_MAX_VALUE);
	}
	
	private var _a:Number;
	
	public function get a():Number { return _a; }
	
	public function set a(value:Number):void {
		_a = Math.min(Math.max(value, MIN_ALPHA), MAX_ALPHA);
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * @param c The cyan value. Must be in the [0, 100] interval.
	 * @param m The magenta value. Must be in the [0, 100] interval.
	 * @param y The yellow value. Must be in the [0, 100] interval.
	 * @param k The black value. Must be in the [0, 100] interval.
	 * @param a The Alpha value. Must be in the [0, 255] interval.
	 */
	public function CMYKColor(c:Number = 0, m:Number = 0, y:Number = 0, k:Number = CMYK_MAX_VALUE, a:Number = 255) 
	{
		super();
		this.c = c;
		this.m = m;
		this.y = y;
		this.k = k;
		this.a = a;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function adjustCyan(cBy:Number):void
	{
		this.c += cBy;
	}
	
	public function adjustMagenta(mBy:Number):void
	{
		this.m += mBy;
	}
	
	public function adjustYellow(yBy:Number):void
	{
		this.y += yBy;
	}
	
	public function adjustBlack(kBy:Number):void
	{
		this.k += kBy;
	}
	
	public function adjustAlpha(aBy:Number):void
	{
		this.a += aBy;
	}
	
	public function convertTo(colorModel:int):IColor
	{
		switch (colorModel)
		{
			case ColorSpace.RGB:
				return CMYKColor.convertCMYKToRGB(_c, _m, _y, _k, _a);
			case ColorSpace.HSV:
				return CMYKColor.convertCMYKToRGB(_c, _m, _y, _k, _a).convertTo(ColorSpace.HSV);
			case ColorSpace.HSL:
				return CMYKColor.convertCMYKToRGB(_c, _m, _y, _k, _a).convertTo(ColorSpace.HSL);
			case ColorSpace.CMYK:
				return this.clone();
			case ColorSpace.YUV:
				return CMYKColor.convertCMYKToRGB(_c, _m, _y, _k, _a).convertTo(ColorSpace.YUV);
			case ColorSpace.CIE_LCH:
				return CMYKColor.convertCMYKToRGB(_c, _m, _y, _k, _a).convertTo(ColorSpace.CIE_LCH);
			default: 
				return null;
		}
	}
	
	public function getColor():uint
	{
		return this.convertTo(ColorSpace.RGB).getColor();
	}
	
	public function getColor32():uint
	{
		return this.convertTo(ColorSpace.RGB).getColor32();
	}
	
	public function clone():IColor 
	{
		return new CMYKColor(c, m, y, k, a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:CMYKColor = object.convertTo(ColorSpace.CMYK) as CMYKColor;
		if (color.c == this._c && 
			color.m == this._m && 
			color.y == this._y && 
			color.k == this._k && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(c="+c+", m="+m+", y="+y+", k="+k+", a="+a+")";
	}
	
	/**
	 * @inheritDoc
	 */
	public function valueOf():uint
	{
		return this.getColor32();
	}
	
	/**
	 * @private
	 * Converts a CMYK based color to a RGB based color.
	 * RGB values are returned in [0, 255] X [0, 255] X [0, 255].
	 * 
	 * @param c The cyan value. Must be in the [0, 100] interval.
	 * @param m The magenta value. Must be in the [0, 100] interval.
	 * @param y The yellow value. Must be in the [0, 100] interval.
	 * @param k The black value. Must be in the [0, 100] interval.
	 * @return An object containing RGB values - i.e : <code class="prettyprint">{r: 134, g:255, b:45}</code>.
	 */
	private static function convertCMYKToRGB(c:Number, m:Number, y:Number, k:Number, a:Number):RGBColor
	{
		c /= 100;
		m /= 100;
		y /= 100;
		k /= 100;
		
		c = c*(1-k)+k;
		m = m*(1-k)+k;
		y = y*(1-k)+k;
		
		var r:Number = (1-c)*RGBColor.CHANNEL_MAX_VALUE;
		var g:Number = (1-m)*RGBColor.CHANNEL_MAX_VALUE;
		var b:Number = (1-y)*RGBColor.CHANNEL_MAX_VALUE;
		
		return new RGBColor(r, g, b, a);
	}
	
}
	
}
