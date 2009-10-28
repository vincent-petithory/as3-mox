/*
 * RGBColor.as
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
	

public class RGBColor implements IColor
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const CHANNEL_MIN_VALUE:uint = 0;
	public static const CHANNEL_MAX_VALUE:uint = 255;
	
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
	public static function createFromHexa(color:uint):RGBColor
	{
		var alpha:uint;
		var red:uint;
		var green:uint;
		var blue:uint;
		if (color > 0xFFFFFF)
		{
			// 32-bit color
			alpha = color >> 24 & 0xFF;
			red = color >> 16 & 0xFF;
			green = color >> 8 & 0xFF;
			blue = color & 0xFF;
			
			return new RGBColor(red, green, blue, alpha);
		}
		else
		{
			// 24-bit color
			red = color >> 16 & 0xFF;
			green = color >> 8 & 0xFF;
			blue = color & 0xFF;
			
			return new RGBColor(red, green, blue);
		}
	}
	
	//------------------------------
	//
	// Properties
	//
	//------------------------------
	
	private var _r:Number;
	
	public function get r():Number { return _r; }
	
	public function set r(value:Number):void {
		_r = Math.min(Math.max(value, CHANNEL_MIN_VALUE), CHANNEL_MAX_VALUE);
	}
	
	private var _g:Number;
	
	public function get g():Number { return _g; }
	
	public function set g(value:Number):void {
		_g = Math.min(Math.max(value, CHANNEL_MIN_VALUE), CHANNEL_MAX_VALUE);
	}
	
	private var _b:Number;
	
	public function get b():Number { return _b; }
	
	public function set b(value:Number):void {
		_b = Math.min(Math.max(value, CHANNEL_MIN_VALUE), CHANNEL_MAX_VALUE);
	}
	
	private var _a:Number;
	
	public function get a():Number { return _a; }
	
	public function set a(value:Number):void {
		_a = Math.min(Math.max(value, CHANNEL_MIN_VALUE), CHANNEL_MAX_VALUE);
	}
	
	//------------------------------
	//
	// Constructor
	//
	//------------------------------
	
	/**
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @param a The Alpha value. Must be in the [0, 255] interval.
	 */
	public function RGBColor(r:Number = 0, g:Number = 0, b:Number = 0, a:Number = RGBColor.MAX_ALPHA) 
	{
		super();
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}
	
	//------------------------------
	//
	// Methods
	//
	//------------------------------
	
	public function adjustRed(rBy:Number):void
	{
		this.r += rBy;
	}
	
	public function adjustGreen(gBy:Number):void
	{
		this.g += gBy;
	}
	
	public function adjustBlue(bBy:Number):void
	{
		this.b += bBy;
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
				return this.clone();
			case ColorSpace.HSV:
				return RGBColor.convertRGBToHSV(_r, _g, _b, _a);
			case ColorSpace.HSL:
				return RGBColor.convertRGBToHSL(_r, _g, _b, _a);
			case ColorSpace.CMYK:
				return RGBColor.convertRGBToCMYK(_r, _g, _b, _a);
			case ColorSpace.YUV:
				return RGBColor.convertRGBToYUV(_r, _g, _b, _a);
			case ColorSpace.CIE_LCH:
				return RGBColor.convertRGBToLCH(_r, _g, _b, _a);
			default: 
				return null;
		}
	}
	
	public function getColor():uint
	{
		return ((r << 16) + (g << 8) + (b));
	}
	
	public function getColor32():uint
	{
		return ((a << 24) + (r << 16) + (g << 8) + (b));
	}
	
	public function clone():IColor 
	{
		return new RGBColor(r, g, b, a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:RGBColor = object.convertTo(ColorSpace.RGB) as RGBColor;
		if (color.r == this._r && 
			color.g == this._g && 
			color.b == this._b && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(r="+r+", g="+g+", b="+b+", a="+a+")";
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
	 * Converts a RGB based color to a CMYK based color.
	 * CMYK values are returned in [0, 100] X [0, 100] X [0, 100] X [0, 100].
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @return An object containing CMYK values - i.e : <code class="prettyprint">{c: 50, m:30, b:10, k:30}</code>.
	 */
	private static function convertRGBToCMYK(r:Number, g:Number,b:Number, a:Number):CMYKColor
	{
		r /= RGBColor.CHANNEL_MAX_VALUE;
		g /= RGBColor.CHANNEL_MAX_VALUE;
		b /= RGBColor.CHANNEL_MAX_VALUE;
		
		var c:Number = 1 - r;
		var m:Number = 1 - g;
		var y:Number = 1 - b;
		
		var k:Number = 1;
		
		if (c < k)
		{
			k = c;
		}
		if (m < k)
		{
			k = m;
		}
		if (y < k)
		{
			k = y;
		}
		
		if (k == 1)
		{
			c = 0;
			m = 0;
			y = 0;
		}
		else
		{
			c = (c - k)/(1 - k);
			m = (m - k)/(1 - k);
			y = (y - k)/(1 - k);
		}
		
		return new CMYKColor(c*CMYKColor.CMYK_MAX_VALUE, m*CMYKColor.CMYK_MAX_VALUE, y*CMYKColor.CMYK_MAX_VALUE, k*CMYKColor.CMYK_MAX_VALUE, a);
		
	}
	
	/**
	 * @private
	 * Converts a RGB based color to a HSV based color.
	 * HSV values are returned in [0, 360] X [0, 100] X [0, 100].
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @return An object containing HSV values - i.e : <code class="prettyprint">{h: 150, s:50, v:40}</code>.
	 */
	private static function convertRGBToHSV(r:Number, g:Number, b:Number, a:Number):HSVColor
	{
		r /= RGBColor.CHANNEL_MAX_VALUE;
		g /= RGBColor.CHANNEL_MAX_VALUE;
		b /= RGBColor.CHANNEL_MAX_VALUE;
		
		var h:Number;
		var s:Number;
		var v:Number;
		
		var min:Number = Math.min(r, g, b);
		var max:Number = Math.max(r, g, b);
		
		var delta:Number = max - min;
		v = max;
		
		if (delta == 0)
		{
			return new HSVColor(0, 0, v*HSVColor.MAX_VALUE, a);
		}
		else
		{
			s = delta/max;
			
			function deltaRGB(c:Number):Number
			{
				return ((max - c)/(6*delta) + 1/2);
			}
			
			var deltaR:Number = deltaRGB(r);
			var deltaG:Number = deltaRGB(g);
			var deltaB:Number = deltaRGB(b);
			
			if (r == max)
			{
				h = deltaB - deltaG;
			}
			else if (g == max)
			{
				h = 1/3 + deltaR - deltaB;
			}
			else if (b == max)
			{
				h = 2/3 + deltaG - deltaR;
			}
			
			if (h < 0)
			{
				h += 1;
			}
			if (h > 1)
			{
				h -= 1;
			}
			
			return new HSVColor(h*HSVColor.MAX_HUE, s*HSVColor.MAX_SATURATION, v*HSVColor.MAX_VALUE, a);
		}
	}
	
	/**
	 * Converts a RGB based color to a HSL based color.
	 * HSL values are returned in [0, 360] X [0, 100] X [0, 100].
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @return An object containing HSL values - i.e : <code class="prettyprint">{h: 247, s:55, l:45}</code>.
	 */
	private static function convertRGBToHSL(r:Number, g:Number, b:Number, a:Number):HSLColor
	{
		r /= CHANNEL_MAX_VALUE;
		g /= CHANNEL_MAX_VALUE;
		b /= CHANNEL_MAX_VALUE;
		
		var h:Number;
		var s:Number;
		var l:Number;
		
		var min:Number = Math.min(r, g, b);
		var max:Number = Math.max(r, g, b);
		
		var delta:Number = max - min;
		l = (max + min)/2;
		
		if (delta == 0)
		{
			return new HSLColor(0, 0, l, a);
		}
		else
		{
			if (l < 0.5)
			{
				s = delta/(max + min);
			}
			else
			{
				s = delta/(2 - max - min);
			}
			
			function deltaRGB(c:Number):Number
			{
				return ((max - c)/(6*delta) + 1/2);
			}
			
			var deltaR:Number = deltaRGB(r);
			var deltaG:Number = deltaRGB(g);
			var deltaB:Number = deltaRGB(b);
			
			if (r == max)
			{
				h = deltaB - deltaG;
			}
			else if (g == max)
			{
				h = 1/3 + deltaR - deltaB;
			}
			else if (b == max)
			{
				h = 2/3 + deltaG - deltaR;
			}
			
			if (h < 0)
			{
				h += 1;
			}
			if (h > 1)
			{
				h -= 1;
			}
			
			return new HSLColor(h, s, l, a);
		}
		
	}
	
	/**
	 * Converts a RGB based color to a YUV based color.
	 * YUV values are in [0, 255] X [0, 255] X [0, 255].
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @return An object containing YUV values - i.e : <code class="prettyprint">{y: 230, u:145, v:65}</code>.
	 */
	private static function convertRGBToYUV(r:Number, g:Number, b:Number, a:Number):YUVColor 
	{
		var y:Number = 0.299*r + 0.587*g + 0.114*b;
		var u:Number = -0.169*r - 0.331*g + 0.500*b + 128;
		var v:Number = 0.500*r - 0.419*g - 0.081*b + 128;

		return new YUVColor(y, u, v, a);
	}
	
	/**
	 * Converts a RGB based color to a CIE L*C*H° based color.
	 * CIE L*C*H° values are in [0, 100] X [0, 100] X [0, 360].
	 * 
	 * @param r The red channel value. Must be in the [0, 255] interval.
	 * @param g The green channel value. Must be in the [0, 255] interval.
	 * @param b The blue channel value. Must be in the [0, 255] interval.
	 * @return An object containing YUV values - i.e : <code class="prettyprint">{l: 25, c:32, h:235}</code>.
	 */
	private static function convertRGBToLCH(r:Number, g:Number, b:Number, a:Number):CieLCHColor 
	{
		
		
		
		return new CieLCHColor();
	}
	
}
	
}
