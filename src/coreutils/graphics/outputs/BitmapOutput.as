package coreutils.graphics.outputs 
{
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    import coreutils.graphics.IBitmapOutput;

    public class BitmapOutput extends Bitmap implements IBitmapOutput 
    {
        
        public function drawBitmap(source:BitmapData, matrix:Matrix, width:Number,height:Number,smooth:Boolean):void
        {
            var bitmap:BitmapData = new BitmapData(width,height,true,0x00000000);
            bitmap.draw(source,matrix,null,null,null,smooth);
            this.bitmapData = bitmap;
        }
        
    }
    
}
