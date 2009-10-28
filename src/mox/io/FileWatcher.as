/*
 * FileWatcher.as
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
package mox.io 
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	

public class FileWatcher extends EventDispatcher 
{
	
	private var _file:File;
	private var _watchDelay:Number;
	private var _lastModificationTime:Number;
	
	public function FileWatcher(file:File, watchDelay:Number = 1000) 
	{
		super();
		if (file == null)
		{
			throw new TypeError("File must not be null");
		}
		this._file = file.clone();
		_fileExists = _file.exists;
		if (_fileExists)
		{
			_lastModificationTime = _file.modificationDate.getTime();
		}
		_isWatching = false;
		this._watchDelay = isNaN(watchDelay) ? 1000 : Math.max(watchDelay, 50);
	}
	
	private var _fileExists:Boolean;
	
	private var _isWatching:Boolean;
	
	public function get isWatching():Boolean
	{
		return _isWatching;
	}
	
	private var timerID:uint;
	
	public function watch():void
	{
		if (_isWatching)
		{
			unwatch();
		}
		timerID = setInterval($onWatchRequest, watchDelay);
		_isWatching = true;
	}
	
	public function unwatch():void
	{
		_isWatching = false;
		clearInterval(timerID);
	}
	
	protected function $onWatchRequest():void
	{
		if (_file.exists)
		{
			if (!_fileExists)
			{
				this.dispatchEvent(new FileWatcherEvent(FileWatcherEvent.FILE_CREATE, true, _file));
			}
			_fileExists = true;
			var newTime:Number = _file.modificationDate.getTime();
			if (newTime > _lastModificationTime)
			{
				this.dispatchEvent(new FileWatcherEvent(FileWatcherEvent.FILE_UPDATE, true, _file));
			}
			_lastModificationTime = newTime;
		}
		else
		{
			if (_fileExists)
			{
				this.dispatchEvent(new FileWatcherEvent(FileWatcherEvent.FILE_DELETE, true, _file));
			}
			_fileExists = false;
		}
		
	}
	
	public function get file():File { return _file; }
	
	public function get watchDelay():Number { return _watchDelay; }
	
	public function set watchDelay(value:Number):void 
	{
		_watchDelay = value;
		unwatch();
		watch();
	}
	
	
}
	
}
