/*
 * name.as
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
     * Extracts the name of a file from a path or URL.
     * The path can contain slashes or backslashes.
     * 
     * <p>For example: 
     * <pre>
     * import mox.strings.*;
     * var path:String = "/etc/apache2/httpd.conf";
     * var filename:String = name(path);
     * trace(filename); // "httpd.conf"
     * </pre>
     * </p>
     * 
     * @param path The path or URL to process.
     * @return The name of a file, or the input string if this one is 
     * incorrect (or already a file name) .
     */
    public function name(path:String):String
    {
        return path.substring(path.replace(Patterns.ANTI_SLASHES, "/").lastIndexOf("/")+1);
    }
    
}
