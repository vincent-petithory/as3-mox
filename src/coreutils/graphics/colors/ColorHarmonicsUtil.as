package coreutils.graphics.colors 
{

public final class ColorHarmonicsUtil 
{
	
	public static function getNegative(color:uint):uint
	{
		return (color & 0xFF000000) + /* keep alpha */
			((0xff << 16) - (color & 0xff0000)) + /* red */
			((0xff << 8) - (color & 0xff00)) + /* green */
			((0xff) - (color & 0xff)); /* blue */
	}
	
}
	
}
