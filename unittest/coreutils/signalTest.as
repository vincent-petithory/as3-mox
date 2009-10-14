package coreutils 
{

    import astre.api.*;

    public class signalTest extends Test 
    {
        public function signalTest(name:String)
        {
            super(name);
        }
        
        override public function setUp():void
        {
            signal("*","*");
            _someFuncCalledTimes = 0;
        }
        
        override public function tearDown():void
        {
            signal("*","*");
        }
        
        public function implicitAddSignalAndTriggerItIsOk():void
        {
            signal("mySignal", someFunc);
            var tc:int = _someFuncCalledTimes;
            signal("mySignal");
            assertEquals(tc+1,_someFuncCalledTimes);
        }
        
        public function addSignalAndTriggerItIsOk():void
        {
            signal("mySignal", someFunc, 1);
            signal("mySignal");
            assertEquals(1,_someFuncCalledTimes);
        }
        
        public function deleteAllIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("mySignal3", someFunc);
            signal("mySignal4", someFunc);
            assertEquals("",signal("*",undefined,-1));
            assertEquals(0,_someFuncCalledTimes);
        }
        
        public function callAllWithSigWildcardIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("mySignal3", someFunc);
            signal("mySignal4", someFunc);
            signal("*");
            assertEquals(4,_someFuncCalledTimes);
        }
        
        public function callAllWithRegExpSigIsOk():void
        {
            signal("mySignal", someFunc);
            signal("mySignal2", someFunc);
            signal("myBadSignal", someFunc);
            signal("myBadSignal2", someFunc);
            signal(/mySignal/);
            assertEquals(2,_someFuncCalledTimes);
        }
        
        // Privates
        
        private var _someFuncCalledTimes:int = 0;
        
        private function someFunc():void
        {
            _someFuncCalledTimes++;
        }
        
    }
    
}
