package coreutils.graphics 
{

    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.geom.Matrix;
    

    public interface IBitmapOutput extends IBitmapDrawable
    {
        function drawBitmap(source:BitmapData, matrix:Matrix, width:Number,height:Number,smooth:Boolean):void;
    }
    
}

