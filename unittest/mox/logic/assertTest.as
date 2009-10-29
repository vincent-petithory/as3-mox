/*
 * assertTest.as
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
package mox.logic 
{

    import astre.api.*;

    public class assertTest extends Test 
    {
        public function assertTest(name:String)
        {
            super(name);
        }
        
        public function anErrorIsThrownIfTheConditionIsFalse():void
        {
            try 
            {
                assert(false,"");
                fail("The error is not thrown");
            } catch (e:Error)
            {
                
            }
        }
        
        public function noErrorIsThrownIfTheConditionIsTrue():void
        {
            try 
            {
                assert(true,"");
                
            } catch (e:Error)
            {
                fail("An error is thrown and it should not");
            }
        }
        
        public function theMessageIsCorrectlyFilledInTheError():void
        {
            var message:String = "That message is filled in the error";
            try 
            {
                assert(false,message);
                fail("The error is not thrown");
            } catch (e:Error)
            {
                assertEquals(message, e.message);
            }
        }
        
        public function anCustomErrorIsThrown():void
        {
            try 
            {
                assert(false,"", new TypeError());
                fail("The error is not thrown");
            } catch (te:TypeError)
            {
                
            } catch (e:Error)
            {
                fail("The standard error is thrown instead of the custom one");
            }
        }
        
        public function theMessageIsCorrectlyFilledInTheCustomError():void
        {
            var message:String = "That message is filled in the custom error";
            try 
            {
                assert(false,message, new TypeError());
                fail("The error is not thrown");
            } catch (te:TypeError)
            {
                assertEquals(message, te.message);
            } catch (e:Error)
            {
                fail("The standard error is thrown instead of the custom one");
            }
        }
        
    }
    
}
