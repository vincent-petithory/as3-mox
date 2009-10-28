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
package mox.debug 
{
	
	public const FPSMeter:_FPSMeter = new _FPSMeter();
	
}

import flash.display.Shape;
import flash.events.Event;
import flash.utils.clearInterval;
import flash.utils.getTimer;
import flash.utils.setInterval;

internal class _FPSMeter 
{
	
	private static const defaultCallback:Function =  function ():void {trace("FPS::"+this.fps);}
	
	private var _updateTime:Number;
	
	public function get updateTime():Number { return _updateTime/1000; }
	
	public function set updateTime(value:Number):void 
	{
		_updateTime = value*1000;
		if (_running)
		{
			stop();
			start();
		}
	}
	
	private var dispatcher:Shape;
	
	private var _fps:Number = 0;
	
	public function get fps():Number { return _fps; }
	
	private var _running:Boolean = false;
	
	public function get running():Boolean { return _running; }
	
	private var framesCount:int;
	private var lastTimeMilestone:int;
	private var intervalID:Number = NaN;
	public var updateCallback:Function;
	
	public function _FPSMeter() 
	{
		super();
		dispatcher = new Shape();
		this.updateTime = 1;
		this.updateCallback = defaultCallback;
	}
	
	public function start(updateTime:Number = 1, callback:Function = null):void 
	{
		if (this._running) stop();
		
		if (callback != null) this.updateCallback = callback;
		this.updateTime = updateTime;
		framesCount = 0;
		lastTimeMilestone = getTimer();
		dispatcher.addEventListener(Event.ENTER_FRAME, onFrameAdd);
		_running = true;
		this.intervalID = setInterval(onUpdate, _updateTime);
	}
	
	public function stop():void 
	{
		if (!isNaN(intervalID))
		{
			clearInterval(intervalID);
		}
		dispatcher.removeEventListener(Event.ENTER_FRAME, onFrameAdd);
		_running = false;
	}
	
	private function onFrameAdd(e:Event):void 
	{
		framesCount++;
	}
	
	private function onUpdate():void
	{
		var time:int = getTimer();  
		this._fps = framesCount/((time-lastTimeMilestone)/1000);
		framesCount = 0;  
		lastTimeMilestone = time;  
		updateCallback();
	}
	
}
