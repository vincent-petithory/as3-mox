/*
 * ListIterator.as
 * This file is part of <program name>
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * <program name> is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * <program name> is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with <program name>; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package mox.arrays 
{

    import flash.errors.IllegalOperationError;
    import flash.utils.describeType;
    
    /**
     * A ListIterator allows to iterate through a list based object, like an 
     * Array, a Vector, or a ByteArray. Also works with any object that allows 
     * [] operator access, and a 
     * read/write length property (variable or setter/getter).
     * 
     * <p>For a full iteration on a list, you won't need to use a ListIterator, as 
     * a for each .. in loop will do the job better.
     * You may want to use a ListIterator when you have to keep track of a 
     * position in an array and have tools to operate from a position.<br/>
     * Note that the iterator is bidirectional.</p>
     */
    public class ListIterator 
    {
    
        protected var $list:*;
        
        protected var $cursor:int;
        
        private var _allowEditMethodCall:Boolean = false;
    
        public function ListIterator(list:*)
        {
            super();
            if (
                describeType(list).accessor.(
                    @name == "length" && 
                    @access == "readwrite").length() == 0 && 
                describeType(list).variable.(
                    @name == "length" && 
                    @access == "readwrite").length() == 0 
                )
            {
                throw new ArgumentError(
                    "The list argument is not a list based object"
                );
            }
            this.$list = list;
            this.$cursor = 0;
        }
        
        /**
         * Adds an element at the position of the cursor. 
         * 
         * <p>This method is very 
         * useful when you want to add elements while iterating through a list.
         * Note that this method is generic and works with many types of lists, 
         * so it is not as effective as specific methods of 
         * the list object. </p>
         * 
         * <p>The position is 
         * between the element that would be returned by previous() and the 
         * element that would be returned by next().</p>
         * 
         * @throws ArgumentError if the element could not be added 
         * for some reason (e.g, the type of the element is not compatible 
         * with the one the list allows, the length of the list 
         * could not be changed, etc.).
         */
        public function add(element:*):void
        {
            var length:int = this.$list.length;
            if (length == 0)
            {
                try 
                {
                    this.$list[0] = element;
                } catch (e:Error)
                {
                    throw new ArgumentError("The element could not be added "+
                        "to the list for the following reason : "+e.message
                    );
                }
            }
            else
            {
                var e:* = this.$list[this.$cursor];
                var e2:*;
                var n:int = this.$cursor;
                try 
                {
                    this.$list[this.$cursor] = element;
                    while (++n < length)
                    {
                        e2 = e;
                        e = this.$list[n];
                        this.$list[n] = e2;
                    }
                    this.$list[n] = e;
                } catch (e:Error)
                {
                    throw new ArgumentError("The element could not be added "+
                        "to the list for the following reason : "+e.message
                    );
                }
            }
            _allowEditMethodCall = false;
            this.$cursor++;
        }
        
        /**
         * Returns true if a call to next() will return an element.
         * @return true if a call to next() will return an element.
         */
        public function hasNext():Boolean
        {
            return this.$cursor < this.$list.length;
        }
        
        /**
         * Returns true if a call to previous() will return an element.
         * @return true if a call to previous() will return an element.
         */
        public function hasPrevious():Boolean
        {
            return this.$cursor > 0;
        }
        
        /**
         * Returns the next element in the list, if any. 
         * Otherwise, an error is thrown. 
         * The availability of an element can be checked with hasNext().
         * 
         * @throws RangeError if there is no element to return.
         * @return the next element in the list.
         */
        public function next():*
        {
            if (this.$cursor == this.$list.length)
                throw new RangeError("No more elements in the forward direction");
            var c:int = this.$cursor;
            this.$cursor++;
            _allowEditMethodCall = true;
            return this.$list[c];
        }
        
        /**
         * Returns the index of the next element, or 
         * list.length if no more element is available.
         * @return the index of the next element, or 
         * list.length if no more element is available.
         */
        public function nextIndex():int
        {
            return this.$cursor;
        }
        
        /**
         * Returns the previous element in the list, if any. 
         * Otherwise, an error is thrown. 
         * The availability of an element can be checked with hasPrevious().
         * 
         * @throws RangeError if there is no element to return.
         * @return the previous element in the list.
         */
        public function previous():*
        {
            if (this.$cursor == 0)
                throw new RangeError("No more elements in the reverse direction");
            this.$cursor--;
            _allowEditMethodCall = true;
            return this.$list[$cursor];
        }
        
        /**
         * Returns the index of the previous element, or 
         * list.length if no more element is available.
         * @return the index of the previous element, or 
         * list.length if no more element is available.
         */
        public function previousIndex():int
        {
            return this.$cursor-1;
        }
        
        /**
         * Removes the last element that was returned by next() or previous().
         * remove() can only be called after next() or previous() has been 
         * called, and set() has not been called after the last call 
         * to next() or previous().
         * 
         * @throws IllegalOperationError if next() or previous has 
         * not been called, or set() has been called after the last call 
         * to next() or previous().
         */
        public function remove():void
        {
             if (!_allowEditMethodCall)
            {
                throw new IllegalOperationError("next() or previous() must be called prior to set()");
            }
            var n:int = this.$list.length-1;
            var e:* = this.$list[n];
            var e2:*;
            var stop:int = this.$cursor-2;/* -2 : -1-1 */ 
            try 
            {
                while (--n > stop)
                {
                    e2 = e;
                    e = this.$list[n];
                    this.$list[n] = e2;
                }
                this.$list.length = this.$list.length-1;
            } catch (e:Error)
            {
                throw new ArgumentError("The element could not be added "+
                    "to the list for the following reason : "+e.message
                );
            }
            this.$cursor--;
            _allowEditMethodCall = false;
        }
        
        /**
         * Sets the value of the last element that was returned by next() 
         * or previous().
         * set() can only be called after next() or previous() has been 
         * called, and remove() has not been called after the last call 
         * to next() or previous().
         * 
         * @throws IllegalOperationError if next() or previous has 
         * not been called, or remove() has been called after the last call 
         * to next() or previous().
         */
        public function set(element:*):void
        {
            if (!_allowEditMethodCall)
            {
                throw new IllegalOperationError("next() or previous() must be called prior to set()");
            }
            this.$list[$cursor-1] = element;
            _allowEditMethodCall = false;
        }
    }
    
}
