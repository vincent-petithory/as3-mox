/*
 * BitmapLoader.as
 * This file is part of as3-coreutils 
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * as3-coreutils is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * as3-coreutils is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
 
 
package coreutils 
{
	
	public const BitmapLoader:_BitmapLoader = new _BitmapLoader();
	
}
import flash.display.BitmapData;
import flash.display.Loader;
import flash.errors.IllegalOperationError;
import flash.errors.MemoryError;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.utils.ByteArray;


[Event(name="ioError", type="flash.events.IOErrorEvent")]
[Event(name="progress", type="flash.events.ProgressEvent")]
[Event(name="complete", type="flash.events.Event")]
[Event(name="open", type="flash.events.Event")]

internal class _BitmapLoader extends EventDispatcher 
{
	
	private static const IMAGES_FILTER:Array = [new FileFilter("Images", "*.jpg;*.gif;*.png")];
	
	private var fileRef:FileReference;
	private var loader:Loader;
	
	public function _BitmapLoader() 
	{
		super();
		this._isPending = false;
		
	}
	
	private function onBrowseDone(e:Event):void 
	{
		fileRef.removeEventListener(Event.CANCEL, onBrowseDone);
		fileRef.removeEventListener(Event.SELECT, onBrowseDone);
		
		if (e.type == Event.SELECT)
		{
			fileRef.addEventListener(Event.COMPLETE, onLoadComplete);
			fileRef.addEventListener(Event.OPEN, redispatch);
			fileRef.addEventListener(ProgressEvent.PROGRESS, redispatch);
			try 
			{
				fileRef.load();
			}
			catch (e:IllegalOperationError)
			{
				this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,e.message));
			}
			catch (e:MemoryError)
			{
				this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,e.message));
			}
		}
		else
		{
			fileRef = null;
			this._isPending = false;
		}
	}
	
	private function redispatch(e:Event):void 
	{
		if (e is ErrorEvent)
		{
			this._isPending = false;
			this.fileRef = null;
			this.loader = null;
		}
		this.dispatchEvent(e.clone());
	}
	
	private var _isPending:Boolean;
	
	public function get isPending():Boolean
	{
		return _isPending;
	}
	
	public function load():void
	{
		try 
		{
			if (!this.isPending)
			{
				fileRef = new FileReference();
				fileRef.addEventListener(Event.SELECT, onBrowseDone);
				fileRef.addEventListener(Event.CANCEL, onBrowseDone);
				var valid:Boolean = fileRef.browse(IMAGES_FILTER);
				if (!valid)
				{
					throw new Error("Invalid call to FileReference.browse()");
				}
			}
		} catch (e:Error)
		{
			this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,e.message));
		}
	}
	
	private var _bitmap:BitmapData;
	
	public function get bitmap():BitmapData
	{
		var b:BitmapData = _bitmap;
		_bitmap = null;
		return b;
	}
	
	private function onLoadComplete(e:Event):void 
	{
		fileRef.removeEventListener(Event.COMPLETE, onLoadComplete);
		fileRef.removeEventListener(Event.OPEN, redispatch);
		fileRef.removeEventListener(ProgressEvent.PROGRESS, redispatch);
		
		var data:ByteArray = fileRef.data;
		fileRef = null;
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadBytesComplete);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, redispatch);
		try 
		{
			loader.loadBytes(data);
		}catch (e:Error)
		{
			this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, e.name+" : "+e.message));
		}
		this._isPending = false;
	}
	
	private function onLoadBytesComplete(e:Event):void 
	{
		loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadBytesComplete);
		loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, redispatch);
		_bitmap = new BitmapData(loader.content.width, loader.content.height, true, 0x00000000);
		_bitmap.draw(loader.content);
		loader.unload();
		this.dispatchEvent(new Event(Event.COMPLETE));
	}
	
}
