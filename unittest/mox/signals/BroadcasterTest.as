package mox.signals 
{

    import astre.api.*;

    public class BroadcasterTest extends Test 
    {
        public function BroadcasterTest(name:String)
        {
            super(name);
        }
        
        private var client:Object;
        
        public function addAListenerAndRetrieveIt():void
        {
            client = new Object();
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            assertTrue(b.hasListener(client));
        }
        
        public function removeListenerAndDontRetrieveIt():void
        {
            client = new Object();
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            b.removeListener(client);
            assertFalse(b.hasListener(client));
        }
        
        public function broadcastEventTriggersTheMethodOfTheListeners():void
        {
            client = new Object();
            client.pushRandom = function (a:Array):void {a.push(Math.random())};
            var b:Broadcaster = new Broadcaster();
            b.addListener(client);
            var array:Array = new Array();
            b.broadcast("pushRandom",array);
            assertEquals(1,array.length);
            assertFalse(isNaN(array[0]));
        }
        
        
    }
    
}
