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
	
/**
 * The ColorMatrixUtils class allows fast creation of common matrixes used by the ColorMatrixFilter class.
 * 
 * <p>It also provides conversion between various color models and color matrixes concatenation.</p>
 * 
 * @see flash.filters.ColorMatrixFilter
 */
public final class ColorMatrixUtils
{
	
	/**
	 * @private
	 * The max value of a color channel.
	 */
	private static const CHANNEL_MAX_VALUE:uint = 255;
	
	/**
	 * The value used for the luminance of the Red Channel.
	 */
	public static const R_LUM:Number = 0.3086;
	
	/**
	 * The value used for the luminance of the Green Channel.
	 */
	public static const G_LUM:Number = 0.6094;
	
	/**
	 * The value used for the luminance of the Blue Channel.
	 */
	public static const B_LUM:Number = 0.0820;
	
	/**
	 * The identity colorMatrix.
	 */
	public static var IDENTITY:Array = new Array(1, 0, 0, 0, 0, 
												 0, 1, 0, 0, 0,
												 0, 0, 1, 0, 0,
												 0, 0, 0, 1, 0);
	
	/**
	* @private
	* Constructor.
	*/
	public function ColorMatrixUtils()
	{
		throw new ArgumentError("This class has only static members.");
	}
	
	/**
	 * Creates a colorMatrix for inverting image colors
	 * 
	 * @return the negative colorMatrix
	 */
	public static function createNegative():Array
	{
		var cm:Array = new Array();
		cm = cm.concat([-1, 0, 0, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE]);
		cm = cm.concat([0, -1, 0, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE]);
		cm = cm.concat([0, 0, -1, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that adjusts the lightness of a bitmap.
	 * 
	 * @param l the lightness to add to the bitmap.
	 * Values are expected between -100 and 100.
	 * @return the lightening or darkening colorMatrix.
	 */
	public static function adjustLightness(l:Number):Array
	{
		if (l < -100)
		{
			l = -100;
		}
		else if (l > 100)
		{
			l = 100;
		}
		
		l /= 100;
		
		var cm:Array = new Array();
		cm = cm.concat([1, 0, 0, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE*l]);
		cm = cm.concat([0, 1, 0, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE*l]);
		cm = cm.concat([0, 0, 1, 0, ColorMatrixUtils.CHANNEL_MAX_VALUE*l]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that adjusts the saturation of a bitmap.
	 * 
	 * @param s the saturation to add to the bitmap.
	 * Typically, values are between 0 and 200, but values out of this range are possible.
	 * @return the saturation modifying colorMatrix.
	 */
	public static function adjustSaturation(s:Number):Array
	{
		s /= 100;
		
		var cm:Array = new Array();
		cm = cm.concat([(1-s)*R_LUM + s, (1-s)*G_LUM, (1-s)*B_LUM, 0, 0]);
		cm = cm.concat([(1-s)*R_LUM, (1-s)*G_LUM + s, (1-s)*B_LUM, 0, 0]);
		cm = cm.concat([(1-s)*R_LUM, (1-s)*G_LUM, (1-s)*B_LUM + s, 0, 0]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that adjusts the hue of a bitmap.
	 * 
	 * @param h The hue of the bitmap.
	 * h values are expected between -180° and 180°.
	 * @return the hue modifying colorMatrix.
	 */
	public static function adjustHue(h:Number):Array
	{
		h *= Math.PI/180;
		var c:Number = Math.cos(h);
		var s:Number = Math.sin(h);
		
		var r0:Number = R_LUM + c*(1-R_LUM) - s*R_LUM;
		var g0:Number = G_LUM - c*G_LUM - s*G_LUM;
		var b0:Number = B_LUM - c*B_LUM + s*(1-B_LUM);
		
		var r1:Number = R_LUM - c*R_LUM + s*0.143;
		var g1:Number = G_LUM + c*(1-G_LUM) + s*0.14;
		var b1:Number = B_LUM - c*B_LUM - s*0.283;
		
		var r2:Number = R_LUM - c*R_LUM - s*(1- R_LUM);
		var g2:Number = G_LUM - c*G_LUM + s*G_LUM;
		var b2:Number = B_LUM + c*(1-B_LUM) + s*B_LUM;
		
		var cm:Array = new Array();
		cm = cm.concat([r0, g0, b0, 0, 0]);
		cm = cm.concat([r1, g1, b1, 0, 0]);
		cm = cm.concat([r2, g2, b2, 0, 0]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that adjusts the contrast of a bitmap.
	 * 
	 * @param contrast The contrast of the bitmap.
	 * Typical values are expected between -100 and +INF.
	 * @return the contrast modifying colorMatrix.
	 */
	public static function adjustContrast(contrast:Number):Array
	{
		contrast /= 100;
		
		var cm:Array = new Array();
		cm = cm.concat([(1+contrast), 0, 0, 0, 128*contrast]);
		cm = cm.concat([0, (1+contrast), 0, 0, 128*contrast]);
		cm = cm.concat([0, 0, (1+contrast), 0, 128*contrast]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a custom color balance color matrix that modifies the colors of a bitmap.
	 * Actually, it behaves like a channel mixer rather than a color balance.
	 * 
	 * @param redCyanLevel The level of red (RGB) or its completementary color (cyan - CMYK) to add.
	 * Value between -100 and 100.
	 * @param magentaGreenLevel The level of green (RGB) or its completementary color (magenta - CMYK) to add.
	 * Value between -100 and 100.
	 * @param yellowBlueLevel The level of blue (RGB) or its completementary color (yellow - CMYK) to add.
	 * Value between -100 and 100.
	 * @return A colorMatrix that performs the balance color changes.
	 */
	public static function createColorBalance(redCyanLevel:Number, magentaGreenLevel:Number, yellowBlueLevel:Number):Array
	{
		redCyanLevel /= 100;
		magentaGreenLevel /= 100;
		yellowBlueLevel /= 100;
		
		var cm:Array = new Array();
		
		cm = cm.concat([(1+Math.pow(redCyanLevel,3)), Math.pow(redCyanLevel,3), Math.pow(redCyanLevel,3), 0, 0]);
		cm = cm.concat([Math.pow(magentaGreenLevel,3), (1+Math.pow(magentaGreenLevel,3)), Math.pow(magentaGreenLevel,3), 0, 0]);
		cm = cm.concat([Math.pow(yellowBlueLevel,3), Math.pow(yellowBlueLevel,3), (1+Math.pow(yellowBlueLevel,3)), 0, 0]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that adjusts the alpha of a bitmap.
	 * 
	 * @param alpha The alpha of the bitmap.
	 * @return The colorMatrix that performs the changes on the alpha.
	 */
	public static function adjustAlpha(alpha:Number):Array
	{
		var cm:Array = new Array();
		cm = cm.concat([1, 0, 0, 0, 0]);
		cm = cm.concat([0, 1, 0, 0, 0]);
		cm = cm.concat([0, 0, 1, 0, 0]);
		cm = cm.concat([0, 0, 0, alpha, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that enables or disables the channels of a bitmap.
	 * 
	 * @param useRed Determines if the red channel is enabled.
	 * @param useGreen Determines if the green channel is enabled.
	 * @param useBlue Determines if the blue channel is enabled.
	 * @param useAlpha Determines if the alpha channel is enabled.
	 * @return The colorMatrix that performs the changes on channels.
	 */
	public static function setChannels(useRed:Boolean, useGreen:Boolean, useBlue:Boolean, useAlpha:Boolean):Array
	{
		var r:int = useRed ? 1 : 0;
		var g:int = useGreen ? 1 : 0;
		var b:int = useBlue ? 1 : 0;
		var a:int = useAlpha ? 1 : 0;
		
		var cm:Array = new Array();
		cm = cm.concat([r, 0, 0, 0, 0]);
		cm = cm.concat([0, g, 0, 0, 0]);
		cm = cm.concat([0, 0, b, 0, 0]);
		cm = cm.concat([0, 0, 0, a, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix for turning an image into grayscale.
	 * 
	 * @return The grayscale colorMatrix.
	 */
	public static function createGrayScale():Array
	{
		var cm:Array = new Array();
		cm = cm.concat([R_LUM, G_LUM, B_LUM, 0, 0]);
		cm = cm.concat([R_LUM, G_LUM, B_LUM, 0, 0]);
		cm = cm.concat([R_LUM, G_LUM, B_LUM, 0, 0]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that will give the Y component of the YUV Model.
	 * It is quite the same effect of the <code class="prettyprint">createGrayScale</code> method, 
	 * except this one uses values that correctly fits with those of the U and V color matrixes.
	 * 
	 * @return The Y  colorMatrix.
	 * 
	 * @see ColorMatrixUtils#createGrayScale()
	 * 
	 */
	public static function createYLuminance():Array
	{
		var cm:Array = new Array();
		cm = cm.concat([0.299, 0.587, 0.114, 0, 0]);
		cm = cm.concat([0.299, 0.587, 0.114, 0, 0]);
		cm = cm.concat([0.299, 0.587, 0.114, 0, 0]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that will give the U component of the YUV Model.
	 * Its values fit with those of the Y and V color matrixes.
	 * 
	 * @return The U  colorMatrix.
	 */
	public static function createUChrominance():Array
	{
		var cm:Array = new Array();
		cm = cm.concat([-0.169, -0.331, 0.500, 0, 128]);
		cm = cm.concat([-0.169, -0.331, 0.500, 0, 128]);
		cm = cm.concat([-0.169, -0.331, 0.500, 0, 128]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Creates a colorMatrix that will give the V component of the YUV Model.
	 * Its values fit with those of the Y and U color matrixes.
	 * 
	 * @return The V colorMatrix.
	 */
	public static function createVChrominance():Array
	{
		var cm:Array = new Array();
		cm = cm.concat([0.500, -0.419, -0.081, 0, 128]);
		cm = cm.concat([0.500, -0.419, -0.081, 0, 128]);
		cm = cm.concat([0.500, -0.419, -0.081, 0, 128]);
		cm = cm.concat([0, 0, 0, 1, 0]);
		
		return cm;
	}
	
	/**
	 * Concatens two color matrixes and returns the results of the concatenation.
	 * 
	 * @param matrix The color matrix bringing modifications.
	 * @param originalMatrix The color matrix containing previous informations.
	 * @return The resulting array representing the concatened color matrix.
	 */
	public static function concatColorMatrix(matrix:Array, originalMatrix:Array):Array
	{
		
		var temp:Array = new Array ();
		var i:int = 0;
		
		for (var y:int = 0; y < 4; y++ )
		{
			
			for (var x:int = 0; x < 5; x++ )
			{
				temp[i + x] = matrix[i] * originalMatrix[x] + 
							  matrix[i+1] * originalMatrix[x+5] + 
							  matrix[i+2] * originalMatrix[x+10] + 
							  matrix[i+3] * originalMatrix[x+15] +
							  (x == 4 ? matrix[i+4] : 0);
			}
			i+=5;
		}
		
		return temp;
		
	}
	
	/**
	 * Easy-to-use routine to create a colorMatrix array that the colorMatrixFilter class expects.
	 * 
	 * @param line1 The array representing the 1st line. Clamped to 5 elements if contains more.
	 * @param line2 The array representing the 2nd line. Clamped to 5 elements if contains more.
	 * @param line3 The array representing the 3rd line. Clamped to 5 elements if contains more.
	 * @param line4 The array representing the 4th line. Clamped to 5 elements if contains more.
	 * @return The colorMatrix array resulting of the fourth lines.
	 */
	public static function createColorMatrix(line1:Array, line2:Array, line3:Array, line4:Array):Array
	{
		while (line1.length > 5)
		{
			line1.pop();
		}
		while (line2.length > 5)
		{
			line2.pop();
		}
		while (line3.length > 5)
		{
			line3.pop();
		}
		while (line4.length > 5)
		{
			line4.pop();
		}
		
		var colorMatrix:Array = new Array();
		colorMatrix = colorMatrix.concat(line1, line2, line3, line4);
		
		return colorMatrix;
	}
	
}
}
