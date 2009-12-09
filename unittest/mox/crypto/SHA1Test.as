/*
 * SHA1Test.as
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
package mox.crypto 
{

    import astre.api.*;
    
    import flash.utils.ByteArray;
    
    public class SHA1Test extends Test 
    {
        public function SHA1Test(name:String)
        {
            super(name);
        }
        
        public function emptyTest():void
		{
			makeStringTest("", "da39a3ee5e6b4b0d3255bfef95601890afd80709");
		}
		
		public function aTest():void
		{
			makeStringTest("a", "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8");
		}
		
		public function abcTest():void
		{
			makeStringTest("abc", "a9993e364706816aba3e25717850c26c9cd0d89d");
		}
		
		public function messageDigestTest():void
		{
			makeStringTest("message digest", "c12252ceda8be8994d5fa0290a47231c1d16aae3");
		}
		
		public function alphabeticTest():void
		{
			makeStringTest("abcdefghijklmnopqrstuvwxyz", "32d10c7b8cf96570ca04ce37f2a19d84240d3a89");
		}
		
		public function alphanumericTest():void
		{
			makeStringTest("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "761c457bf73b14d27e9e9265c46f4b4dda11f940");
		}
		
		public function numericRepeatTest():void
		{
			makeStringTest("12345678901234567890123456789012345678901234567890123456789012345678901234567890", "50abf5706a150990a08b2c5ea40fa0e585554732");
		}

        private function makeStringTest(string:String, hexDigest:String):void
		{
			assertEquals(hexDigest, new SHA1(string).hexDigest());
		}
		
		public function numericRepeatTest2():void
		{
			var sha:SHA1 = new SHA1();
			sha.update("12345678901234567890123456789012345678901234567890123456789012345678901234567890");
			assertEquals("50abf5706a150990a08b2c5ea40fa0e585554732", sha.hexDigest());
			trace("-----------------");
		}
		
		public function numericRepeatTest3():void
		{
			var sha:SHA1 = new SHA1();
			sha.update("12345678901234567890123456789012");
			sha.update("345678901234567890123456789012345678901234567890");
			assertEquals("50abf5706a150990a08b2c5ea40fa0e585554732", sha.hexDigest());
		}
		
		public function copyTest():void
		{
			var sha:SHA1 = new SHA1();
			sha.update("12345678901234567890123456789012");
			var copy:SHA1 = sha.copy() as SHA1;
			copy.update("345678901234567890123456789012345678901234567890");
			sha.update("345678901234567890123456789012345678901234567890");
			assertEquals("50abf5706a150990a08b2c5ea40fa0e585554732", sha.hexDigest());
			assertEquals("50abf5706a150990a08b2c5ea40fa0e585554732", copy.hexDigest());
		}
        
    }
    
}
