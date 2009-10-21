package coreutils.graphics.outputs 
{
    
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    import coreutils.graphics.IBitmapOutput;

    public class ShapeOutput extends Shape implements IBitmapOutput 
    {
        
        public function drawBitmap(source:BitmapData, matrix:Matrix, width:Number,height:Number,smooth:Boolean):void
        {
            this.graphics.beginBitmapFill(source, matrix, false, smooth);
		    this.graphics.drawRect(0, 0, width, height);
		    this.graphics.endFill();
        }
        
    }
    
}
