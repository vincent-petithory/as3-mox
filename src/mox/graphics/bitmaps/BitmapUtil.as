/*
 * BitmapUtil.as
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
package mox.graphics.bitmaps 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.display.Sprite;
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
	public static function adapt(source:IBitmapDrawable, maxWidth:Number, maxHeight:Number, smooth:Boolean = false):BitmapData
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
		
		var bitmap:BitmapData = new BitmapData(bitmapData.width*drawRatio,bitmapData.height*drawRatio,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
	}
	public static function adaptForSize(source:IBitmapDrawable, availableSize:Number, smooth:Boolean = false):BitmapData
	{
		return adapt(source,availableSize,availableSize,smooth);
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
	public static function clip(source:IBitmapDrawable, width:Number, height:Number, smooth:Boolean = false):BitmapData
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
		
		var bitmap:BitmapData = new BitmapData(width,height,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
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
	public static function stretch(source:IBitmapDrawable, width:Number, height:Number, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = BitmapUtil.toBitmapData(source);
			
		var matrix:Matrix = new Matrix(width/bitmapData.width, 0, 0, height/bitmapData.height);
		var bitmap:BitmapData = new BitmapData(width,height,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
	}
	
	/**
	 * @param displayObject must have a graphics property
	 */
	public static function toDisplayObject(source:IBitmapDrawable, displayObject:DisplayObject):void
	{
		var bmp:BitmapData = toBitmapData(source);
		if (displayObject is Sprite || displayObject is Shape)
		{
			displayObject["graphics"].beginBitmapFill(bmp, new Matrix());
			displayObject["graphics"].drawRect(0, 0, bmp.width, bmp.height);
			displayObject["graphics"].endFill();
		}
		else if (displayObject is Bitmap)
		{
			(displayObject as Bitmap).bitmapData = bmp;
		}
	}
	
	/**
	 * Returns a bitmap of the provided object.
	 * @param source the graphic object.
	 * @return a bitmap data of the provided object
	 */
	public static function toBitmapData(source:IBitmapDrawable):BitmapData
	{
		var bitmapData:BitmapData;
		
		if (source is BitmapData)
		{
            return (source as BitmapData).clone();
		}
		else if (source is Bitmap)
		{
			return (source as Bitmap).bitmapData.clone();
		}
		else // it is a display object
		{
			bitmapData = new BitmapData((source as DisplayObject).width, (source as DisplayObject).height, true, 0x00000000);
			bitmapData.draw(source);
			return bitmapData;
		}
	}
	
	public static function horizontalMirror(source:IBitmapDrawable, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(-1, 0, 0, 1, bitmapData.width);
		
		var bitmap:BitmapData = new BitmapData(bitmapData.width,bitmapData.height,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
	}
	
	public static function verticalMirror(source:IBitmapDrawable, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(1, 0, 0, -1, 0, bitmapData.height);
		
		var bitmap:BitmapData = new BitmapData(bitmapData.width,bitmapData.height,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
	}
	
	public static function mirror(source:IBitmapDrawable, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var matrix:Matrix = new Matrix(-1, 0, 0, -1, bitmapData.width, bitmapData.height);
		
		var bitmap:BitmapData = new BitmapData(bitmapData.width,bitmapData.height,true,0x00000000);
        bitmap.draw(bitmapData,matrix,null,null,null,smooth);
        return bitmap;
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
	
	public static function leftHorizontalCut(source:IBitmapDrawable, xRatio:Number = 0.5, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var bitmap:BitmapData = new BitmapData(bitmapData.width*xRatio,bitmapData.height,true,0x00000000);
        bitmap.draw(bitmapData,new Matrix(),null,null,null,smooth);
        return bitmap;
	}
	
	public static function rightHorizontalCut(source:IBitmapDrawable, xRatio:Number = 0.5, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var indentMatrix:Matrix = new Matrix(1, 0, 0, 1, -bitmapData.width*xRatio, 0);
		var bitmap:BitmapData = new BitmapData(bitmapData.width*(1-xRatio),bitmapData.height,true,0x00000000);
        bitmap.draw(bitmapData,indentMatrix,null,null,null,smooth);
        return bitmap;
	}
	
	public static function topVerticalCut(source:IBitmapDrawable, yRatio:Number = 0.5, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var bitmap:BitmapData = new BitmapData(bitmapData.width,bitmapData.height*yRatio,true,0x00000000);
        bitmap.draw(bitmapData,new Matrix(),null,null,null,smooth);
        return bitmap;
	}
	
	public static function bottomVerticalCut(source:IBitmapDrawable, yRatio:Number = 0.5, smooth:Boolean = false):BitmapData
	{
		var bitmapData:BitmapData = toBitmapData(source);
		var indentMatrix:Matrix = new Matrix(1, 0, 0, 1, 0, -bitmapData.height*yRatio);
		var bitmap:BitmapData = new BitmapData(bitmapData.width,bitmapData.height*(1-yRatio),true,0x00000000);
        bitmap.draw(bitmapData,indentMatrix,null,null,null,smooth);
        return bitmap;
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
