/*
 * YUVColor.as
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

public class YUVColor implements IColor 
{
	
	/**
	 * Creates an <code class="prettyprint">IColor</code> object 
	 * from an hexadecimal color.
	 * 
	 * @param color The hexa color.
	 * @return an <code class="prettyprint">YUVColor</code> object 
	 * from an hexadecimal color.
	 */
	public static function createFromHexa(color:uint):YUVColor
	{
		return RGBColor.createFromHexa(color).convertTo(ColorSpace.YUV) as YUVColor;
	}
	
	public static const MIN_Y:uint = 0;
	public static const MAX_Y:uint = 255;
	public static const MIN_U:uint = 0;
	public static const MAX_U:uint = 255;
	public static const MIN_V:uint = 0;
	public static const MAX_V:uint = 255;
	public static const MIN_ALPHA:uint = 0;
	public static const MAX_ALPHA:uint = 255;
	
	private var _y:Number;
	
	public function get y():Number { return _y; }
	
	public function set y(value:Number):void 
	{
		_y = Math.min(Math.max(value, MIN_Y), MAX_Y);
	}
	
	private var _u:Number;
	
	public function get u():Number { return _u; }
	
	public function set u(value:Number):void 
	{
		_u = Math.min(Math.max(value, MIN_U), MAX_U);
	}
	
	private var _v:Number;
	
	public function get v():Number { return _v; }
	
	public function set v(value:Number):void 
	{
		_v = Math.min(Math.max(value, MIN_V), MAX_V);
	}
	
	private var _a:Number;
	
	public function get a():Number { return _a; }
	
	public function set a(value:Number):void 
	{
		_a = Math.min(Math.max(value, MIN_ALPHA), MAX_ALPHA);
	}
	
	public function YUVColor(y:Number, u:Number, v:Number, a:Number) 
	{
		super();
		this.y = y;
		this.u = u;
		this.v = v;
		this.a = a;
	}
	
	public function adjustY(yBy:Number):void
	{
		this.y += yBy;
	}
	
	public function adjustU(uBy:Number):void
	{
		this.u += uBy;
	}
	
	public function adjustV(vBy:Number):void
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
				return YUVColor.convertYUVToRGB(_y, _u, _v, _a);
			case ColorSpace.HSV:
				return YUVColor.convertYUVToRGB(_y, _u, _v, _a).convertTo(ColorSpace.HSV);
			case ColorSpace.HSL:
				return YUVColor.convertYUVToRGB(_y, _u, _v, _a).convertTo(ColorSpace.HSL);
			case ColorSpace.CMYK:
				return YUVColor.convertYUVToRGB(_y, _u, _v, _a).convertTo(ColorSpace.CMYK);
			case ColorSpace.YUV:
				return this.clone();
			case ColorSpace.CIE_LCH:
				return YUVColor.convertYUVToRGB(_y, _u, _v, _a).convertTo(ColorSpace.CIE_LCH);
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
		return new YUVColor(_y, _u, _v, _a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:YUVColor = object.convertTo(ColorSpace.YUV) as YUVColor;
		if (color.y == this._y && 
			color.u == this._u && 
			color.v == this._v && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(y="+_y+", u="+_u+", v="+_v+", a="+_a+")";
	}
	
	/**
	 * @inheritDoc
	 */
	public function valueOf():uint
	{
		return this.getColor32();
	}
	
	/**
	 * Converts a YUV based color to a RGB based color.
	 * RGB values are clampled to the range of 0-255.
	 * 
	 * @param y The Y component value. Must be in the [0, 255] interval.
	 * @param u The U component value. Must be in the [0, 255] interval.
	 * @param v The V component value. Must be in the [0, 255] interval.
	 * @return An object containing the RGB values - i.e : <code class="prettyprint">{r: 134, g:255, b:45}</code>.
	 */
	public static function convertYUVToRGB(y:Number, u:Number, v:Number, a:Number):RGBColor
	{
		var r:Number = y - 0.0009267*(u-128) + 1.4016868*(v-128);
		var g:Number = y - 0.3436954*(u-128) - 0.7141690*(v-128);
		var b:Number = y + 1.7721604*(u-128) + 0.0009902*(v-128);
		
		r = Math.min(Math.max(r, 0), 255);
		g = Math.min(Math.max(g, 0), 255);
		b = Math.min(Math.max(b, 0), 255);

		return new RGBColor(r, g, b, a);
	}
	
	
	
}
	
}
