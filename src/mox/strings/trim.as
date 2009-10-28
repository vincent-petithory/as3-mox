/*
 * trim.as
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

