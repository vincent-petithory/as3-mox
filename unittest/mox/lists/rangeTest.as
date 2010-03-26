/*
 * rangeTest.as
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
package mox.lists 
{

    import astre.api.*;

    public class rangeTest extends Test 
    {
        public function rangeTest(name:String)
        {
            super(name);
        }
        
        public function positiveRangeWithDefaultStep():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),0,10);
            var expected:Array = new Array(0,1,2,3,4,5,6,7,8,9);
            assertArrayEquals(expected,vectorToArray(rng));
        }
        
        public function negativeRangeWithNegativeDefaultStep():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),0,-10,-1);
            var expected:Array = new Array(0,-1,-2,-3,-4,-5,-6,-7,-8,-9);
            assertArrayEquals(expected,vectorToArray(rng));
        }
        
        public function mixedRangeWithPositiveStep():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),-6,9,3);
            var expected:Array = new Array(-6,-3,0,3,6);
            assertArrayEquals(expected,vectorToArray(rng));
        }
        
        public function mixedRangeWithNegativeStep():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),20,-5,-5);
            var expected:Array = new Array(20,15,10,5,0);
            assertArrayEquals(expected,vectorToArray(rng));
        }
        
        public function emptyRangeIntersectionReturnsEmptyArray1():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),0,10,-1);
            assertEquals(0,rng.length);
        }
        
        public function emptyRangeIntersectionReturnsEmptyArray2():void
        {
            var rng:Vector.<int> = range(new Vector.<int>(),0,-10,1);
            assertEquals(0,rng.length);
        }
        
        public function positiveRangeWithAUnsignedIntVector():void
        {
            var rng:Vector.<uint> = range(new Vector.<uint>(),0,10);
            var expected:Array = new Array(0,1,2,3,4,5,6,7,8,9);
            assertArrayEquals(expected,vectorToArray(rng));
        }
        
        public function positiveRangeWithANumberVector():void
        {
            var rng:Vector.<Number> = range(new Vector.<Number>(),0,1,0.1);
            var expected:Array = new Array(0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9);
            assertEquals(expected.length,rng.length);
            var i:int = -1;
            var l:int = expected.length;
            while (++i<l)
                assertApproximate(expected[i],rng[i],0.0000000001);
        }
        
        public function negativeRangeWithAnArray():void
        {
            var a:Array = new Array();
            range(a,0,-1,-0.1);
            var expected:Array = new Array(0,-0.1,-0.2,-0.3,-0.4,-0.5,-0.6,-0.7,-0.8,-0.9);
            assertEquals(expected.length,a.length);
            var i:int = -1;
            var l:int = expected.length;
            while (++i<l)
                assertApproximate(expected[i],a[i],0.0000000001);
        }
        
        public function invalidStepThrowsAnError():void
        {
            try 
            {
                var rng:Vector.<int> = range(new Vector.<int>(),0,45,0);
                fail("An ArgumentError should have been thrown");
            } catch (e:ArgumentError) {}
        }
        
    }
    
}
