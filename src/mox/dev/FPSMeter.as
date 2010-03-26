/*
 * FPSMeter.as
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
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * 
	 */
	public final class FPSMeter 
	{
		
		private static const DEFAULT_CALLBACK:Function =  function ():void {trace("FPS::"+fps);}
		
		private static var _updateTime:Number = 1000;
		
		public static function get updateTime():Number { return _updateTime/1000; }
		
		public static function set updateTime(value:Number):void 
		{
			_updateTime = value*1000;
			if (_running)
			{
				stop();
				start();
			}
		}
		
		private static var dispatcher:Shape = new Shape();
		
		private static var _fps:Number = 0;
		
		public static function get fps():Number { return _fps; }
		
		private static var _running:Boolean = false;
		
		public static function get running():Boolean { return _running; }
		
		private static var framesCount:int;
		private static var lastTimeMilestone:int;
		private static var intervalID:Number = NaN;
		public static var updateCallback:Function = DEFAULT_CALLBACK;
		
		public static function start(updateTime:Number = 1, callback:Function = null):void 
		{
			if (_running) stop();
			
			if (callback != null) updateCallback = callback;
			FPSMeter.updateTime = updateTime;
			framesCount = 0;
			lastTimeMilestone = getTimer();
			dispatcher.addEventListener(Event.ENTER_FRAME, onFrameAdd);
			_running = true;
			intervalID = setInterval(onUpdate, _updateTime);
		}
		
		public static function stop():void 
		{
			if (!isNaN(intervalID))
			{
				clearInterval(intervalID);
			}
			dispatcher.removeEventListener(Event.ENTER_FRAME, onFrameAdd);
			_running = false;
		}
		
		private static function onFrameAdd(e:Event):void 
		{
			framesCount++;
		}
		
		private static function onUpdate():void
		{
			var time:int = getTimer();  
			_fps = framesCount/((time-lastTimeMilestone)/1000);
			framesCount = 0;  
			lastTimeMilestone = time;  
			updateCallback();
		}
		
	}

}