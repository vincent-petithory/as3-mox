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
    
    public class SampleBase extends Sprite 
    {
    
        private var textfield:TextField;
    
        public function SampleBase()
        {
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            textfield = new TextField();
            addChild(textfield);
            textfield.selectable = true;
            textfield.defaultTextFormat = new TextFormat("sans",10,0xFFFFFF);
            this.pack();
            
            sampleName = getClassName(this);
            prefix = "["+sampleName+"] ";
            this.stage.addEventListener(Event.RESIZE, onResize);
            
            textfield.appendText("**** Mox library sample '"+sampleName+"' ****\n\n");
        }
        
        private var sampleName:String;
        private var prefix:String;
        
        public function println(...args):void
        {
            var str:String = "";
            for each (var arg:* in args)
            {
                str += String(arg)+",";
            }
            str = str.substr(0,str.length-1);
            trace(prefix+str);
            textfield.appendText(prefix);
            var lineStartIndex:int = textfield.text.lastIndexOf(prefix);
            textfield.setTextFormat(
                new TextFormat("sans",10,0x6699FF), 
                lineStartIndex, 
                lineStartIndex + prefix.length - 1 
            );
            textfield.appendText(str+"\n");
        }
        
        public function pack():void
        {
            this.graphics.clear();
            this.graphics.beginFill(0x333333);
            this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
            this.graphics.endFill();
            
            textfield.x = 3;
            textfield.y = 3;
            textfield.width = stage.stageWidth-6;
            textfield.height = stage.stageHeight-6;
        }
        
        private function onResize(event:Event):void
        {
            this.pack();
        }
        
    }
    
}
