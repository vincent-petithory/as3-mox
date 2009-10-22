/*
 * CieLCHColor.as
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


public class CieLCHColor implements IColor
{
	
	//------------------------------
	//
	// Class members
	//
	//------------------------------
	
	public static const MIN_HUE:uint = 0;
	public static const MAX_HUE:uint = 360;
	public static const MIN_CHROMA:uint = 0;
	public static const MAX_CHROMA:uint = 100;
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
	public static function createFromHexa(color:uint):CieLCHColor
	{
		return RGBColor.createFromHexa(color).convertTo(ColorSpace.CIE_LCH) as CieLCHColor;
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
	
	private var _c:Number;
	
	public function get c():Number { return _c; }
	
	public function set c(value:Number):void {
		_c = Math.min(Math.max(value, MIN_CHROMA), MAX_CHROMA);
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
	 * @param l The lightness value. Must be in the [0, 100] interval.
	 * @param c The chroma value. Must be in the [0, 100] interval.
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param a The Alpha value. Must be in the [0, 255] interval.
	 */
	public function CieLCHColor(l:Number = 0, c:Number = 0, h:Number = 0, a:Number = 255) 
	{
		super();
		this.l = l;
		this.c = c;
		this.h = h;
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
	
	public function adjustChroma(cBy:Number):void
	{
		this.c += cBy;
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
				return CieLCHColor.convertLCHToRGB(_l, _c, _h, _a);
			case ColorSpace.HSV:
				return CieLCHColor.convertLCHToRGB(_l, _c, _h, _a).convertTo(ColorSpace.HSV);
			case ColorSpace.HSL:
				return CieLCHColor.convertLCHToRGB(_l, _c, _h, _a).convertTo(ColorSpace.HSL);
			case ColorSpace.CMYK:
				return CieLCHColor.convertLCHToRGB(_l, _c, _h, _a).convertTo(ColorSpace.CMYK);
			case ColorSpace.YUV:
				return CieLCHColor.convertLCHToRGB(_l, _c, _h, _a).convertTo(ColorSpace.YUV);
			case ColorSpace.CIE_LCH:
				return this.clone();
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
		return new CieLCHColor(_h, _c, _l, _a);
	}
	
	public function equals(object:IColor):Boolean
	{
		var color:CieLCHColor = object.convertTo(ColorSpace.CIE_LCH) as CieLCHColor;
		if (color.h == this._h && 
			color.c == this._c && 
			color.l == this._l && 
			color.a == this._a)
		{
			return true;
		}
		return false;
	}
	
	public function toString():String
	{
		return "(l="+_l+", c="+_c+", h="+_h+", a="+_a+")";
	}
	
	/**
	 * @inheritDoc
	 */
	public function valueOf():uint
	{
		return this.getColor32();
	}
	
	private static const LIM:Number = 0.0031308;
    private static const LIM2:Number = 0.008856;
    private static const DIV16:Number = 16.0/116.0;
    private static const DIV7:Number = 1.0/7.787;
    private static const ADD0:Number = 0.055;
    private static const MULT1:Number = 1.055;
    private static const MULT2:Number = 12.92;
    private static const POW:Number = 1.0/2.4;
    
    private static const REF_X:Number = 95.047;
    private static const REF_Y:Number = 100.0;
    private static const REF_Z:Number = 108.883;
	
	/**
	 * Converts a Cie L*C*H° based color to a RGB based color.
	 * RGB values are returned in [0, 255] X [0, 255] X [0, 255].
	 * 
	 * @param l The lightness value. Must be in the [0, 100] interval.
	 * @param c The chroma value. Must be in the [0, 100] interval.
	 * @param h The hue value. Must be in the [0, 360] interval.
	 * @param a The alpha value. Must be in the [0, 255] interval.
	 * @return An object containing RGB values - i.e : <code class="prettyprint">{r: 134, g:255, b:45}</code>.
	 */
	private static function convertLCHToRGB(l:Number, c:Number, h:Number, a:Number):RGBColor
	{
		var l2:Number = l;
		var a2:Number = c*Math.cos(h*Math.PI/180);
		var b2:Number = h*Math.sin(h*Math.PI/180)*100/360;
        
        
        
        var y:Number = l2/116.0 + DIV16;
        var x:Number = y+a2/500.0;
		var z:Number = b2/200.0;
       
		var x3:Number = x*x*x;
		var y3:Number = y*y*y;
		var z3:Number = z*z*z;
        
        if (x3 > LIM2)
            x = x3;
        else
            x = (x-DIV16)*DIV7;
        if (y3 > LIM2)
            y = y3;
        else
            y = (y-DIV16)*DIV7;
        if (z3 > LIM2)
           z = z3;
        else
            z = (z-DIV16)*DIV7;
        
        x *= REF_X/100;
        y *= REF_Y/100;
        z *= REF_Z/100;
        
		var r:Number = 3.2406*x + -1.5372*y + -0.4986*z;
		var g:Number = -0.9689*x + 1.8758*y + 0.0415*z;
		var b:Number = 0.0557*x + -0.2040*y + 1.0570*z;
        
        if (r>LIM)
            r = MULT1*Math.pow(r,POW)-ADD0;
        else
            r = MULT2*r;
        
        if (g>LIM)
            g = MULT1*Math.pow(g,POW)-ADD0;
        else
            g = MULT2*g;
            
        if (b>LIM)
            b = MULT1*Math.pow(b,POW)-ADD0;
        else
            b = MULT2*b;
        
        return new RGBColor(r*RGBColor.CHANNEL_MAX_VALUE,g*RGBColor.CHANNEL_MAX_VALUE,b*RGBColor.CHANNEL_MAX_VALUE,a);
	}
	
}
	
}
