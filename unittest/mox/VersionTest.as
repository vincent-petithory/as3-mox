/*
 * VersionTest.as
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

    import astre.api.*;

    public class VersionTest extends Test 
    {
        public function VersionTest(name:String)
        {
            super(name);
        }
        
		public function extremeVersionTest():void
		{
		    var v:Version = new Version(0xff,0xffff,0xffff,0xffffff);
		    assertEquals(0xffffffff,v._raw1);
		    assertEquals(0xffffffff,v._raw2);
		    assertEquals(Number(Number(0xffffffff)*Math.pow(2,32)+Number(0xffffffff)), v._raw1*Math.pow(2,32)+v._raw2);
		    assertEquals(Number(Number(0xffffffff)*Math.pow(2,32)+Number(0xffffffff)), v.valueOf());
		}
		
		public function nullVersionTest():void
		{
		    var v:Version = new Version(0,0,0,0);
		    assertEquals(0,v._raw1);
		    assertEquals(0,v._raw2);
		    assertEquals(0,v.major);
		    assertEquals(0,v.minor);
		    assertEquals(0,v.revision);
		    assertEquals(0,v.build);
		    assertEquals(0,v.valueOf());
		}
		
		public function fieldsTest():void
		{
		    var v:Version = new Version(1,2,50,4234);
		    assertEquals(1,v.major);
		    assertEquals(2,v.minor);
		    assertEquals(50,v.revision);
		    assertEquals(4234,v.build);
		}
		
		public function formatTest():void
		{
		    var v:Version = new Version(1,2,50,4234);
		    assertEquals("1.2.50.4234", v.toString());
		    assertEquals("v1.2.50 build 4234", v.toString("v$M.$m.$r build $b"));
		}
		
		public function comparisonTest():void
		{
		    var v0:Version = new Version(0,19,97,1234);
		    var v1:Version = new Version(1,2,50,4164);
		    var v2:Version = new Version(1,8,1,8739);
		    var v2x:Version = new Version(1,8,1,8739);
		    
		    assertTrue(v0 < v1);
		    assertTrue(v1 < v2);
		    assertTrue(v2 > v1);
		    assertTrue(v1 <= v2);
		    assertEquals(v2.valueOf(), v2x.valueOf());
		}
		
    }
    
}
