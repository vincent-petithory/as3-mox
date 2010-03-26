/*
 * UnicodeImpl.as
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
package mox.strings 
{

	import flash.utils.flash_proxy;
	import flash.utils.Proxy;

	/**
	 * An unicode utility class. Use the Unicode singleton
	 * Retrieve an unicode char with Unicode.uXXXX, where x is an hexadecimal char.
	 */
	public dynamic class UnicodeImpl extends Proxy 
	{
		
		// Spacing
		public const TAB:String = hexChar(0x0009);
		public const VERTICAL_TAB:String = hexChar(0x000B);
		public const FORM_FEED:String = hexChar(0x000C);
		public const SPACE:String = hexChar(0x0020);
		public const LINE_FEED:String = hexChar(0x000A);
		public const CARRIAGE_RETURN:String = hexChar(0x000D);
		public const BACKSPACE:String = hexChar(0x0008);
		public const HORIZONTAL_TAB:String = hexChar(0x0009);
	
		// Quotes
		public const DOUBLE_QUOTE:String = hexChar(0x0022);
		public const SINGLE_QUOTE:String = hexChar(0x0027);
	
		public const BACKSLASH:String = hexChar(0x005C);
	
		// Special chars
		public const COPYRIGHT:String = hexChar(0x00A9);
	
		override flash_proxy function callProperty(name:*, ...rest):* 
		{
			return __jsEscapes(name);
		}
	
		override flash_proxy function getProperty(name:*):* 
		{
			return __jsEscapes(name);
		}
		
		public function char(hex:String):String
		{
			// hex : xxxx
			return String.fromCharCode(parseInt(hex.substr(0, 4), 16));
		}
	
		public function hexChar(hex:uint):String
		{
			return String.fromCharCode(hex);
		}
	
		private function __jsEscapes(jse:String):String
		{
			var hex:String = jse.substr(1, 4);
			return String.fromCharCode(parseInt(hex.substr(0, 4), 16));
		}
	
	}
}

