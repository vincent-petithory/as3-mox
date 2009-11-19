/*
 * sprintfTest.as
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

    public class sprintfTest extends Test 
    {
        public function sprintfTest(name:String)
        {
            super(name);
        }
        
        public function theTokensOfTheStringAreReplaced():void
        {
            var string:String = "My name is {0} {1}";
			var expected:String = "My name is Vincent Petithory";
			assertEquals(expected, sprintf(string, ["Vincent", "Petithory"]));
        }
        
        public function replaceTokensWithASpecificClassInstance():void
        {
            var string:String = "My name is {firstName} {lastName}";
            var developer:Developer = new Developer("Vincent","Petithory");
			var expected:String = "My name is Vincent Petithory";
			assertEquals(expected, sprintf(string, developer));
        }
		
		public function inputRemainsUnchangedIfNoTokensAreFound():void
		{
			var string:String = "My name is Vincent Petithory";
			assertEquals(string, sprintf(string));
			assertEquals(string, sprintf(string, ["Vincent", "Petithory"]));
		}
		
		public function shuffledTokensAreReplacedByTheCorrectElements():void
		{
			var string:String = "{2}, an {0} {3} {1}.";
			var expected:String = "Mox, an Actionscript 3.0 toolkit.";
			assertEquals(expected, sprintf(string, ["Actionscript", "toolkit", "Mox","3.0"]));
		}
		
		public function replaceTokensUsingAnObject():void
		{
			var string:String = "{project}, an {language} {version} {type}.";
			var expected:String = "Mox, an Actionscript 3.0 toolkit.";
			assertEquals(expected, sprintf(string, {language:"Actionscript", type:"toolkit", project:"Mox", version:"3.0"}));
		}
        
    }
    
}

internal class Developer 
{

	public var firstName:String;
	public var lastName:String;
	
    public function Developer(firstName:String, lastName:String)
    {
        this.firstName = firstName;
        this.lastName = lastName;
    }
}

