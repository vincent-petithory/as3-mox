/*
 * AllTests.as
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
package mox 
{
    
    import astre.api.*;
    
    import mox.algorithm.*;
    import mox.lists.*;
    import mox.crypto.*;
    import mox.dev.*;
    import mox.numbers.*;
    import mox.signals.*;
    import mox.strings.*;
    
    public final class AllTests 
    {
        
        public static function suite():TestSuite
        {
            var list:TestSuite = new TestSuite();
            list.add(mox.algorithm.AllTests.suite());
            list.add(mox.lists.AllTests.suite());
            list.add(mox.crypto.AllTests.suite());
            list.add(mox.dev.AllTests.suite());
            list.add(mox.numbers.AllTests.suite());
            list.add(mox.signals.AllTests.suite());
            list.add(mox.strings.AllTests.suite());
            list.add(VersionTest);
            return list;
        }
        
    }
}

