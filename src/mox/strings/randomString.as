/*
 * randomString.as
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
    
    /**
	 * Generates a string composed of alphanumeric characters, 
	 * and optional additional characters specified in the 
	 * <code class="prettyprint">...additionalChars</code> argument.
	 * 
	 * 
	 * 
	 * @example The following code shows some uses with various parameters :
	 * <pre class="prettyprint">
	 * trace(randomString(5); // 15APd
	 * trace(randomString(10, "ABCDEF")); // CDFDBAFDDD
	 * trace(randomString(10, "", "µ£$")); // 4£4uh$µaP5
	 * </pre>
	 * 
	 * @param length The number of characters in the generated string.
	 * @param chars The list of chars that *will possibly* be included in the generated string. 
	 * Duplicated chars have more chance to appear in the final string.
	 * By default, alphanumeric chars are used.
	 * @param chars2 The list of chars that *must* be included in the generated string.
	 * Allows duplicate chars. Duplicated chars will can be included more than once.
	 * The length of this list must shorter or equal than the requested length.
	 * By default, this list is empty.
	 * 
	 * @return A string composed of alphanumeric and optionnal characters.
	 */
    public function randomString(length:int, chars:String = "", chars2:String = ""):String
	{
		var randString:String = "";
		if (chars == "" || chars == null)
			chars = Chars.ALPHANUMERIC;
		
		var randChars2:Array = chars2.split("");
		if (randChars2.length == 1 && randChars2[0] == "")
			randChars2 = [];
		
		var numChars:int = chars.length;
		var numChars2:int = randChars2.length;
		
		while (--length>-1)
		{
			if (numChars2 > 0)
			{
				if (length+1 == numChars2)
				{
					// There is just enough room 
					// to add the non-optional chars
					// We shift the first chars, as 
					// it is assumed it is more significant
					randString += randChars2.shift();
					numChars2--;
				}
				else if (Math.random() < numChars2/length)
				{
					// Include one of the non-optional chars
					var index:int = int(Math.random()*numChars2);
					randString += randChars2[index];
					randChars2.splice(index,1);
					numChars2--;
				}
				else
				{
					randString += chars.charAt(int(Math.random()*numChars));
				}
			}
			else
			{
				randString += chars.charAt(int(Math.random()*numChars));
			}
		}
		return randString;
	}
    
}
