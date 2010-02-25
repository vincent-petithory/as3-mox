/*
 * Console.as
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
    
    import mox.ui.skins.IConsoleSkin;
    import flash.display.DisplayObject;
    
    public class Console extends BasicComponent  
    {
    
        public function Console(skin:IConsoleSkin)
        {
            super();
            this.skin = skin;
        }
        
        private var dskin:DisplayObject;
        private var _skin:IConsoleSkin;
        
        public function get skin():IConsoleSkin
        {
            return _skin;
        }
        
        public function set skin(value:IConsoleSkin):void
        {
            if (this._skin != value)
            {
                if (this.dskin)
                    this.removeChild(this.dskin);
                this._skin = value;
                this.dskin = this._skin as DisplayObject;
                if (this.dskin == null)
                    throw new Error("The skin is not a DisplayObject");
                this.addChildAt(this.dskin ,0);
            }
        }
        
        private var _headerLog:String;
        
        public function get headerLog():String
        {
            return _headerLog;
        }
        
        public function set headerLog(value:String):void
        {
            this._headerLog = value;
            if (value && value != "")
                this.prefix = "["+this._headerLog+"] ";
            else
                this.prefix = "";
        }
        
        private var prefix:String = "";
        
        public function println(...args):void
        {
            var str:String = "";
            for each (var arg:* in args)
            {
                str += String(arg)+",";
            }
            str = str.substr(0,str.length-1);
            trace(prefix+str);
            this._skin.textfield.appendText(prefix+str+"\n");
        }
        
        override public function refresh():void
        {
            if (this._skin)
            {
                this.dskin.width = this.width;
                this.dskin.height = this.height;
            }
        }
        
    }
    
}
