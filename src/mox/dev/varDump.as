/*
 * varDump.as
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
package mox.dev 
{

    public function varDump(val:*, indent:int = 4, prefix:int = 0, outputStream:Function = null):String
    {
        this.varDumpRefsIndex = new Array();
        var output:String = __dump__(val,indent,prefix);
        if (outputStream != null)
        {
            outputStream.call(null,output);
        }
        else if (stdout != null)
        {
            stdout.call(null,output);
        }
        this.varDumpRefsIndex = null;
        return output;
    }
    
}

import flash.utils.describeType;
import flash.utils.Dictionary;
import flash.utils.getQualifiedClassName;

import mox.reflect.getClassName;
import mox.reflect.isSimpleType;
import mox.reflect.isComplexType;

internal function __dump__(val:*, indent:int = 4, prefix:int = 0):String
{
    if (isComplexType(val))
        this.varDumpRefsIndex.push(val);
    
    var out:String;
    var i:int;
    var length:uint;
    
    var prefixstr:String = __getindent__(prefix,0);
    var indentstr:String = __getindent__(0,indent);
    
    var prop:String;
    
    if (val == null)
    {
        out = prefixstr+"null";
    }
    else if (val == undefined)
    {
        out = prefixstr+"undefined";
    }
    else if (val is String)
    {
        out = prefixstr+"String("+String(val).length+") \""+String(val)+"\"";
    }
    else if (val is Boolean)
    {
        out = prefixstr+"Boolean("+Boolean(val)+")";
    }
    else if (val is XML)
    {
        var xmlPrettyPrintingCache:Boolean = XML.prettyPrinting;
        var xmlPrettyIndentCache:int = XML.prettyIndent;
        XML.prettyPrinting = true;
        XML.prettyIndent = indent;
        
        out = prefixstr+"XML() {\n";
        var xmlout:String = val.toXMLString();
        xmlout = xmlout.split("\n").map(__PUTPREFIX__, {prefix: prefixstr+indentstr}).join("\n");
        out += xmlout+"\n";
        out += prefixstr+"}";
        
        XML.prettyPrinting = xmlPrettyPrintingCache;
        XML.prettyIndent = xmlPrettyIndentCache;
    }
    else if (val is XMLList)
    {
        var xmlPrettyPrintingCache2:Boolean = XML.prettyPrinting;
        var xmlPrettyIndentCache2:int = XML.prettyIndent;
        XML.prettyPrinting = true;
        XML.prettyIndent = indent;
        
        out = prefixstr+"XMLList() {\n";
        var xmllistout:String = val.toXMLString();
        xmllistout = xmllistout.split("\n").map(__PUTPREFIX__, {prefix: prefixstr+indentstr}).join("\n");
        out += xmllistout+"\n";
        out += prefixstr+"}";
        
        XML.prettyPrinting = xmlPrettyPrintingCache2;
        XML.prettyIndent = xmlPrettyIndentCache2;
    }
    else if (!isNaN(val))
    {
        if (val > int.MAX_VALUE && Math.floor(val) == val)
        {
            out = prefixstr+"uint("+uint(val)+")";
        }
        else if (val is int)
        {
            out = prefixstr+"int("+Number(val)+")";
        }
        else
        {
            out = prefixstr+"Number("+Number(val)+")";
        }
    }
    else if (val is Array)
    {
        length = val.length;
        out = prefixstr+"array("+length+") [\n";
        for (i = 0; i<length; i++)
        {
            if (isSimpleType(val[i]) || this.varDumpRefsIndex.indexOf(val[i]) == -1)
            {
                if (isComplexType(val[i]))
                    this.varDumpRefsIndex.push(val[i]);
                out += prefixstr+indentstr+"["+i.toString()+"] =>\n"+__dump__(val[i], indent, prefix+indent)+"\n";
            }
            else
            {
                out += prefixstr+indentstr+"["+i.toString()+"] =>\n"+prefixstr+indentstr+"*RECURSION*\n";
            }
        }
        out += prefixstr+"]";
    }
    else if (val is Dictionary)
    {
        length = 0;
        var buf:String = "";
        for (prop in val)
        {
            if (isSimpleType(val[prop]) || this.varDumpRefsIndex.indexOf(val[prop]) == -1)
            {
                if (isComplexType(val[prop]))
                    this.varDumpRefsIndex.push(val[prop]);
                buf += prefixstr+indentstr+"["+prop+"] =>\n"+__dump__(val[prop], indent, prefix+indent)+"\n";
            }
            else
            {
                out += prefixstr+indentstr+"["+prop+"] =>\n"+prefixstr+indentstr+"*RECURSION*\n";
            }
            length++;
        }
        out = prefixstr+"Dictionary("+length+") {\n";
        out += buf;
        out += prefixstr+"}";
    }
    else if (
            val is Vector.<*> || 
            String(describeType(val).@name).indexOf("Vector") != -1
        )
    {
        length = val.length;
        var rawT:String = describeType(val).@name;
        var p:RegExp = new RegExp("__AS3__.vec::","gi");
        var vectorType:String = rawT.replace(p,"");
        out = prefixstr+vectorType+"("+length+","+val.fixed+") [\n";
        for (i = 0; i<length; i++)
        {
            if (isSimpleType(val[i]) || this.varDumpRefsIndex.indexOf(val[i]) == -1)
            {
                if (isComplexType(val[i]))
                    this.varDumpRefsIndex.push(val[i]);
                out += prefixstr+indentstr+"["+i.toString()+"] =>\n"+__dump__(val[i], indent, prefix+indent)+"\n";
            }
            else
            {
                out += prefixstr+indentstr+"["+i.toString()+"] =>\n"+prefixstr+indentstr+"*RECURSION*\n";
            }
        }
        out += prefixstr+"]";
    }
    else if (val is Class)
    {
        out = prefixstr+"Class("+getQualifiedClassName(val)+")";
    }
    else if (val is Function)
    {
        var funcType:String = describeType(val).@name;
        if (funcType.indexOf("MethodClosure") != -1)
            out = prefixstr+"MethodClosure()";
        else
            out = prefixstr+"Function()";
    }
    else
    {
        out = prefixstr+getClassName(val)+"() {\n";
        // loop on public properties, constants, getter/setters
        var props:XMLList = describeType(val).children().(localName() == "accessor" || localName() == "variable" || localName() == "constant").(attribute("access") == undefined || attribute("access").toString().indexOf("writeonly") == -1).@name;
        for each (prop in props)
        {
            if (isSimpleType(val[prop]) || this.varDumpRefsIndex.indexOf(val[prop]) == -1)
            {
                if (isComplexType(val[prop]))
                    this.varDumpRefsIndex.push(val[prop]);
                out += prefixstr+indentstr+"["+prop+"] =>\n"+__dump__(val[prop], indent, prefix+indent)+"\n";
            }
            else
            {
                out += prefixstr+indentstr+"["+prop+"] =>\n"+prefixstr+indentstr+"*RECURSION*\n";
            }
        }
        
        // loop on dynamic properties
        for (prop in val)
        {
            if (isSimpleType(val[prop]) || this.varDumpRefsIndex.indexOf(val[prop]) == -1)
            {
                if (isComplexType(val[prop]))
                    this.varDumpRefsIndex.push(val[prop]);
                out += prefixstr+indentstr+"["+prop+"] =>\n"+__dump__(val[prop], indent, prefix+indent)+"\n";
            }
            else
            {
                out += prefixstr+indentstr+"["+prop+"] =>\n"+prefixstr+indentstr+"*RECURSION*\n";
            }
        }
        out += prefixstr+"}";
    }
    return out;
}

internal var varDumpRefsIndex:Array;

internal const INDENTSTR:String = " ";

internal function __getindent__(prefix:int,indent:int):String
{
    var indentstr:String = "";
    var n:int = prefix+indent;
    while (--n>-1)
    {
        indentstr+=INDENTSTR;
    }
    return indentstr;
}

internal const __PUTPREFIX__:Function = function (item:*, index:int, array:Array):String
{
    return this.prefix+item;
}
