/*
 * signalTest.as
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
package mox.signals 
{

    import astre.api.*;

    public class signalTest extends Test 
    {
        public function signalTest(name:String)
        {
            super(name);
        }
        
        override public function setUp():void
        {
            signal("*","*",-1);
            _someFuncCalledTimes = 0;
        }
        
        override public function tearDown():void
        {
            signal("*","*",-1);
        }
        
        public function implicitAddSignalAndTriggerItIsOk():void
        {
            signal("mySignal", someFunc);
            var tc:int = _someFuncCalledTimes;
            signal("mySignal");
            assertEquals(tc+1,_someFuncCalledTimes);
        }
        
        public function addSignalAndTriggerItIsOk():void
        {
            signal("mySignal", someFunc, 1);
            signal("mySignal");
            assertEquals(1,_someFuncCalledTimes);
        }
        
        public function deleteAllIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("mySignal3", someFunc);
            signal("mySignal4", someFunc);
            assertEquals("",signal("*",undefined,-1));
            assertEquals(0,_someFuncCalledTimes);
        }
        
        public function callAllWithSigWildcardIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("mySignal3", someFunc);
            signal("mySignal4", someFunc);
            signal("*");
            assertEquals(4,_someFuncCalledTimes);
        }
        
        public function callAllWithRegExpSigIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("myBadSignal", someFunc);
            signal("myBadSignal2", someFunc);
            signal(/mySignal/);
            assertEquals(2,_someFuncCalledTimes);
        }
        
        // Privates
        
        private var _someFuncCalledTimes:int = 0;
        
        private function someFunc():void
        {
            _someFuncCalledTimes++;
        }
        
    }
    
}
