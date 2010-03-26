/*
 * ListIteratorTest.as
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
    
    import flash.utils.Dictionary;
    import flash.display.Sprite;

    public class ListIteratorTest extends Test 
    {
        public function ListIteratorTest(name:String)
        {
            super(name);
        }
        
        public function constructorTest():void
        {
            var list:Array = new Array();
            var iterator:ListIterator = new ListIterator(list);
        }
        
        public function constructorThrowsAnErrorIfArgumentIsNotAList():void
        {
            try 
            {
                new ListIterator(new Number(5));
                fail("An ArgumentError should have been thrown");
            } catch (e:ArgumentError) {}
            try 
            {
                new ListIterator(new Dictionary());
                fail("An ArgumentError should have been thrown");
            } catch (e:ArgumentError) {}
            try 
            {
                new ListIterator(new Sprite());
                fail("An ArgumentError should have been thrown");
            } catch (e:ArgumentError) {}
            try 
            {
                new ListIterator(new String("string"));
                fail("An ArgumentError should have been thrown");
            } catch (e:ArgumentError) {}
        }
        
        public function previousIndexReturnsNeg1WhenCursorIsAtTheBeginning():void
        {
            var list:Array = new Array();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
            assertEquals(-1,iterator.previousIndex());
        }
        
        public function previousIndexTest():void
        {
            var list:Array = new Array();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
            iterator.next();
            assertEquals(0,iterator.previousIndex());
            iterator.next();
            assertEquals(1,iterator.previousIndex());
            iterator.next();
            assertEquals(2,iterator.previousIndex());
        }
        
        public function nextIndexReturnsListLengthWhenCursorIsAtTheEnd():void
        {
            var list:Array = new Array();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
            iterator.next();
            iterator.next();
            iterator.next();
            assertEquals(list.length,iterator.nextIndex());
        }
        
        public function nextIndexTest():void
        {
            var list:Vector.<int> = new Vector.<int>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
            assertEquals(0,iterator.nextIndex());
            iterator.next();
            assertEquals(1,iterator.nextIndex());
            iterator.next();
            assertEquals(2,iterator.nextIndex());
        }
        
        public function hasNextTest():void
        {
            var list:Vector.<int> = new Vector.<int>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
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
            var list:Vector.<int> = new Vector.<int>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            var iterator:ListIterator = new ListIterator(list);
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
            var list:Vector.<String> = new Vector.<String>();
            list[0] = "value0";
            list[1] = "value1";
            list[2] = "value2";
            var iterator:ListIterator = new ListIterator(list);
            assertEquals("value0",iterator.next());
            assertEquals("value1",iterator.next());
            assertEquals("value2",iterator.next());
        }
        
        public function nextThrowsAnErrorWhenAskingForAnOutOfBoundsElement():void
        {
            var list:Vector.<String> = new Vector.<String>();
            list[0] = "value0";
            list[1] = "value1";
            list[2] = "value2";
            var iterator:ListIterator = new ListIterator(list);
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
            var list:Vector.<String> = new Vector.<String>();
            list[0] = "value0";
            list[1] = "value1";
            list[2] = "value2";
            var iterator:ListIterator = new ListIterator(list);
            iterator.next();
            iterator.next();
            iterator.next();
            
            assertEquals("value2",iterator.previous());
            assertEquals("value1",iterator.previous());
            assertEquals("value0",iterator.previous());
        }
        
        public function previousThrowsAnErrorWhenAskingForAnOutOfBoundsElement():void
        {
            var list:Vector.<String> = new Vector.<String>();
            list[0] = "value0";
            list[1] = "value1";
            list[2] = "value2";
            var iterator:ListIterator = new ListIterator(list);
            try 
            {
                iterator.previous();
                fail("An Error should have been thrown");
            } catch (e:Error) {}
        }
        
        public function alternateNextAndPreviousCallsReturnsTheSameElement():void
        {
            var list:Vector.<String> = new Vector.<String>();
            list[0] = "value0";
            list[1] = "value1";
            list[2] = "value2";
            
            var iterator:ListIterator = new ListIterator(list);
            iterator.next();
            
            assertEquals("value1",iterator.next());
            assertEquals("value1",iterator.previous());
            assertEquals("value1",iterator.next());
            assertEquals("value1",iterator.previous());
            assertEquals("value1",iterator.next());
        }
        
        public function addTest():void
        {
            var list:Vector.<Number> = new Vector.<Number>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            
            var iterator:ListIterator = new ListIterator(list);
            iterator.next();
            iterator.next();
            iterator.add(1.5);
            
            var expected:Vector.<Number> = new Vector.<Number>();
            expected[0] = 0;
            expected[1] = 1;
            expected[2] = 1.5;
            expected[3] = 2;
            
            assertEquals(expected.length,list.length);
            assertEquals(expected[0],list[0]);
            assertEquals(expected[1],list[1]);
            assertEquals(expected[2],list[2]);
            assertEquals(expected[3],list[3]);
            assertEquals(2, iterator.previousIndex());
            assertEquals(3, iterator.nextIndex());
        }
        
        public function addOnAnEmptyListCreatesTheFirstElement():void
        {
            var list:Vector.<int> = new Vector.<int>();
            
            var iterator:ListIterator = new ListIterator(list);
            iterator.add(0);
            
            var expected:Vector.<int> = new Vector.<int>();
            expected[0] = 0;
            
            assertEquals(expected.length,list.length);
            assertEquals(expected[0],list[0]);
            assertEquals(0, iterator.previousIndex());
            assertEquals(1, iterator.nextIndex());
        }
        
        public function removeTest():void
        {
            var list:Vector.<Number> = new Vector.<Number>();
            list[0] = 0.5;
            list[1] = 0;
            list[2] = 1;
            
            var iterator:ListIterator = new ListIterator(list);
            assertEquals(0.5,iterator.next());
            iterator.remove();
            assertEquals(0,iterator.next());
            
            var expected:Vector.<Number> = new Vector.<Number>();
            expected[0] = 0;
            expected[1] = 1;
            
            assertEquals(expected.length,list.length);
            assertEquals(expected[0],list[0]);
            assertEquals(expected[1],list[1]);
        }
        
        public function setTest():void
        {
            var list:Vector.<Number> = new Vector.<Number>();
            list[0] = 0;
            list[1] = 1.5;
            list[2] = 2;
            
            var iterator:ListIterator = new ListIterator(list);
            assertEquals(0,iterator.next());
            assertEquals(1.5,iterator.next());
            iterator.set(1);
            
            var expected:Vector.<Number> = new Vector.<Number>();
            expected[0] = 0;
            expected[1] = 1;
            expected[2] = 2;
            
            assertEquals(expected.length,list.length);
            assertEquals(expected[0],list[0]);
            assertEquals(expected[1],list[1]);
            assertEquals(expected[2],list[2]);
        }
        
        public function basicScenarioWithSetRemoveAddNextPreviousCalls():void
        {
            var list:Vector.<int> = new Vector.<int>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            list[3] = 3;
            list[4] = 4;
            
            var iterator:ListIterator = new ListIterator(list);
            assertEquals(0,iterator.next());
            iterator.set(5);
            assertEquals(0,iterator.previousIndex());
            assertEquals(1,iterator.nextIndex());
            assertEquals(5,list[0]);
            iterator.add(6);
            assertEquals(5,list[0]);
            assertEquals(6,list[1]);
            assertEquals(1,list[2]);
            assertEquals(1,iterator.next());
        }
        
        public function loopScenarioWithRemoves():void
        {
            var list:Vector.<int> = new Vector.<int>();
            list[0] = 0;
            list[1] = 1;
            list[2] = 2;
            list[3] = 3;
            list[4] = 4;
            
            var iterator:ListIterator = new ListIterator(list);
            
            var i:int = 0;
            while (iterator.hasNext())
            {
                assertEquals(i, iterator.next());
                iterator.remove();
                i++;
            }
            assertEquals(0,list.length);
        }
        
    }
    
}
