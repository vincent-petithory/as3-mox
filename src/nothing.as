/*
 * nothing.as
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
package mox 
{
   
   /**
    * The nothing constant is an additional type to 
    * <code>null</code> and <code>void</code>.
    * 
    * <p>It is mainly used as a return type. As an example, a function 
    * may return the value of an array's item. If that item does not exist, 
    * typically, either null is returned or an error is thrown. The problem is 
    * that the item can have the <code>null</code> value. 
    * Using the <code>nothing</code> constant instead of 
    * <code>null</code> makes clear an item does not exist.</p>
    */
   public const nothing:* = new Object();
   
}
