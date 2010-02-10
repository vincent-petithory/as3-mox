package mox.ui 
{

public class DragData 
{
	
	public function DragData() 
	{
		super();
		_content = new Object();
	}
	
	private var _content:Object;
	
	public function hasFormat(format:String, times:uint = 1):Boolean
	{
	    var esc:String = escape(format);
		return  _content[esc] != undefined && 
		        _content[esc].length >= times;
	}
	
	public function setData(format:String, data:Object):void
	{
		if (!hasFormat(format))
		{
			_content[escape(format)] = new Array();
		}
		_content[escape(format)].push(data);
	}
	
	public function getData(format:String):Array
	{
		if (hasFormat(format))
		{
			return _content[escape(format)].slice();
		}
		else
		{
			return null;
		}
	}
	
	public function clearData(format:String):void
	{
		if (hasFormat(format))
		{
			delete _content[escape(format)];
		}
	}
	
	public function get formats():Array
	{
		var formats:Array = new Array();
		for (var format:String in _content)
		{
			formats.push(unescape(format));
		}
		return formats;
	}
	
	public function clear():void
	{
		_content = new Object();
	}
	
	public static const EMPTY:DragData = new DragData();
	
	
}
	
}
