/*
 * Broadcaster.as
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
package mox.signals 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.Dictionary;

public class Broadcaster 
{
	
	/**
	* @private
	*/
	private static const BROADCASTER_FUNCTION_LIST:XMLList = describeType(Broadcaster)..method.attribute("name");
	
	/**
	* Gives a "broadcaster" behavior to an object. This object must an 
	* instance of a dynamic class.
	* @return true if the operation worked as expected.
	*/
	public static function create(obj:Object):Boolean
	{
		if (describeType(obj).@isDynamic.toLowerCase() != "true")
		{
			return false;
		}
		
		var broadcaster:Broadcaster = new Broadcaster();
		var methodName:String;
		for each (methodName in BROADCASTER_FUNCTION_LIST)
		{
			obj[methodName] = broadcaster[methodName];
		}
		obj["__proxy__"] = broadcaster;
		return true;
	}
	
	/**
	 * @private
	 * Listeners storage
	 */
	private var _listeners:Array;
	
	private var _proxy:Object;
	
	public function Broadcaster(proxy:Object = null) 
	{
		super();
		_listeners = new Array();
		if (proxy == null)
		{
			_proxy = this;
		}
		else
		{
			_proxy = proxy;
		}
	}
	
	/**
	 * 
	 */
	public function hook(message:String):Function
	{
		var broadcaster:Broadcaster = this;
		var f:Function = function(e:Event):void
		{
			broadcaster.broadcast(message);
		}
		return f;
	}
	
	public function getListeners():Array
	{
		return _listeners.slice();
	}
	
	public function addListener(listener:Object):void
	{
		if (!hasListener(listener))
		{
			_listeners.push(listener);
		}
	}
	
	public function removeListener(listener:Object):Boolean 
	{
		var index:int = this._listeners.indexOf(listener);
		if (index != -1)
		{
			this._listeners.splice(index, 1);
			return true;
		}
		return false;
	}
	
	/**
	 * Sends a message
	 */
	public function broadcast(event:String, ...args):void 
	{
		var l:Object;
		
		for each (l in this._listeners)
		{
			if (l is Function)
			{
				l.apply(_proxy,args);
			}
			else 
			{
				// mecanique detection dynamique
				if ((event in l) && l[event] != undefined && l[event] is Function)
				try 
				{
					l[event].apply(_proxy,args);
				} catch (e:ReferenceError)
				{
					// ignore
				}
			}
		}
	}
	
	public function willTrigger(event:String):Boolean 
	{
		for each (var listener:Object in this._listeners)
		{
			if (listener.hasOwnProperty(event) && listener[event] is Function)
			{
				return true;
			}
		}
		return false;
	}
	
	public function willTriggerListener(event:String, listener:Object):Boolean 
	{
		if (listener.hasOwnProperty(event) && listener[event] is Function)
		{
			return true;
		}
		return false;
	}
	
	public function hasListener(listener:Object):Boolean 
	{
		return this._listeners.indexOf(listener) != -1;
	}
	
	public function clearListeners():void
	{
		this._listeners = new Array();
	}
	
}
	
}
