/*
 * vectorToArrayTest.as
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
package mox.arrays 
{

    import astre.api.*;

    public class vectorToArrayTest extends Test 
    {
        public function vectorToArrayTest(name:String)
        {
            super(name);
        }
        
        public function basicTest():void
        {
            var v:Vector.<uint> = new Vector.<uint>();
            v.push(0,1,2,3,4,5);
            var expected:Array = new Array(0,1,2,3,4,5);
            assertArrayEquals(expected,vectorToArray(v));
        }
        
        public function nullVectorThrowsAnException():void
        {
            var v:Vector.<String> = null;
            try 
            {
                var a:Array = vectorToArray(v);
                fail("A TypeError should have been thrown, as <v> is null.");
            } catch (e:TypeError) {}
        }
        
        public function emptyVectorTest():void
        {
            var v:Vector.<String> = new Vector.<String>();
            var expected:Array = new Array();
            assertArrayEquals(expected,vectorToArray(v));
        }
        
        
    }
    
}
