/*
 * SampleBase.as
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
package 
{

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import flash.events.Event;
    
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    import mox.reflect.getClassName;
    import mox.ui.Console;
    import mox.ui.skins.ConsoleSkin;
    
    public class SampleBase extends Sprite 
    {
    
        private var console:Console;
    
        public function SampleBase()
        {
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.console = new Console(new ConsoleSkin());
            addChild(this.console);
            this.pack();
            
            var sampleName:String = getClassName(this);
            this.console.println("**** Mox library sample '"+sampleName+"' ****");
            this.console.println("");
            this.console.headerLog = sampleName;
            this.stage.addEventListener(Event.RESIZE, onResize);
        }
        
        public function println(...args):void
        {
            this.console.println.apply(this.console, args);
        }
        
        public function pack():void
        {
            this.console.width = stage.stageWidth;
            this.console.height = stage.stageHeight;
        }
        
        private function onResize(event:Event):void
        {
            this.pack();
        }
        
    }
    
}
