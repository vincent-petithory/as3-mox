/*
 * camelCaseTest.as
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

    public class camelCaseTest extends Test 
    {
        public function camelCaseTest(name:String)
        {
            super(name);
        }
        
        public function camelCaseSpaceSeparetedWords():void
        {
            var string:String = "Some text to camel case";
			var expected:String = "someTextToCamelCase";
			assertEquals(expected, camelCase(string));
        }
		
		public function camelCaseSpaceAndUnderscoreSeparetedWords():void
		{
			var string:String = "Some text to camel case : RGB_color";
			var expected1:String = "someTextToCamelCaseRgbColor";
			var expected2:String = "SomeTextToCamelCaseRGBColor";
			assertEquals(expected1, camelCase(string));
			assertEquals(expected2, camelCase(string,true));
		}
		
    }
    
}
