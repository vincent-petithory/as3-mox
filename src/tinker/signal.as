/*
 * signal.as
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

    import flash.utils.Dictionary;
    
    /**
     * 
     * @param sig the name of the signal to work with. Typically a String.
     * Can be the char '*' or a RegExp when the op parameter is strictly 
     * lesser than 0.
     * @param callee the function to work with. Can be the char '*' when 
     * the op parameter is strictly lesser than 0.
     */
    public const signal:Function = function(
                                            sig:*, 
                                            callee:* = undefined, 
                                            op:Number = NaN, 
                                            ...args
                                        ):String 
    {
        var sigs:Vector.<String>;
        if (isNaN(op))
        {
            if (callee is Function)
            {
                // callee specified, user wants to add
                op = 1;
            }
            else if (callee == undefined)
            {
                // no callee, user wants to trigger
                op = 0;
            }
            else if (callee == "*")
            {
                // callee is wilcard, user wants to delete
                op = -1;
            }
            else
            {
                return "Incompatible arg values";
            }
        }
        var index:int;
        var toDel:*;
        var n:int = 0;
        if (op > 0)
        {
            // only allows <callee> as Function and <sig> as String
            if (!(sig is String && sig != "*"))
            {
                return "<sig> must be a valid string";
            }
            if (!(callee is Function))
            {
                return "<callee> must be a Function";
            }
            sigs = dict[callee];
            if (sigs == null)
            {
                sigs = new Vector.<String>();
                sigs.push(sig);
                dict[callee] = sigs;
                return "";
            }
            else
            {
                if (sigs.indexOf(sig) == -1)
                {
                    sigs.push(sig);
                    return "";
                }
                return "Signal "+sig+
                        " already registered for this function";
            }
        }
        else if (op < 0)
        {
            // remove signals
            if (sig == "*")
            {
                if (callee == "*" || callee == undefined)
                {
                    dict = new Dictionary(true);
                    return "";
                }
                else if (callee is Function)
                {
                    delete dict[callee];
                    return "";
                }
                else
                {
                    return "<callee> is not a Function nor *.";
                }
            }
            else if (sig is String)
            {
                if (callee == "*")
                {
                    // call funcs
                    toDel = undefined;
                    for (toDel in dict)
                    {
                        sigs = dict[toDel];
                        if (sigs != null)
                        {
                            index = sigs.indexOf(sig);
                            if (index != -1)
                            {
                                sigs.splice(index,1);
                            }
                        }
                    }
                    return "";
                }
                else if (callee is Function)
                {
                    sigs = dict[callee];
                    if (sigs != null)
                    {
                        index = sigs.indexOf(sig);
                        if (index != -1)
                        {
                            sigs.splice(index,1);
                            return "";
                        }
                    }
                    return "No signal registered for <callee>";
                }
                else
                {
                    return "<callee> is not a Function nor *.";
                }
            }
            else if (sig is RegExp)
            {
                if (callee == "*" || callee == undefined)
                {
                    // call funcs
                    toDel = undefined;
                    for (toDel in dict)
                    {
                        sigs = dict[toDel];
                        if (sigs != null)
                        {
                            n = sigs.length;
                            while (--n>-1)
                            {
                                if (sig.test(sigs[n]))
                                {
                                    // we can do that since we go reverse
                                    sigs.splice(n,1);
                                }
                            }
                        }
                    }
                    return "";
                }
                else if (callee is Function)
                {
                    sigs = dict[callee];
                    if (sigs != null)
                    {
                        n = sigs.length;
                        while (--n>-1)
                        {
                            if (sig.test(sigs[n]))
                            {
                                // we can do that since we go reverse
                                sigs.splice(n,1);
                            }
                        }
                    }
                    return "No signal registered for <callee>";
                }
                else
                {
                    return "<callee> is not a Function nor *.";
                }
            }
            else
            {
                return "<sig> is not a String, RegExp or '*'";
            }
            
        }
        else if (op == 0)
        {
            // call funcs
            var toCall:*;
            if (sig == "*")
            {
                if (callee == "*" || callee == undefined)
                {
                    for (toCall in dict)
                    {
                        sigs = dict[toCall];
                        n = sigs.length;
                        while (--n>-1)
                        {
                            toCall.apply(null,args);
                        }
                    }
                    return "";
                }
                else if (callee is Function)
                {
                    sigs = dict[callee];
                    n = sigs.length;
                    while (--n>-1)
                    {
                        callee.apply(null,args);
                    }
                    return "";
                }
                else
                {
                    return "<callee> has an invalid value";
                }
            }
            else if (sig is String)
            {
                if (callee == "*" || callee == undefined)
                {
                    for (toCall in dict)
                    {
                        sigs = dict[toCall];
                        if (sigs.indexOf(sig) != -1)
                        {
                            toCall.apply(null,args);
                        }
                    }
                    return "";
                }
                else if (callee is Function)
                {
                    sigs = dict[callee];
                    if (sigs.indexOf(sig) != -1)
                    {
                        callee.apply(null,args);
                        return "";
                    }
                    return "No signal registered for <callee>";
                }
                else
                {
                    return "<callee> has an invalid value";
                }
            }
            else if (sig is RegExp)
            {
                if (callee == "*" || callee == undefined)
                {
                    for (toCall in dict)
                    {
                        sigs = dict[toCall];
                        n = sigs.length;
                        while (--n>-1)
                        {
                            if (sig.test(sigs[n]))
                            {
                                toCall.apply(null,args);
                            }
                        }
                    }
                    return "";
                }
                else if (callee is Function)
                {
                    sigs = dict[callee];
                    n = sigs.length;
                    while (--n>-1)
                    {
                        if (sig.test(sigs[n]))
                        {
                            callee.apply(null,args);
                        }
                    }
                    return "";
                }
                else
                {
                    return "<callee> has an invalid value";
                }
            }
        }
        else
        {
            return "Nothing to do for this context";
        }
        return "Unexpected reached line";
    }
    
}

import flash.utils.Dictionary;

/**
 * @private
 */
internal var dict:Dictionary = new Dictionary(true);

