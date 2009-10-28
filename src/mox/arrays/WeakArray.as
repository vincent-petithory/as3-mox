/*
 * WeakArray.as
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
    
    import flash.errors.IllegalOperationError;
    
    import flash.utils.Dictionary;
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    public dynamic class WeakArray extends Proxy 
    {
    
        /**
	     * The backed array that 
	     * supports this <code>WeakArray</code>.
	     */
	    protected var array:Array;
	    
	    /**
	     * A registry, to increase speed when searching.
	     */
	    protected var registry:Dictionary;
        
        /**
         * Constructor.
         */
        public function WeakArray(...args)
        {
		    registry = new Dictionary(true);
		    var n:int = args.length;
            if (n == 1 && args[0] is uint)
		    {
			    array = new Array(uint(args[0]));
		    }
		    else
		    {
			    array = new Array();
			    if (n > 0)
			        this.push.apply(null,args);
		    }
        }
        
        //---------------------------------------------------------------------
        // Array API
        //---------------------------------------------------------------------
        
        public function get length():uint
        {
			return this.array.length;
		}
        
        public function concat(...args):WeakArray
        {
			return fromArray(this.array.concat.apply(null,args));
		}
		
		public function every(callback:Function, thisObject:* = null):Boolean
		{
			var a:Array = this.toArray();
			return a.every(callback,thisObject);
		}
		
		public function filter(callback:Function, thisObject:* = null):WeakArray
		{
			return fromArray(this.toArray().filter(callback,thisObject));
		}
		
		public function forEach(callback:Function, thisObject:* = null):void
		{
			var a:Array = this.toArray();
			a.forEach(callback,thisObject);
			this.array = fromArray(a).array;
		}
		
		public function indexOf(searchElement:*, fromIndex:int = 0):int
		{
			return this.toArray().indexOf(searchElement,fromIndex);
		}
        
        public function join(sep:*):String
        {
			return this.toArray().join(sep);
		}
        
        public function lastIndexOf(searchElement:*, fromIndex:int = 0x7fffffff):int
        {
			return this.toArray().lastIndexOf(searchElement,fromIndex);
		}
        
        public function pop():*
		{
			var d:Dictionary = this.array.pop();
			for (var val:* in d)
                    return val;
		}
        
        public function push(...args):uint
        {
            return this.array.push.apply(null,atoda(args));
        }
        
        public function reverse():WeakArray
        {
			var reverseArray:Array = this.array.reverse();
			var reverseWA:WeakArray = new WeakArray();
			reverseWA.array = reverseArray;
			return reverseWA;
		}
		
		public function shift():*
		{
			var d:Dictionary = this.array.shift();
			for (var val:* in d)
                    return val;
		}
		
		public function slice(startIndex:int = 0, endIndex:int = 16777215):WeakArray
		{
			var a:Array = this.array.slice(startIndex,endIndex);
			var wa:WeakArray = new WeakArray();
			wa.array = a;
			return wa;
		}
		
		public function some(callback:Function, thisObject:* = null):Boolean
		{
			var a:Array = this.toArray();
			return a.some(callback,thisObject);
		}
		
		public function sort(...args):WeakArray
		{
			var a:Array = this.array.sort.apply(null,args);
			var wa:WeakArray = new WeakArray();
			wa.array = a;
			return wa;
		}
		
		public function sortOn(fieldName:Object, options:Object = null):WeakArray
		{
			var a:Array = this.array.sortOn(fieldName,options);
			var wa:WeakArray = new WeakArray();
			wa.array = a;
			return wa;
		}
		
		public function splice(startIndex:int, deleteCount:int, ...values):WeakArray
		{
			var args:Array = [startIndex,deleteCount].concat(values);
			var a:Array = this.array.splice.apply(null,args);
			return fromArray(a);
		}
		
		public function toLocaleString():String
		{
			return this.toArray().toLocaleString();
		}
		
		public function toString():String
		{
			return this.toArray().toString();
		}
		
		public function unshift(...args):void
        {
			this.array.push.apply(null,atoda(args));
		}
		
		//---------------------------------------------------------------------
	    // WeakArray specific API
	    //---------------------------------------------------------------------
	    
	    public function toArray():Array
	    {
			var n:int = this.array.length;
			var a:Array = new Array(n);
			while (--n>-1)
			{
				a[n] = this.flash_proxy::getProperty(n);
			}
			return a;
		}
		
        /**
         * Array to Dictionary Array
         */
        protected function atoda(a:Array):Array
        {
			var n:int = a.length;
            var da:Array = new Array(n);
            while (--n>-1)
            {
                var d:Dictionary = new Dictionary(true);
	            d[a[n]] = true;
                da[n] = d;
            }
            return da;
		}
		
		public static function fromArray(array:Array):WeakArray
        {
			var n:int = array.length;
			var wa:WeakArray = new WeakArray(n);
			while (--n>-1)
			{
				// Does the required insertion of a Dictionary
				wa[n] = array[n];
			}
			return wa;
		}
        
        //---------------------------------------------------------------------
	    // flash_proxy overrides
	    //---------------------------------------------------------------------
	
	    /**
	     * @private
	     */
	    flash_proxy override function callProperty(name:*, ...rest):*
	    {
		    var result:* = array[name].apply(this.array, rest);
		    return result;
	    }
	    
	    /**
	     * @private
	     */
	    flash_proxy override function deleteProperty(name:*):Boolean
	    {
		    if (array[name] != undefined)
		    {
		        var val:Dictionary = array[name];
			    delete registry[val];
			    delete array[name];
			    return true;
		    }
		    return false;
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function getProperty(name:*):*
	    {
	        var index:Number = parseInt(name);
	        if (isNaN(index))
	            return array[name];
            
            var d:Dictionary = array[index] as Dictionary;
            if (d != null)
            {
                for (var val:* in d)
                    return val;
            }
		    return undefined;
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function getDescendants(name:*):*
	    {
		    throw new IllegalOperationError("The descendants operator is not supported");
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function hasProperty(name:*):Boolean
	    {
	        var index:Number = parseInt(name);
	        if (isNaN(index))
	            return array[name] != undefined;
	        else
		        return this.flash_proxy::getProperty(name) != undefined;
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function isAttribute(name:*):Boolean
	    {
		    throw new IllegalOperationError("The isAttribute operation is not supported");
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function nextName(index:int):String
	    {
		    // index are zero-based
		    return (index-1).toString();
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function nextNameIndex(index:int):int
	    {
		    return index < array.length ? index + 1 : 0;
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function nextValue(index:int):* 
	    {
		    // index are zero-based
		    return this.flash_proxy::getProperty(index-1);
	    }
	
	    /**
	     * @private
	     */
	    flash_proxy override function setProperty(name:*, value:*):void
	    {
	        var d:Dictionary = new Dictionary(true);
	        d[value] = true;
            array[name] = d;
	    }
        
    }
    
}
