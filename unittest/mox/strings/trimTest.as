/*
 * trimTest.as
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

    import astre.api.*;
	
	import flash.utils.getTimer;
	
    public class trimTest extends Test 
    {
        public function trimTest(name:String)
        {
            super(name);
        }
        
        public function simpleCaseWithOnlySpacesInBothSides():void
        {
            var string:String = "    Oh well, I will be trimmed. That's cool.    ";
			var expected:String = "Oh well, I will be trimmed. That's cool.";
			assertEquals(expected, trim(string));
        }
		
		public function inputRemainsUnchangedIfNoWhitespacesAreFound():void
		{
			var string:String = "Oh well, I won't be trimmed. That's cool too.";
			assertEquals(string, trim(string));
		}

        public function heterogenouseMixOfWhitespacesIsTrimmed():void
		{
			var string:String = "\r\t  \n\rcontent\n \t  \r\n\n ";
			assertEquals("content", trim(string));
		}        
        
    }
    
}
