/*
 * setlocale.as
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

    import astre.api.*;
    
    import flash.utils.ByteArray;
    import flash.utils.describeType;
    import flash.display.Sprite;
    
    import tinker.mocks.*;
    

    public class varDumpTest extends Test 
    {
        public function varDumpTest(name:String)
        {
            super(name);
        }
        
        public function dumpSimpleTypeTest():void
        {
            var s:String = "SomeString";
            assertEquals('String(10) "SomeString"',varDump(s));
            
            var i:int = 2;
            assertEquals("int(2)",varDump(i));
            
            var il:int = -2;
            assertEquals("int(-2)",varDump(il));
            
            var ui:uint = int.MAX_VALUE+1;
            assertEquals("uint("+(int.MAX_VALUE+1)+")",varDump(ui));
            
            var ui2:uint = 5;
            assertEquals("int(5)",varDump(ui2));
            
            var n:Number = 0.7;
            assertEquals("Number(0.7)",varDump(n));
            
            var bf:Boolean = false;
            assertEquals("Boolean(false)",varDump(bf));
            
            var bt:Boolean = true;
            assertEquals("Boolean(true)",varDump(bt));
        }
        
        public function dumpMethodClosureTest():void
        {
            var result:String = "MethodClosure()";
            assertEquals(result,varDump(dumpMethodClosureTest));
        }
        
        public function dumpFunctionTest():void
        {
            var result:String = "Function()";
            var f1:Function = function anonymousFunc():void {};
            function f2():void {};
            assertEquals(result,varDump(f1));
            assertEquals(result,varDump(f2));
        }
        
        public function dumpSimpleArrayTest():void
        {
            var a:Array = new Array();
            a.push(-5);
            a.push(10);
            a.push(0.25);
            a.push("SomeString");
            a.push(true);
            
            var result:String = "array(5) [\n"+
                    "    [0] =>\n    int(-5)\n"+
                    "    [1] =>\n    int(10)\n"+
                    "    [2] =>\n    Number(0.25)\n"+
                    '    [3] =>\n    String(10) "SomeString"\n'+
                    "    [4] =>\n    Boolean(true)\n"+
                    "]";
            assertEquals(result,varDump(a));
        }
        
        public function dumpSimpleVectorTest():void
        {
            var v:Vector.<String> = new Vector.<String>();
        
            v.push("SomeString1");
            v.push("SomeString12");
            v.push("SomeString123");
            
            var result:String = "Vector.<String>(3,false) [\n"+
                    '    [0] =>\n    String(11) "SomeString1"\n'+
                    '    [1] =>\n    String(12) "SomeString12"\n'+
                    '    [2] =>\n    String(13) "SomeString123"\n'+
                    "]";
            assertEquals(result,varDump(v));
        }
        
        public function dumpMultiArrayTest():void
        {
            var a:Array = new Array();
            var a0:Array = new Array(0,1,2,4);
            var a1:Array = new Array("v0","v1","v2","v3");
            var a10:Array = new Array("x","xx","xxx","xxxx");
            var a2:Array = new Array(true,true,false,true);
            a.push(a0);
            a1.push(a10);
            a.push(a1);
            a.push(a2);
            var result:String = "array(3) [\n"+
            "    [0] =>\n"+
            "    array(4) [\n"+
            "        [0] =>\n"+
            "        int(0)\n"+
            "        [1] =>\n"+
            "        int(1)\n"+
            "        [2] =>\n"+
            "        int(2)\n"+
            "        [3] =>\n"+
            "        int(4)\n"+
            "    ]\n"+
            "    [1] =>\n"+
            "    array(5) [\n"+
            "        [0] =>\n"+
            "        String(2) \"v0\"\n"+
            "        [1] =>\n"+
            "        String(2) \"v1\"\n"+
            "        [2] =>\n"+
            "        String(2) \"v2\"\n"+
            "        [3] =>\n"+
            "        String(2) \"v3\"\n"+
            "        [4] =>\n"+
            "        array(4) [\n"+
            "            [0] =>\n"+
            "            String(1) \"x\"\n"+
            "            [1] =>\n"+
            "            String(2) \"xx\"\n"+
            "            [2] =>\n"+
            "            String(3) \"xxx\"\n"+
            "            [3] =>\n"+
            "            String(4) \"xxxx\"\n"+
            "        ]\n"+
            "    ]\n"+
            "    [2] =>\n"+
            "    array(4) [\n"+
            "        [0] =>\n"+
            "        Boolean(true)\n"+
            "        [1] =>\n"+
            "        Boolean(true)\n"+
            "        [2] =>\n"+
            "        Boolean(false)\n"+
            "        [3] =>\n"+
            "        Boolean(true)\n"+
            "    ]\n"+
            "]";
            assertEquals(result, varDump(a));
        }
        
        public function dumpMultiVectorTest():void
        {
            var v:Vector.<Vector.<Vector.<Vector.<int>>>> = new Vector.<Vector.<Vector.<Vector.<int>>>>();
            var v000:Vector.<int> = new Vector.<int>();
            v000.push(0,1,2,4);
            var v001:Vector.<int> = new Vector.<int>();
            v001.push(0,1,2,4);
            var v010:Vector.<int> = new Vector.<int>();
            v010.push(0,1,2,4);
            var v011:Vector.<int> = new Vector.<int>();
            v011.push(0,1,2,4);
            var v100:Vector.<int> = new Vector.<int>();
            v100.push(0,1,2,4);
            var v101:Vector.<int> = new Vector.<int>();
            v101.push(0,1,2,4);
            var v110:Vector.<int> = new Vector.<int>();
            v110.push(0,1,2,4);
            var v111:Vector.<int> = new Vector.<int>();
            v111.push(0,1,2,4);
            
            var v00:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
            v00.push(v000);
            v00.push(v001);
            
            var v01:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
            v01.push(v010);
            v01.push(v011);
            
            var v10:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
            v10.push(v100);
            v10.push(v101);
            
            var v11:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
            v11.push(v110);
            v11.push(v111);
            
            var v0:Vector.<Vector.<Vector.<int>>> = new Vector.<Vector.<Vector.<int>>>();
            v0.push(v00);
            v0.push(v01);
            
            var v1:Vector.<Vector.<Vector.<int>>> = new Vector.<Vector.<Vector.<int>>>();
            v1.push(v10);
            v1.push(v11);
            
            v.push(v0);
            v.push(v1);
            
            var result:String = "Vector.<Vector.<Vector.<Vector.<int>>>>(2,false) [\n"+
            "    [0] =>\n"+
            "    Vector.<Vector.<Vector.<int>>>(2,false) [\n"+
            "        [0] =>\n"+
            "        Vector.<Vector.<int>>(2,false) [\n"+
            "            [0] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "            [1] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "        ]\n"+
            "        [1] =>\n"+
            "        Vector.<Vector.<int>>(2,false) [\n"+
            "            [0] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "            [1] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "        ]\n"+
            "    ]\n"+
            "    [1] =>\n"+
            "    Vector.<Vector.<Vector.<int>>>(2,false) [\n"+
            "        [0] =>\n"+
            "        Vector.<Vector.<int>>(2,false) [\n"+
            "            [0] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "            [1] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "        ]\n"+
            "        [1] =>\n"+
            "        Vector.<Vector.<int>>(2,false) [\n"+
            "            [0] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "            [1] =>\n"+
            "            Vector.<int>(4,false) [\n"+
            "                [0] =>\n"+
            "                int(0)\n"+
            "                [1] =>\n"+
            "                int(1)\n"+
            "                [2] =>\n"+
            "                int(2)\n"+
            "                [3] =>\n"+
            "                int(4)\n"+
            "            ]\n"+
            "        ]\n"+
            "    ]\n"+
            "]";
            
            assertEquals(result,varDump(v));
        }
        
        public function dumpObjectTest():void
        {
            var object:Object = {
                nconst : "nconst", 
                ngettersetter : "ngettersetter", 
                nvar : "nvar", 
                ngetter : "ngetter" 
            };
            // order in which properties appear may be different, so we 
            // check they are all here.
            var dump:String = varDump(object);
            assertNotEquals(-1,dump.indexOf("[nconst]"));
            assertNotEquals(-1,dump.indexOf("[ngettersetter]"));
            assertNotEquals(-1,dump.indexOf("[nvar]"));
            assertNotEquals(-1,dump.indexOf("[ngetter]"));
        }
        
        public function dumpClassInstanceTest():void
        {
            var object:VarDumpGeneralObject = new VarDumpGeneralObject();
            // order in which properties appear may be different, so we 
            // check they are all here.
            var dump:String = varDump(object);
            assertNotEquals(-1,dump.indexOf("[nconst]"));
            assertNotEquals(-1,dump.indexOf("[ngettersetter]"));
            assertNotEquals(-1,dump.indexOf("[nvar]"));
            assertNotEquals(-1,dump.indexOf("[ngetter]"));
        }
        
        public function dumpDynamicClassInstanceTest():void
        {
            var object:DynamicVarDumpGeneralObject = new DynamicVarDumpGeneralObject();
            object.dynvar1 = "someDynVar";
            object.dynvar2 = "someDynVar";
            // order in which properties appear may be different, so we 
            // check they are all here.
            var dump:String = varDump(object);
            assertNotEquals(-1,dump.indexOf("[nconst]"));
            assertNotEquals(-1,dump.indexOf("[ngettersetter]"));
            assertNotEquals(-1,dump.indexOf("[nvar]"));
            assertNotEquals(-1,dump.indexOf("[ngetter]"));
            assertNotEquals(-1,dump.indexOf("[dynvar1]"));
            assertNotEquals(-1,dump.indexOf("[dynvar2]"));
        }
        
        public function dumpClassTest():void
        {
            var cls:Class = Sprite;
            var result:String = "Class(flash.display::Sprite)";
            assertEquals(result, varDump(cls));
        }
        
    }
    
}
