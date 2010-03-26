/*
 * WeakArrayTest.as
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
    
    import flash.system.System;
    import flash.utils.Dictionary;
    import flash.utils.setInterval;
    
    public class WeakArrayTest extends Test 
    {
        public function WeakArrayTest(name:String)
        {
            super(name);
        }
        
        override public function tearDown():void
        {
            a = null;
            d = null;
        }
        
        public function addAValue():void
        {
            var x:String = "x";
            a = new WeakArray();
            a.push(x);
            var val:String = a[0];
            assertEquals(x,val);
        }
        
        public function checkTheGarbageableValueIsKeptInStandardArray():void
        {
            a = new Array();
            function addValueToArray():void
            {
                var data:Object = new Object();
                a.push(data);
                data = null;
            }
            addValueToArray();
            System.gc();
            addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail2);
            wait(3000);
        }
        
        public function checkTheGarbageableValueIsNotKeptInWeakArray():void
        {
            a = new WeakArray();
            function addValueToArray():void
            {
                var data:Object = new Object();
                a.push(data);
                data = null;
            }
            addValueToArray();
            System.gc();
            addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail);
        }
        
        private var a:*;
        private var d:Dictionary;
        
        public function basicGCCheckInDictionary():void
        {
            d = new Dictionary(true);
            var o:Object = new Object();
            d[o] = true;
            o = null;
            System.gc();
            addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail__d);
        }
        
        private var times:int = 4;
        
        private function checkMemoryAndMaybeFail():void
        {
            assertUndefined(a[0]);
            times--;
            if (times>0)
                addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail);
        }
        
        private function checkMemoryAndMaybeFail2():void
        {
            assertNotUndefined(a[0]);
            times--;
            if (times>0)
                addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail2);
        }
        
        private function checkMemoryAndMaybeFail__d():void
        {
            for (var x:* in d)
            {
                fail("object '"+x+"' present in memory");
            }
            times--;
            if (times>0)
                addScheduledJob(1000,"checkMemory",checkMemoryAndMaybeFail__d);
        }
        
        
    }
    
}
