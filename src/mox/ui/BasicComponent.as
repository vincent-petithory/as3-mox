/*
 * BasicComponent.as
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
package mox.ui  
{

    import flash.display.Sprite;
    import mox.callLater;

    public class BasicComponent extends Sprite 
    {
        public function BasicComponent()
        {
            super();
        }
        
        private var _width:Number = 0;
        
        override public function get width():Number
        {
            return this._width;
        }
        
        override public function set width(value:Number):void
        {
            this._width = value;
            callLater(refresh);
        }
        
        private var _height:Number = 0;
        
        override public function get height():Number
        {
            return this._height;
        }
        
        override public function set height(value:Number):void
        {
            this._height = value;
            callLater(refresh);
        }
        
        public function refresh():void {}
        
    }
    
}
