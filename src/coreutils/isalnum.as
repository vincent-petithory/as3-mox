/*
 * isalnum.as
 * This file is part of as3-coreutils 
 *
 * Copyright (C) 2009 - Vincent
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

    public const isalnum:Function = function(str:String):Boolean
    {
        var ch:int = str.charCodeAt(0) 
        return (ch >= 48 && ch <= 57) || 
               (ch >= 65 && ch <= 90) || 
               (ch >= 97 && ch <= 122);
    }
    
}
