/*
 * callLater.as
 * This file is part of Tinker
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * Tinker is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Tinker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Tinker; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package tinker 
{
	
	import flash.events.Event;
	
	/**
	 * Calls the specified function on the next frame. 
	 * You may pass the object of the 
	 * <code class="prettyprint">this</code> keyword of 
	 * the function references using the 
	 * <code class="prettyprint">thisArg</code> parameter. 
	 * However, if the function is a method closure 
	 * (a method defined in a class), then the 
	 * <code class="prettyprint">thisArg</code> 
	 * parameter is ignored.
	 * @param closure the method to call on the next frame.
	 * @param thisArg the object the this keyword of the function references.
	 * @param ...args the arguments to pass to the function.
	 */
	public const callLater:Function = function(closure:Function, thisArg:* = undefined, ...args):void 
	{
		if (callLaterObjs == null)
		{
			callLaterObjs = new Vector.<CallLaterObj>();
		}
		
		var shouldAdd:Boolean = true;
		var clo:CallLaterObj;
		for each (clo in callLaterObjs)
		{
			if (clo.closure == closure)
			{
				shouldAdd = false;
				break;
			}
		}
		if (shouldAdd)
		{
			callLaterObjs.push(new CallLaterObj(closure, thisArg, args));
		}
		
		innerObj.addEventListener(Event.ENTER_FRAME, onCallLaterClosure);
	}
	
}
import flash.display.Shape;
import flash.events.Event;

/**
 * @private
 */
internal var innerObj:Shape = new Shape();

/**
 * @private
 */
internal var callLaterObjs:Vector.<CallLaterObj>;

/**
 * @private
 */
internal function onCallLaterClosure(event:Event):void 
{
	innerObj.removeEventListener(Event.ENTER_FRAME, onCallLaterClosure);
	for each (var closure:CallLaterObj in callLaterObjs)
	{
		closure.apply();
	}
	callLaterObjs = null;
}

/**
 * @private
 */
internal class CallLaterObj
{
	
	public var closure:Function;
	public var args:Array;
	public var thisArg:*;
	
	public function CallLaterObj(closure:Function = null, thisArg:* = null, args:Array = null)
	{
		this.closure = closure;
		this.thisArg = thisArg;
		if (args == null)
			this.args = new Array();
		else
			this.args = args;
			
	}
	
	public function apply():void
	{
		closure.apply(thisArg, args);
	}
	
}
