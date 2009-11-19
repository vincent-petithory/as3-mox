/*
 * swapCase.as
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

    public function swapCase(string:String):String
    {
        var swapped:String = "";
        var length:int = string.length;
        var i:int = -1;
        while (++i<length)
        {
            var char:String = string.charAt(i);
            var code:int = char.charCodeAt(0);
            if (code >= 65 && code <= 90)
                char = char.toLowerCase();
            else if (code >= 97 && code <= 122)
                char = char.toUpperCase();
            
            swapped += char;
        }
        return swapped;
    }
    
}
