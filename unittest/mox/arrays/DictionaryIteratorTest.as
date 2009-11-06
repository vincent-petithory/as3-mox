/*
 * DictionaryIteratorTest.as
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
    
    import flash.utils.Dictionary;
    import flash.display.Sprite;

    public class DictionaryIteratorTest extends Test 
    {
        public function DictionaryIteratorTest(name:String)
        {
            super(name);
        }
        
        public function constructorTest():void
        {
            var dict:Object = new Object();
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
        }
        
        public function previousIndexReturnsNeg1WhenCursorIsAtTheBeginning():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            assertEquals(-1,iterator.previousIndex());
        }
        
        public function previousIndexTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.next();
            assertEquals(0,iterator.previousIndex());
            iterator.next();
            assertEquals(1,iterator.previousIndex());
            iterator.next();
            assertEquals(2,iterator.previousIndex());
        }
        
        public function nextIndexReturnsListLengthWhenCursorIsAtTheEnd():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.next();
            iterator.next();
            iterator.next();
            assertEquals(3,iterator.nextIndex());
        }
        
        public function nextIndexTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            assertEquals(0,iterator.nextIndex());
            iterator.next();
            assertEquals(1,iterator.nextIndex());
            iterator.next();
            assertEquals(2,iterator.nextIndex());
        }
        
        public function hasNextTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            assertTrue(iterator.hasNext());
            iterator.next();
            assertTrue(iterator.hasNext());
            iterator.next();
            assertTrue(iterator.hasNext());
            iterator.next();
            assertFalse(iterator.hasNext());
            iterator.previous();
            assertTrue(iterator.hasNext());
        }
        
        public function hasPreviousTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            assertFalse(iterator.hasPrevious());
            iterator.next();
            assertTrue(iterator.hasPrevious());
            iterator.previous();
            assertFalse(iterator.hasPrevious());
            iterator.next();
            assertTrue(iterator.hasPrevious());
            iterator.next();
            assertTrue(iterator.hasPrevious());
            iterator.next();
            assertTrue(iterator.hasPrevious());
        }
        
        public function nextTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
			
			var keys:Array = getArrayKeys(dict);
            assertEntryEquals(keys[0],dict[keys[0]],iterator.next());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.next());
            assertEntryEquals(keys[2],dict[keys[2]],iterator.next());
        }
        
        public function nextThrowsAnErrorWhenAskingForAnOutOfBoundsElement():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
			
            iterator.next();
            iterator.next();
            iterator.next();
            try 
            {
                iterator.next();
                fail("An Error should have been thrown");
            } catch (e:Error) {}
        }
        
        public function previousTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
			
            iterator.next();
            iterator.next();
            iterator.next();
            
			var keys:Array = getArrayKeys(dict);
            assertEntryEquals(keys[2],dict[keys[2]],iterator.previous());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.previous());
            assertEntryEquals(keys[0],dict[keys[0]],iterator.previous());
        }
        
        public function previousThrowsAnErrorWhenAskingForAnOutOfBoundsElement():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            try 
            {
                iterator.previous();
                fail("An Error should have been thrown");
            } catch (e:Error) {}
        }
        
        public function alternateNextAndPreviousCallsReturnsTheSameElement():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.next();
            
			var keys:Array = getArrayKeys(dict);
            assertEntryEquals(keys[1],dict[keys[1]],iterator.next());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.previous());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.next());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.previous());
            assertEntryEquals(keys[1],dict[keys[1]],iterator.next());
        }
        
        public function addTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            dict["v3"] = 3;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.next();
            iterator.next();
            iterator.add("v2",2);
            
            var expected:Object = new Object();
            expected["v0"] = 0;
            expected["v1"] = 1;
            expected["v2"] = 2;
            expected["v3"] = 3;
			var keys:Array = getArrayKeys(expected);
            
            assertEquals(keys.length,iterator.length);
            for each (var key:String in keys)
			{
				assertEquals(expected[key],dict[key]);
			}
            assertEquals(2, iterator.previousIndex());
            assertEquals(3, iterator.nextIndex());
        }
        
		public function addExistingKeyThrowsAnErrorTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.next();
            try 
			{
				iterator.add("v1",27);
				fail("An ArgumentError should have been thrown");
			} catch (e:ArgumentError) {}
        }
		
        public function addOnAnEmptyListCreatesTheFirstElement():void
        {
            var dict:Object = new Object();
            
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            iterator.add("v0",0);
            
            assertEquals(1,iterator.length);
            assertEquals(0, iterator.previousIndex());
            assertEquals(1, iterator.nextIndex());
            assertEntryEquals("v0",0,iterator.previous());
            assertEquals(-1, iterator.previousIndex());
            assertEquals(0, iterator.nextIndex());
        }
        
		
        public function removeTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v0.5"] = 0.5;
            dict["v1"] = 1;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
            
            while (iterator.hasNext())
			{
				var entry:Object = iterator.next();
				if (entry.key == "v0.5")
					iterator.remove();
			}
            
            var expected:Object = new Object();
            expected["v0"] = 0;
            expected["v1"] = 1;
			var keys:Array = getArrayKeys(expected);
            
            assertEquals(keys.length,iterator.length);
            for each (var key:String in keys)
			{
				assertEquals(expected[key],dict[key]);
			}
        }
        
        public function setTest():void
        {
            var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1.5;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
			while (iterator.hasNext())
			{
				if (iterator.next().key == "v1")
					iterator.set("v1",1);
			}
			var expected:Object = new Object();
            expected["v0"] = 0;
            expected["v1"] = 1;
            expected["v2"] = 2;
			var keys:Array = getArrayKeys(expected);
            
            assertEquals(keys.length,iterator.length);
            for each (var key:String in keys)
			{
				assertEquals(expected[key],dict[key]);
			}
        }
		
		public function setAnExistingKeyOtherThanTheCurrentKeyThrowsAnError():void
		{
			var dict:Object = new Object();
            dict["v0"] = 0;
            dict["v1"] = 1.5;
            dict["v2"] = 2;
            var iterator:DictionaryIterator = new DictionaryIterator(dict);
			var key:String = iterator.next().key;
			var keys:Array = getArrayKeys(dict);
			var otherKey:String = key;
			while (otherKey == key)
			{
				otherKey = keys[Math.floor(Math.random()*keys.length)];
			}
			
			try
			{
				iterator.set(otherKey,"some value");
				fail("An ArgumentError should have been thrown");
			} catch (e:ArgumentError) {}
		}
        
		private static function assertEntryEquals(expectedKey:*,expectedValue:*, actualEntry:*,testerMessage:String = ""):void
		{
			assertEquals(expectedKey,actualEntry.key);
			assertEquals(expectedValue,actualEntry.value);
		}
		
		private static function getArrayKeys(dict:*):Array
		{
			var keys:Array = new Array();
			for (var key:* in dict)
			{
				keys.push(key);
			}
			return keys;
		}
		
    }
    
}
