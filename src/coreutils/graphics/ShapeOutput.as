package coreutils.graphics 
{
    
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class ShapeOutput extends Shape implements IBitmapOutput 
    {
        public function ShapeOutput()
        {
            super();
        }
        
        public function drawBitmap(source:BitmapData, matrix:Matrix, width:Number,height:Number,smooth:Boolean):void
        {
            
        }
        
    }
    
}
