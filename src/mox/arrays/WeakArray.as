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
        
        public function push(...args):uint
        {
            var l:int = args.length;
            var args2:Array = new Array(l)
            while (--l>-1)
            {
                var d:Dictionary = new Dictionary(true);
	            d[args[l]] = true;
                args2[l] = d;
            }
            return this.array.push.apply(null,args2);
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
                {
                    return val;
                }
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
