package 
{

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import flash.events.Event;
    
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    import tinker.getClassName;
    
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
            this.addEventListener(Event.RESIZE, onResize);
            
            textfield.appendText("**** Tinker library sample '"+sampleName+"' ****\n\n");
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
