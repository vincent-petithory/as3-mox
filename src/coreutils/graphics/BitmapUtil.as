///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 Vincent Petithory - http://blog.lunar-dev.net/
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

package coreutils.graphics 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.filters.BitmapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

public final class BitmapUtil 
{
	
	/**
	 * Resizes the image to fit the provided dimensions as good as possible, 
	 * while maintaining the original aspect ratio
	 * The source remains unaltered.
	 * 
	 * <p>The output image has a width lesser or equal to <code class="prettyprint">maxWidth</code> 
	 * and a height lesser or equal to <code class="prettyprint">maxHeight</code>.</p>
	 * 
	 * @param source the image to process.
	 * @param maxWidth the maximum width the output image should have.
	 * @param maxHeight the maximum height the output image should have.
	 * @param smooth set to <code class="prettyprint">true</code> to enable smoothing during process.
	 * @return the resized image.
	 */
	public static function adapt(source:IBitmapDrawable, output:IBitmapOutput, maxWidth:Number, maxHeight:Number, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = BitmapUtil.toBitmapData(source);
			
		var matrix:Matrix;
		
		var wRatio:Number = maxWidth / bitmapData.width;
		var hRatio:Number = maxHeight / bitmapData.height;
		
		var drawRatio:Number;
		
		if (bitmapData.width * hRatio <= maxWidth)
		{
			drawRatio = hRatio;
		}
		else if (bitmapData.height * wRatio <= maxHeight)
		{
			drawRatio = wRatio;
		}
		
		matrix = new Matrix(drawRatio, 0, 0, drawRatio);
		output.drawBitmap(bitmapData,matrix,bitmapData.width*drawRatio,bitmapData.height*drawRatio,smooth);
	}
	public static function adaptForSize(source:IBitmapDrawable, output:IBitmapOutput, availableSize:Number, smooth:Boolean = false):void
	{
		adapt(source,output,availableSize,availableSize,smooth);
	}
	
	/**
	 * Resizes then clips the provided source to fit the provided dimensions without distortion.
	 * The source remains unaltered.
	 * 
	 * <p>The source image is first resized to fit the provided dimensions as good as possible. 
	 * Then the content is clipped to fit the provided dimensions.</p>
	 * 
	 * @param source the image to process.
	 * @param width the width of the output image.
	 * @param height the height of the output image.
	 * @param smooth set to <code class="prettyprint">true</code> to enable smoothing during process.
	 * @return the resized image.
	 */
	public static function clip(source:IBitmapDrawable, output:IBitmapOutput, width:Number, height:Number, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = BitmapUtil.toBitmapData(source);
			
		var inRatio:Number = bitmapData.width / bitmapData.height;
		var outRatio:Number = width / height;
		var matrix:Matrix;
		
		if (inRatio >= outRatio)
		{
			matrix = new Matrix(height/bitmapData.height, 0, 0, height/bitmapData.height);
		}
		else if (inRatio < outRatio)
		{
			matrix = new Matrix(width/bitmapData.width, 0, 0, width/bitmapData.width);
		}
		
		output.drawBitmap(bitmapData,matrix,width,height,smooth);
	}
	
	public static function toDisplayObject(source:IBitmapDrawable):DisplayObject
	{
		var bmp:BitmapData = toBitmapData(source);
		var s:Shape = new Shape();
		s.graphics.beginBitmapFill(bmp, new Matrix());
		s.graphics.drawRect(0, 0, bmp.width, bmp.height);
		s.graphics.endFill();
		return s;
	}
	
	/**
	 * Returns a bitmap of the provided object.
	 * @param source the graphic object.
	 * @return a bitmap data of the provided object
	 */
	public static function toBitmapData(source:IBitmapDrawable, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData;
		
		if (source is BitmapData)
		{
            bitmapData = source as BitmapData;
		    bitmapData = new BitmapData(bitmapData.width, bitmapData.height, bitmapData.transparent, 0x00000000);
			bitmapData.draw(source,null,null,null,null,smooth);
			return (source as BitmapData).clone();
		}
		else if (source is Bitmap)
		{
			return toBitmapData((source as Bitmap).bitmapData,smooth);
		}
		else // it is a display object
		{
			bitmapData = new BitmapData((source as DisplayObject).width, (source as DisplayObject).height, true, 0x00000000);
			bitmapData.draw(source,null,null,null,null,smooth);
			return bitmapData;
		}
	}
	
	/**
	 * Resizes the provided source to fit the provided dimensions. Images may have distortions after this.
	 * The source remains unaltered.
	 * 
	 * @param source the image to process.
	 * @param width the width of the output image.
	 * @param height the height of the output image.
	 * @param smooth set to <code class="prettyprint">true</code> to enable smoothing during process.
	 * @return the resized image.
	 */
	public static function stretch(source:IBitmapDrawable, output:IBitmapOutput, width:Number, height:Number, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = BitmapUtil.toBitmapData(source);
			
		var matrix:Matrix = new Matrix(width/bitmapData.width, 0, 0, height/bitmapData.height);
		output.drawBitmap(bitmapData,matrix,width,height,smooth);
	}
	
	public static function horizontalMirror(source:IBitmapDrawable, output:IBitmapOutput, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(-1, 0, 0, 1, bitmapData.width);
		
		output.drawBitmap(bitmapData,matrix,bitmapData.width,bitmapData.height,smooth);
	}
	
	public static function verticalMirror(source:IBitmapDrawable, output:IBitmapOutput, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(1, 0, 0, -1, 0, bitmapData.height);
		
		output.drawBitmap(bitmapData,matrix,bitmapData.width,bitmapData.height,smooth);
	}
	
	public static function mirror(source:IBitmapDrawable, output:IBitmapOutput, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(-1, 0, 0, -1, bitmapData.width, bitmapData.height);
		
		output.drawBitmap(bitmapData,matrix,bitmapData.width,bitmapData.height,smooth);
	}
	
	/**
	 * Performs an offset filter effect.
	 * It looks like the one you have in Photoshop.
	 * 
	 * @param source The bitmapData we want the filter to be applied.
	 * @param xRatio The x-percent offset.
	 * @param yRatio The y-percent offset.
	 * @return The offset bitmapData.
	 */
	public static function offset(source:BitmapData, xRatio:Number = 0, yRatio:Number = 0):BitmapData
	{
		var copy:BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
		var w:Number = source.width;
		var h:Number = source.height;
		
		xRatio = xRatio - Math.floor(xRatio);
		yRatio = yRatio - Math.floor(yRatio);
		
		// parts below are source parts.
		
		if (yRatio == 0 && xRatio != 0)
		{
			// x-axis offset.
			// left part
			copy.copyPixels(source, new Rectangle(0, 0, w * (1 - xRatio), h), new Point(w * xRatio, 0));
			
			// right part
			copy.copyPixels(source, new Rectangle(w * (1 - xRatio), 0, w * xRatio, h), new Point(0, 0));
		}
		else if (xRatio == 0 && yRatio != 0)
		{
			// y-axis offset
			// top part
			copy.copyPixels(source, new Rectangle(0, 0, w, h * (1 - yRatio)), new Point(0, h * yRatio));
			
			// bottom part
			copy.copyPixels(source, new Rectangle(0, h * (1 - yRatio), w, h * yRatio), new Point(0, 0));
		}
		else if (xRatio == 0 && yRatio == 0)
		{
			// No treatment
		}
		else // xRatio != 0 && yRatio != 0
		{
			// Both axis
			// left-top part
			copy.copyPixels(source, new Rectangle(0, 0, w * (1 - xRatio), h * (1 - yRatio)), new Point(w * xRatio, h * yRatio));
			
			// right-top part
			copy.copyPixels(source, new Rectangle(w * (1 - xRatio), 0, w * xRatio, h * (1 - yRatio)), new Point(0, h * yRatio));
			
			// left-bottom part
			copy.copyPixels(source, new Rectangle(0, h * (1 - yRatio), w * (1 - xRatio), h * yRatio), new Point(w * xRatio, 0));
			
			// right-bottom part
			copy.copyPixels(source, new Rectangle(w * (1 - xRatio), h * (1 - yRatio), w * xRatio, h * yRatio), new Point(0, 0));
		}
		
		return copy;
	}
	
	public static function leftHorizontalCut(source:IBitmapDrawable, output:IBitmapOutput, xRatio:Number = 0.5, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		output.drawBitmap(bitmapData,new Matrix(),bitmapData.width*xRatio,bitmapData.height,smooth);
	}
	
	public static function rightHorizontalCut(source:IBitmapDrawable, output:IBitmapOutput, xRatio:Number = 0.5, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var indentMatrix:Matrix = new Matrix(1, 0, 0, 1, -bitmapData.width*xRatio, 0);
		output.drawBitmap(bitmapData, indentMatrix, bitmapData.width*(1-xRatio), bitmapData.height, smooth);
	}
	
	public static function topVerticalCut(source:IBitmapDrawable, output:IBitmapOutput, yRatio:Number = 0.5, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		output.drawBitmap(bitmapData, new Matrix(), bitmapData.width, bitmapData.height*yRatio, smooth);
	}
	
	public static function bottomVerticalCut(source:IBitmapDrawable, output:IBitmapOutput, yRatio:Number = 0.5, smooth:Boolean = false):void
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var indentMatrix:Matrix = new Matrix(1, 0, 0, 1, 0, -bitmapData.height*yRatio);
		output.drawBitmap(bitmapData, indentMatrix, bitmapData.width, bitmapData.height*(1-yRatio), smooth);
	}
	
	public static function applyFilter(targetBitmapData:BitmapData, sourceBitmapData:BitmapData, sourceRect:Rectangle, destPoint:Point, filter:BitmapFilter):BitmapData
	{
		var filterRect:Rectangle = targetBitmapData.generateFilterRect(sourceRect,filter);
		var wc:Number = Math.max(0,filterRect.width - sourceRect.width);
		var hc:Number = Math.max(0,filterRect.height - sourceRect.height);
		var w:Number = wc+targetBitmapData.width;
		var h:Number = hc+targetBitmapData.height;
		var offset:Point = new Point(wc/2,hc/2);
		
		var filteredBmp:BitmapData = new BitmapData(w, h, true, 0x00000000);
		filteredBmp.copyPixels(targetBitmapData, targetBitmapData.rect, offset);
		filteredBmp.applyFilter(sourceBitmapData,sourceRect,destPoint.add(offset),filter);
		return filteredBmp;
	}
}
	
}
