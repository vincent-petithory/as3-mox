/*
 * ConsoleSkin.as
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
package mox.ui.skins 
{

    import mox.ui.BasicComponent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class ConsoleSkin extends BasicComponent implements IConsoleSkin 
    {
        public function ConsoleSkin()
        {
            super();
            this._textfield = new TextField();
            this.addChild(this._textfield);
            this._textfield.defaultTextFormat = new TextFormat("sans",10,0xFFFFFF);
        }
        
        private var _textfield:TextField;
        
        public function get textfield():TextField
        {
            return _textfield;
        }
        
        override public function refresh():void
        {
            this.graphics.clear();
            this.graphics.beginFill(0x333333);
            this.graphics.drawRect(0,0,this.width,this.height);
            this.graphics.endFill();
            
            this._textfield.x = 3;
            this._textfield.y = 3;
            this._textfield.width = this.width-6;
            this._textfield.height = this.height-6;
        }
        
    }
    
}
