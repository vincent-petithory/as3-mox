/*
 * HSVColor.as
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
package tinker.graphics.colors 
{


public class HSVColor implements IColor
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
	public static const MIN_VALUE:uint = 0;
	public static const MAX_VALUE:uint = 100;
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
	public static function createFromHexa(color:uint):HSVColor
	{
		return RGBColor.createFromHexa(color).convertTo(ColorSpace.HSV) as HSVColor;
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
	
	private var _v:Number;
	
	public function get v():Number { return _v; }
	
	public function set v(value:Number):void {
		_v = Math.min(Math.max(value, MIN_VALUE), MAX_VALUE);
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
	 * Creates a HSV model based color.
	 * 
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param s The saturation value. Must be in the [0, 100] interval.
	 * @param v The Value value. Must be in the [0, 100] interval.
	 * @param a The Alpha value. Must be in the [0, 255] interval.
	 */
	public function HSVColor(h:Number = 0, s:Number = 0, v:Number = 0, a:Number = 255) 
	{
		super();
		this.h = h;
		this.s = s;
		this.v = v;
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
	
	public function adjustValue(vBy:Number):void
	{
		this.v += vBy;
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
				return HSVColor.convertHSVToRGB(_h, _s, _v, _a);
			case ColorSpace.HSV:
				return this.clone();
			case ColorSpace.HSL:
				return HSVColor.convertHSVToRGB(_h, _s, _v, _a).convertTo(ColorSpace.HSL);
			case ColorSpace.CMYK:
				return HSVColor.convertHSVToRGB(_h, _s, _v, _a).convertTo(ColorSpace.CMYK);
			case ColorSpace.YUV:
				return HSVColor.convertHSVToRGB(_h, _s, _v, _a).convertTo(ColorSpace.YUV);
			case ColorSpace.CIE_LCH:
				return HSVColor.convertHSVToRGB(_h, _s, _v, _a).convertTo(ColorSpace.CIE_LCH);
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
		return new HSVColor(_h, _s, _v, _a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:HSVColor = object.convertTo(ColorSpace.HSV) as HSVColor;
		if (color.h == this._h && 
			color.s == this._s && 
			color.v == this._v && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(h="+_h+", s="+_s+", v="+_v+", a="+_a+")";
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
	 * Converts a HSV based color to a RGB based color.
	 * RGB values are returned in [0, 255] X [0, 255] X [0, 255].
	 * 
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param s The saturation value. Must be in the [0, 100] interval.
	 * @param v The Value value. Must be in the [0, 100] interval.
	 * @return An object containing RGB values - i.e : <code class="prettyprint">{r: 134, g:255, b:45}</code>.
	 */
	private static function convertHSVToRGB(h:Number, s:Number, v:Number, a:Number):RGBColor
	{
		h /= 360;
		s /= 100;
		v /= 100;
		
		if (s == 0)
		{
			return new RGBColor(RGBColor.CHANNEL_MAX_VALUE*v, RGBColor.CHANNEL_MAX_VALUE*v, RGBColor.CHANNEL_MAX_VALUE*v, a);
		}
		else
		{
			var vH:Number = h*6;
			if (vH == 6)
			{
				vH = 0;
			}
			var vI:Number = Math.floor(vH);
			var v1:Number = v*(1-s);
			var v2:Number = v*(1-s*(vH - vI));
			var v3:Number = v*(1-s*(1 - (vH - vI)));
			
			var vR:Number;
			var vG:Number;
			var vB:Number;
			
			switch(vI)
			{
				case 0:
					vR = v; vG = v3; vB = v1;
					break;
				case 1:
					vR = v2; vG = v; vB = v1;
					break;
				case 2:
					vR = v1; vG = v; vB = v3;
					break;
				case 3:
					vR = v1; vG = v2; vB = v;
					break;
				case 4:
					vR = v3; vG = v1; vB = v;
					break;
				default:
					vR = v; vG = v1; vB = v2;
					
			}
			return new RGBColor(vR*RGBColor.CHANNEL_MAX_VALUE, vG*RGBColor.CHANNEL_MAX_VALUE, vB*RGBColor.CHANNEL_MAX_VALUE, a);
		}
	}
}
	
}
