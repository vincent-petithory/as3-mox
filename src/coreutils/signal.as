/*
 * signal.as
 * This file is part of as3-coreutils 
 *
 * Copyright (C) 2009 - Vincent
 *
 * as3-coreutils is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * as3-coreutils is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
 
package coreutils 
{

    public const signal:Function = function(
                                            sig:String, 
                                            callee:Function = null, 
                                            op:int = 0, 
                                            ...args
                                        ):Boolean 
    {
        var sigs:Vector.<String>;
        if (callee != null)
        {
            if (op > 0)
            {
                sigs = dict[callee];
                if (sigs == null)
                {
                    sigs = new Vector.<String>();
                    sigs.push(sig);
                    dict[callee] = sigs;
                    return true;
                }
                else
                {
                    if (sigs.indexOf(sig) == -1)
                    {
                        sigs.push(sig);
                        return true;
                    }
                    return false;
                }
            }
            else // (sig < 0)
            {
                // remove signals
                sigs = dict[callee];
                if (sigs != null)
                {
                    var index:int = sigs.indexOf(sig);
                    if (index != -1)
                    {
                        sigs.splice(index,1);
                        return true;
                    }
                }
                return false;
            }
        }
        else
        {
            if (op == 0)
            {
                // call funcs
                var toCall:Function;
                for (toCall in dict)
                {
                    sigs = dict[callee];
                    if (sigs.indexOf(sig) != -1)
                    {
                        callee.apply(null,args);
                    }
                }
            }
        }
        
    }
    
}

import flash.utils.Dictionary;

/**
 * @private
 */
internal var dict:Dictionary = new Dictionary(true);

