/*
 * isspace.as
 * This file is part of Tinker
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * Tinker is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Tinker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Tinker; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package tinker.strings 
{

    public const isspace:Function = function(str:String):Boolean
    {
        var ch:int = str.charCodeAt(0) 
        return  ch == 0x0009 || ch == 0x000B || ch == 0x000C || 
                ch == 0x0020 || ch == 0x000A || ch == 0x000D || 
                ch == 0x0008 || ch == 0x0022 || ch == 0x0027 || 
                ch == 0x005C;
    }
    
}