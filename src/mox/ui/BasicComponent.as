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
    import flash.display.DisplayObject;
    import mox.ui.skins.ISkin;
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
            this.setSize(value,this._height);
        }
        
        private var _height:Number = 0;
        
        override public function get height():Number
        {
            return this._height;
        }
        
        override public function set height(value:Number):void
        {
            this.setSize(this._width,value);
        }
        
        public function setSize(width:Number, height:Number):void
        {
            this._width = width;
            this._height = height;
            callLater(refresh);
        }
        
        public function refresh():void {}
        
        protected var dskin:DisplayObject;
        
        protected function setSkin(skin:ISkin):void
        {
            this.removeCurrentSkin();
            this.dskin = skin as DisplayObject;
            if (this.dskin == null)
                throw new Error("The skin is not a DisplayObject");
            this.addChildAt(this.dskin, 0);
            skin.host = this;
        }
        
        protected function removeCurrentSkin():void
        {
            if (this.dskin && this.contains.(this.dskin))
            {
                this.removeChild(this.dskin);
                (this.dskin as ISkin).host = null;
            }
        }
        
    }
    
}
