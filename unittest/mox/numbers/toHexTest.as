/*
 * toHexTest.as
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
package mox.numbers 
{

	import astre.api.*;
	
	import flash.utils.Endian;
	
	public class toHexTest extends Test 
	{
		public function toHexTest(name:String)
		{
			super(name);
		}
		
		public function bigEndianTest():void
		{
			var n:uint = 0x01234567;
			assertEquals("01234567",toHex(n,Endian.BIG_ENDIAN));
		}
		
		public function nullEndianTest():void
		{
			var n:uint = 0x01234567;
			assertEquals("01234567",toHex(n,null));
			assertEquals("01234567",toHex(n));
		}
		
		public function littleEndianTest():void
		{
			var n:uint = 0x01234567;
			assertEquals("67452301",toHex(n, Endian.LITTLE_ENDIAN));
		}
		
	}
	
}
