/*
 * CallLaterSample.as
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
package 
{
    
    import mox.callLater;

    public class CallLaterSample extends SampleBase 
    {
    
        private var i:int = 0;
        private const N:int = 1000000;
        
        public function CallLaterSample()
        {
            super();
            println("That function is useful to prevent the UI to freeze when processing long tasks.");
            println("The function can take arguments.");
            println("Example: This very long loop on a variable is done on various frames.");
            callLater(iAmCalledOnNextFrame);
        }
        
        private function iAmCalledOnNextFrame():void
        {
            var n:int = i+50000;
            while (++i<n) {Math.cos(i)*Math.sin(i);}
            println("Working on i:", i);
            if (i<N)
            {
                callLater(iAmCalledOnNextFrame);
            }
        }
        
    }
    
}
