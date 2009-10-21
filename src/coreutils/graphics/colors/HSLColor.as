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


public class HSLColor implements IColor
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const MIN_HUE:uint = 0;
	public static const MAX_HUE:uint = 360;
	public static const MIN_SATURATION:uint = 0;
	public static const MAX_SATURATION:uint = 100;
	public static const MIN_LIGHTNESS:uint = 0;
	public static const MAX_LIGHTNESS:uint = 100;
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
	public static function createFromHexa(color:uint):HSLColor
	{
		return RGBColor.createFromHexa(color).convertTo(ColorSpace.HSL) as HSLColor;
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _h:Number;
	
	public function get h():Number { return _h; }
	
	public function set h(value:Number):void {
		if (value > MAX_HUE)
		{
			_h = value - MAX_HUE;
		}
		else if (value < MIN_HUE)
		{
			_h = -(value - MIN_HUE);
		}
		else
		{
			_h = value;
		}
		
	}
	
	private var _s:Number;
	
	public function get s():Number { return _s; }
	
	public function set s(value:Number):void {
		_s = Math.min(Math.max(value, MIN_SATURATION), MAX_SATURATION);
	}
	
	private var _l:Number;
	
	public function get l():Number { return _l; }
	
	public function set l(value:Number):void {
		_l = Math.min(Math.max(value, MIN_LIGHTNESS), MAX_LIGHTNESS);
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
	 * Creates a HSL model based color.
	 * 
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param s The saturation value. Must be in the [0, 100] interval.
	 * @param l The lightness value. Must be in the [0, 100] interval.
	 * @param a The Alpha value. Must be in the [0, 255] interval.
	 */
	public function HSLColor(h:Number = 0, s:Number = 0, l:Number = 0, a:Number = 255) 
	{
		super();
		this.h = h;
		this.s = s;
		this.l = l;
		this.a = a;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function adjustHue(hBy:Number):void
	{
		this.h += hBy;
	}
	
	public function adjustSaturation(sBy:Number):void
	{
		this.s += sBy;
	}
	
	public function adjustLightness(lBy:Number):void
	{
		this.l += lBy;
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
				return HSLColor.convertHSLToRGB(_h, _s, _l, _a);
			case ColorSpace.HSV:
				return HSLColor.convertHSLToRGB(_h, _s, _l, _a).convertTo(ColorSpace.HSV);
			case ColorSpace.HSL:
				return this.clone();
			case ColorSpace.CMYK:
				return HSLColor.convertHSLToRGB(_h, _s, _l, _a).convertTo(ColorSpace.CMYK);
			case ColorSpace.YUV:
				return HSLColor.convertHSLToRGB(_h, _s, _l, _a).convertTo(ColorSpace.YUV);
			case ColorSpace.CIE_LCH:
				return HSLColor.convertHSLToRGB(_h, _s, _l, _a).convertTo(ColorSpace.CIE_LCH);
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
		return new HSLColor(_h, _s, _l, _a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:HSLColor = object.convertTo(ColorSpace.HSL) as HSLColor;
		if (color.h == this._h && 
			color.s == this._s && 
			color.l == this._l && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(h="+_h+", s="+_s+", l="+_l+", a="+_a+")";
	}
	
	/**
	 * @inheritDoc
	 */
	public function valueOf():uint
	{
		return this.getColor32();
	}
	
	/**
	 * Converts a HSL based color to a RGB based color.
	 * RGB values are returned in [0, 255] X [0, 255] X [0, 255].
	 * 
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param s The saturation value. Must be in the [0, 100] interval.
	 * @param l The lightness value. Must be in the [0, 100] interval.
	 * @return An object containing RGB values - i.e : <code class="prettyprint">{r: 134, g:255, b:45}</code>.
	 */
	private static function convertHSLToRGB(h:Number, s:Number, l:Number, a:Number):IColor
	{
		h /= 360;
		s /= 100;
		l /= 100;
		
		if (s == 0)
		{
			return new RGBColor(RGBColor.CHANNEL_MAX_VALUE*l, RGBColor.CHANNEL_MAX_VALUE*l, RGBColor.CHANNEL_MAX_VALUE*l,a);
		}
		else
		{
			var var_1:Number;
			var var_2:Number;
			if (l < 0.5)
			{
				var_2 = l*(1+s);
			}
			else
			{
				var_2 = (l+s)-(s*l);
			}
			
			var_1 = 2*l - var_2;
			
			var r:Number = RGBColor.CHANNEL_MAX_VALUE*hueToRGB(var_1, var_2, h + 1/3);
			var g:Number = RGBColor.CHANNEL_MAX_VALUE*hueToRGB(var_1, var_2, h);
			var b:Number = RGBColor.CHANNEL_MAX_VALUE*hueToRGB(var_1, var_2, h - 1/3);
			
			return new RGBColor(r, g, b, a);
		}
	}
	
	/**
	 * @private
	 */
	private static function hueToRGB(v1:Number, v2:Number, vH:Number):Number
	{
		if (vH < 0)
		{
			vH += 1;
		}
		if (vH > 1)
		{
			vH -= 1;
		}
		
		if (vH < 1/6)
		{
			return (v1 + (v2 - v1)*6*vH);
		}
		else if (vH < 1/2)
		{
			return v2;
		}
		else if (vH < 2/3)
		{
			return (v1 + (v2 - v1)*( 2/3 - vH )*6);
		}
		else
		{
			return v1;
		}
	}
	
}
	
}
