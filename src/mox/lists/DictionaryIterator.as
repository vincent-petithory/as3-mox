/*
 * DictionaryIterator.as
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
 * along with <program name>; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package mox.lists 
{

    import flash.errors.IllegalOperationError;
    import flash.utils.describeType;
    
    /**
     * A DictionaryIterator allows to iterate trhough and manipulate 
	 * a dictionary object, like an Object, Dictionary, and any 
	 * object that has dynamic properties which are enumerable through 
	 * for .. in and for each .. in loops. 
     */
    public class DictionaryIterator 
    {
		
		/** 
		 * The dictionary to manage.
		 */
        protected var $dictionary:*;
		
		/** 
		 * An internal list to keep track of the order of the entries 
		 * of the dictionary.
		 */
        protected var $list:Array;
        
		/** 
		 * The position of the cursor in the dictionary.
		 */
        protected var $cursor:int;
		
		/** 
		 * @private
		 */
		private var _allowEditMethodCall:Boolean = false;
        
		/**
		 * Constructor
		 * 
		 * @param dictionary The dictionary this DictionaryIterator 
		 * will manage.
		 */
        public function DictionaryIterator(dictionary:*)
        {
            super();
            this.$dictionary = dictionary;
            this.$cursor = 0;
			this.tell();
        }
		
		/**
		 * Tells the iterator that the content of the dictionary has 
		 * been changed externally.
		 */
		public function tell():void
		{
			this.$list = new Array();
			for (var key:* in this.$dictionary)
			{
				this.$list.push(key);
			}
			this.$cursor = Math.min(this.$list.length-1,this.$cursor);
			if (this.$cursor < 0)
				this.$cursor = 0;
		}
		
		/** 
		 * The number of entries in the dictionary.
		 */
		public function get length():uint
		{
			return this.$list.length;
		}
        
        /**
         * Adds an entry at the position of the cursor. 
         * 
         * <p>This method is very useful when you want to add 
		 * entries while iterating through a dictionary.</p>
         * 
         * <p>The position where the entry is added is 
         * between the entry that would be returned by previous() and the 
         * entry that would be returned by next().</p>
         * 
		 * @param key The value of the key to add. The key must not exist in 
		 * the dictionary.
		 * @param value The new value of the value. 
		 * 
		 * @throws ArgumentError if the key already 
		 * exists in the dictionary.
         * @throws ArgumentError if the entry could not be added 
         * for some reason (e.g, the length of the dictionary 
         * could not be changed, the key already exists, etc.).
         */
        public function add(key:*, value:*):void
        {
			if (this.$list.indexOf(key) != -1)
			{
				throw new ArgumentError("The specified key "+
					"already exists in the dictionary");
			}
            var length:int = this.$list.length;
            if (length == 0)
            {
                try 
                {
                    this.$list[0] = key;
					this.$dictionary[key] = value;
                } catch (e:Error)
                {
                    throw new ArgumentError("The element could not be added "+
                        "to the list for the following reason : "+e.message
                    );
                }
            }
            else
            {
                var k:* = this.$list[this.$cursor];
                var k2:*;
                var n:int = this.$cursor;
                try 
                {
                    this.$list[this.$cursor] = key;
					this.$dictionary[key] = value;
                    while (++n < length)
                    {
                        k2 = k;
                        k = this.$list[n];
                        this.$list[n] = k2;
                    }
                    this.$list[n] = k;
                } catch (e:Error)
                {
                    throw new ArgumentError("The entry could not be added "+
                        "to the dictionary for the following reason : "+e.message
                    );
                }
            }
            _allowEditMethodCall = false;
            this.$cursor++;
        }
        
        /**
         * Returns true if a call to next() will return an entry.
         * @return true if a call to next() will return an entry.
         */
        public function hasNext():Boolean
        {
            return this.$cursor < this.$list.length;
        }
        
        /**
         * Returns true if a call to previous() will return an entry.
         * @return true if a call to previous() will return an entry.
         */
        public function hasPrevious():Boolean
        {
            return this.$cursor > 0;
        }
        
        /**
         * Returns the next entry in the dictionary, if any. 
         * Otherwise, an error is thrown. 
         * The availability of an entry can be checked with hasNext().
         * 
         * @throws RangeError if there is no entry to return.
         * @return the next entry in the dictionary. An entry is an object with 
		 * a key property and a value property.
         */
        public function next():*
        {
            if (this.$cursor == this.$list.length)
                throw new RangeError("No more entries in the forward direction");
			var key:* = this.$list[this.$cursor];
            this.$cursor++;
            _allowEditMethodCall = true;
            return {key: key, value: this.$dictionary[key]};
        }
        
        /**
         * Returns the index of the next entry, or the number 
		 * of entries in the dictionary if no more entry is available.
         * @return the index of the next entry, or the number 
		 * of entries in the dictionary if no more entry is available.
         */
        public function nextIndex():int
        {
            return this.$cursor;
        }
        
        /**
         * Returns the previous entry in the dictionary, if any. 
         * Otherwise, an error is thrown. 
         * The availability of an element can be checked with hasPrevious().
         * 
         * @throws RangeError if there is no element to return.
         * @return the previous element in the list. An entry is an object with 
		 * a key property and a value property.
         */
        public function previous():*
        {
            if (this.$cursor == 0)
                throw new RangeError("No more elements in the reverse direction");
            this.$cursor--;
            _allowEditMethodCall = true;
			var key:* = this.$list[$cursor];
			return {key: key, value: this.$dictionary[key]};
        }
        
        /**
         * Returns the index of the previous entry, or 
         * -1 if no more entry is available.
         * @return the index of the previous element, or 
         * -1 if no more entry is available.
         */
        public function previousIndex():int
        {
            return this.$cursor-1;
        }
        
        /**
         * Removes the last entry that was returned by next() or previous().
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
			var key:* = this.$list[stop+1];
            try 
            {
                while (--n > stop)
                {
                    e2 = e;
                    e = this.$list[n];
                    this.$list[n] = e2;
                }
                this.$list.length = this.$list.length-1;
				delete this.$dictionary[key];
            } catch (e:Error)
            {
                throw new ArgumentError("The entry could not be added "+
                    "to the dictionary for the following reason : "+e.message
                );
            }
            this.$cursor--;
            _allowEditMethodCall = false;
        }
        
        /**
         * Sets the value of the last entry that was returned by next() 
         * or previous().
         * set() can only be called after next() or previous() has been 
         * called, and remove() has not been called after the last call 
         * to next() or previous().
         * 
		 * @param key The new value of the key. The key must not exist in the 
		 * dictionary. Pass undefined to leave the key unchanged.
		 * @param value The new value of the value. 
		 * Pass undefined to leave the value unchanged.
		 * 
         * @throws IllegalOperationError if next() or previous has 
         * not been called, or remove() has been called after the last call 
         * to next() or previous().
		 * @throws ArgumentError if the new key already 
		 * exists in the dictionary.
         */
        public function set(key:* = undefined, value:* = undefined):void
        {
            if (!_allowEditMethodCall)
            {
                throw new IllegalOperationError("next() or previous() must be called prior to set()");
            }
			if (key != undefined && this.$list[$cursor-1] != key)
			{
				if (this.$list.indexOf(key) != -1)
				{
					throw new ArgumentError("The specified key "+
					"already exists in the dictionary");
				}
				else
				{
					delete this.$dictionary[this.$list[$cursor-1]];
					this.$list[$cursor-1] = key;
				}
			}
			if (value != undefined)
				this.$dictionary[this.$list[$cursor-1]] = value;
            _allowEditMethodCall = false;
        }
    }
    
}
