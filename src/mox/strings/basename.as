/*
 * basename.as
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
     * Extracts the basename of a path or URL. 
     * The returned basename does not contain a trailing slash.
     * The path can contain slashes or backslashes.
     * 
     * <p>For example: 
     * <pre>
     * import mox.strings.basename;
     * var path:String = "/etc/apache2/httpd.conf";
     * var basepath:String = basename(path);
     * trace(basepath); // "/etc/apache2"
     * </pre>
     * </p>
     * 
     * @param path The path or URL to process.
     * @return The base name of a path, or an empty string, 
     * if the input string is not a path or URL.
     */
    public function basename(path:String):String
    {
        return path.substring(0,path.replace(Patterns.ANTI_SLASHES, "/").lastIndexOf("/"));
    }
    
}
