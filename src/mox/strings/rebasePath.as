/*
 * rebasePath.as
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

    import mox.strings.basename;
    import mox.strings.name;
    
    /**
     * Rebase the specified URL with the specified base URL or path. 
     * 
     * <p>For example: 
     * <pre>
     * import mox.strings.rebasePath;
     * var url:String = "http://www.mysite.com/files/foo.png";
     * var rebasedURL1:String = rebasePath(url,"http://www.another-site.com/files);
     * // Works with the trailing slash too.
     * var rebasedURL2:String = rebasePath(url,"http://www.another-site.com/files/);
     * var rebasedURL3:String = rebasePath(url,"http://www.another-site.com/media/images/otherimage.jpg);
     * trace(rebasedURL1); // "http://www.another-site.com/files/foo.png"
     * trace(rebasedURL2); // "http://www.another-site.com/files/foo.png"
     * trace(rebasedURL3); // "http://www.another-site.com/media/images/foo.png"
     * </pre>
     * </p>
     * 
     * @param url The path or URL to process. It can have a trailing slash
     * @param base The base path or URL to use for the rebase operation.
     * @return The rebased URL.
     */
    public function rebasePath(path:String, base:String):String
    {
        return basename(base)+"/"+name(path);
    }
    
}
