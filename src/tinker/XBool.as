/*
 * XBool.as
 * This file is part of Tinker
 *
 * Copyright (C) 2009 - Vincent Petithory
 *
 * Tinker is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Tinker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Tinker; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, 
 * Boston, MA  02110-1301  USA
 */
package tinker 
{

    public class XBool 
    {
        private var bools:uint;
        
        public function XBool(bools:uint)
        {
		    super();
		    this.bools = bools;
	    }
		
		public function getBool(bools:uint):Boolean
		{
			return (this.bools & bools) == bools;
		}
	
		public function setBools(bools:uint,value:Boolean):void
		{
			if (value)
			{
				// set 1 where there were 0
				this.bools |= bools;
			}
			else
			{
				// take complementary to leave unconcerned flags unmodified
				// use & to force 0 were there was 1 for concerned flags
				this.bools &= ~bools;
			}
		}
	
		public function toString():String
		{
			return this.bools.toString(2);
		}
	
		public function valueOf():uint
		{
			return this.bools;
		}
    }
    
}

