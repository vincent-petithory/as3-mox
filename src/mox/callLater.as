/*
 * callLater.as
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
package mox 
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
	 * @param noDuplicates the method to call on the next frame.
	 * @param thisArg the object the this keyword of the function references.
	 * @param ...args the arguments to pass to the function.
	 */
	public function callLater(closure:Function, noDuplicates:Boolean = true, thisArg:* = undefined, ...args):void 
	{
		if (callLaterObjs == null)
		{
			callLaterObjs = new Vector.<CallLaterObj>();
		}
		
		var shouldAdd:Boolean = true;
		if (noDuplicates)
		{
			var clo:CallLaterObj;
			for each (clo in callLaterObjs)
			{
				if (clo.closure == closure)
				{
					shouldAdd = false;
					break;
				}
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
internal const innerObj:Shape = new Shape();

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
	
	// We make a buffer, so that if another callLater is called during 
	// the following loop, there is no conflicts 
	// in the actual callLaterObj list.
	var buffer:Vector.<CallLaterObj> = callLaterObjs.slice();
	callLaterObjs = null;
	
	for each (var closure:CallLaterObj in buffer)
	{
		closure.apply();
	}
	buffer = null;
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
