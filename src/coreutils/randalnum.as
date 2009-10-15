/*
 * randalnum.as
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
    
    /**
	 * Generates a string composed of alphanumeric characters, 
	 * and optional additional characters specified in the 
	 * <code class="prettyprint">...additionalChars</code> argument.
	 * 
	 * <p>For additional characters, include the <code class="prettyprint">!</code> character at the 
	 * beginning of the string to make it appear in the final string at least one time.
	 * If <code class="prettyprint">!</code> is alone, it is treated as a normal character.<br/>
	 * If an optional parameter is not a string or has a length greater than the requested 
	 * length of the generated string, it is ignored during the process.<br/>
	 * If a !flagged string cannot be insert due to the lack of space and/or not to 
	 * overlap another !flagged string, it will be skipped.<br/>
	 * The order of the !flagged strings is by decreasing importance : The first 
	 * one specified will be tried to be inserted, then the second, etc.</p>
	 * 
	 * @example The following code shows some uses with various parameters :
	 * <pre class="prettyprint">
	 * trace(randalnum(10, "%", "!µ")); // 6Nvµ1fWFL5
	 * 
	 * trace(randalnum(10, "!%", "!µ")); // 7nswµ6h%3n
	 * 
	 * trace(randalnum(20, "!decora")); // bygmM6decoraj23THRQ
	 * </pre>
	 * 
	 * @param length The number of characters of the generated string.
	 * @param ...additionalChars Optional single characters or strings that may be 
	 * added to the generated string.
	 * 
	 * @return A string composed of alphanumeric and optionnal characters.
	 */
    public const randalnum:Function = function(length:uint, ...additionalChars):String
	{
		var addLength:uint = additionalChars.length;
		var allowedChars:Array = ALPHANUMERIC_CHARS.slice();
		var flaggedStrings:Array = new Array();
		
		if (addLength != 0)
		{
			for (var i:int = 0 ; i < addLength ; i++)
			{
				if (additionalChars[i] is String)
				{
					if (allowedChars.indexOf(additionalChars[i]) == -1)
					{
						allowedChars.push(additionalChars[i]);
						if (String(additionalChars[i]).charAt(0) == "!" && String(additionalChars[i]).length != 1)
						{
							flaggedStrings.push(String(additionalChars[i]).substr(1));
						}
						
					}
				}
				else if (additionalChars[i] is Array)
				{
					var l:uint = additionalChars[i].length;
					for (var u:uint = 0 ; u < l ; u++)
					{
						if (additionalChars[i][u] is String)
						{
							if (allowedChars.indexOf(additionalChars[i][u]) == -1)
							{
								allowedChars.push(additionalChars[i][u]);
								if (String(additionalChars[i][u]).charAt(0) == "!" && String(additionalChars[i][u]).length != 1)
								{
									flaggedStrings.push(String(additionalChars[i][u]).substr(1));
								}
							}
						}
						
					}
				}
			}
		}
		
		var gen:String = new String();
		
		var numAllowedChars:uint = allowedChars.length;
		
		i = 0;
		var str:String;
		var isOptionalString:Boolean = false;
		// test before processing in order to improve later performance.
		if (addLength != 0)
		{
			while (i < length)
			{
				// delegate optional strings with ! flag to a later process.
				do {
					str = String(allowedChars[Math.floor(Math.random()*numAllowedChars)]);
					isOptionalString = (str.charAt(0) == "!" && str.length != 1);
				}
				while (isOptionalString);
				
				gen += str;
				i += str.length;
			}
		}
		else
		{
			while (i < length)
			{
				gen += String(allowedChars[Math.floor(Math.random()*numAllowedChars)]);
				i++;
			}
		}
		
		addLength = flaggedStrings.length;
		
		var rand:uint;
		var indexesAvailable:Array = new Array(length);
		var numIndexes:uint;
		
		for (i = 0 ; i < length ; i++)
		{
			indexesAvailable[i] = i;
		}
		
		var isOverlappingAnIndex:Boolean = false;
		var isThereEnoughConsecutiveIndexes:Boolean = true;
		
		for (i = 0 ; i < addLength ; i++)
		{
			str = String(flaggedStrings[i]);
			var strLength:uint = str.length;
			
			if (gen.indexOf(str) == -1 && strLength <= length)
			{
				var j:uint;
				var k:uint;
				numIndexes = indexesAvailable.length;
				isThereEnoughConsecutiveIndexes = false;
				
				for (j = 0 ; j < numIndexes ; j++)
				{
					var c:Boolean = true;
					for (k = 0 ; k < strLength ; k++)
					{
						c = c && indexesAvailable.indexOf(j+k) != -1;
					}
					isThereEnoughConsecutiveIndexes = isThereEnoughConsecutiveIndexes || c;
				}
				
				if (isThereEnoughConsecutiveIndexes)
				{
					do
					{
						rand = Math.floor(Math.random()*gen.length);
						var indexOccupied:uint = rand;
						isOverlappingAnIndex = indexesAvailable.indexOf(indexOccupied) == -1;
						for (k = 0 ; k < strLength ; k++)
						{
							isOverlappingAnIndex = isOverlappingAnIndex || indexesAvailable.indexOf(indexOccupied++) == -1;
						}
					}
					while (isOverlappingAnIndex || strLength > length - rand);
					
					var indexToAvoid:uint = rand;
					for (j = 0 ; j < strLength ; j++)
					{
						indexesAvailable.splice(indexesAvailable.indexOf(indexToAvoid++), 1);
					}
					gen = gen.substr(0,rand)+str+gen.substr(str.length+rand);
				}
				
			}
		}
		
		gen = gen.substr(0, length);
		
		return gen;
	}
    
}

internal const ALPHANUMERIC_CHARS:Array = registerAlphanumericChars();
	
internal function registerAlphanumericChars():Array
{
	var chars:Array = new Array();
	var i:uint;
	// Digits
	for (i = 48 ; i <= 57 ; i++)
	{
		chars.push(String.fromCharCode(i));
	}
	
	// Uppercase chars
	for (i = 65 ; i <= 90 ; i++)
	{
		chars.push(String.fromCharCode(i));
	}
	
	// Lowercase chars
	for (i = 97 ; i <= 122 ; i++)
	{
		chars.push(String.fromCharCode(i));
	}
	
	return chars;
}
