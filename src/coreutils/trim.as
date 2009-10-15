/*
 * trim.as
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
	 * Removes all whitespace character at the beginning and at 
	 * the end of the specified string.
	 * @param str the string to trim
	 * @return the trimmed string
	 */
    public const trim:Function = function(str:String):String
    {
        var p:int = 0;
		trimLeft:while (true)
		{
			switch(str.charAt(p))
			{
				case Unicode.TAB:
				case Unicode.LINE_FEED:
				case Unicode.SPACE:
				case Unicode.CARRIAGE_RETURN:
					p++;
					continue trimLeft;
			}
			str = str.substr(p);
			break trimLeft;
		}
		p = str.length - 1;
		trimRight:while (true)
		{
			switch(str.charAt(p))
			{
				case Unicode.TAB:
				case Unicode.LINE_FEED:
				case Unicode.SPACE:
				case Unicode.CARRIAGE_RETURN:
					p--;
					continue trimRight;
			}
			str = str.substring(0, ++p);
			break trimRight;
		}
		return str;
    }
    
}

