/*
 * MovieClipOutput.as
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
package tinker.graphics.outputs 
{
    import flash.display.MovieClip;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    import tinker.graphics.IBitmapOutput;

    public class MovieClipOutput extends MovieClip implements IBitmapOutput 
    {
        public function drawBitmap(source:BitmapData, matrix:Matrix, width:Number,height:Number,smooth:Boolean):void
        {
            this.graphics.beginBitmapFill(source, matrix, false, smooth);
		    this.graphics.drawRect(0, 0, width, height);
		    this.graphics.endFill();
        }
        
    }
    
}