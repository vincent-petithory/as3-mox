/*
 * Runtime.as
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
package mox.dev 
{
	import flash.net.LocalConnection;
	import flash.utils.getTimer;
	
	/**
	 * 
	 */
	public final class Runtime
	{
		
		
		private static const GC_CONNECTION_NAME:String = "__gc_connection__";
		
		public static function gc():void
		{
			try 
			{
				new LocalConnection().connect(GC_CONNECTION_NAME);
				new LocalConnection().connect(GC_CONNECTION_NAME);
			} catch (e:Error) {}
		}
		
		private static var time:int = 0;
		
		public static function resetExecTime():void
		{
			time = getTimer();
		}
		
		public static function getExecTime():int
		{
			return getTimer()-time;
		}
		
		public static function getExecFuncTime(
								times:uint, 
								func:Function, 
								thisArg:*, 
								...args
							):int
		{
			var t:int = getTimer();
			var i:int = times;
			while (--i > -1)
			{
				func.apply(thisArg, args);
			}
			return getTimer()-t;
		}
		
	}

}
