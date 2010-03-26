/*
 * range.as
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
    
    /** 
	 * Constructs a list of number starting 
	 * from 'start' to 'end', with a 'step' increment.
	 * 
     * @param array an object with the [] operator, and a writeable 
     * length property (any dynamic object, array or vector.&lt;Number|int|uint&gt;
     */
    public function range(array:*, start:Number, end:Number, step:Number = 1):*
    {
        if (step==0)
            throw new ArgumentError("step should not be zero.")
            
        if (end<start)
        {
            if (step>0)
                return array;
        }
        if (end>start)
        {
            if (step<0)
                return array;
        }
        var length:int = Math.floor(Math.abs((end-start)/step));
        array.length = length;
        var i:int = -1;
        while (++i < length)
        {
            array[i] = start + step*i;
        }
        return array;
    }
    
}
