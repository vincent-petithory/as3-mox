/*
 * BroadcasterTest.as
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

    public class BroadcasterTest extends Test 
    {
        public function BroadcasterTest(name:String)
        {
            super(name);
        }
        
        private var client:Object;
        
        public function addAListenerAndRetrieveIt():void
        {
            client = new Object();
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            assertTrue(b.hasListener(client));
        }
        
        public function removeListenerAndDontRetrieveIt():void
        {
            client = new Object();
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            b.removeListener(client);
            assertFalse(b.hasListener(client));
        }
        
        public function broadcastEventTriggersTheMethodOfTheListeners():void
        {
            client = new Object();
            client.pushRandom = function (a:Array):void {a.push(Math.random())};
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            var array:Array = new Array();
            b.broadcast("pushRandom",array);
            assertEquals(1,array.length);
            assertFalse(isNaN(array[0]));
        }
        
        
    }
    
}
