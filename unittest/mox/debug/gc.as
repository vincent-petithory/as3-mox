package mox.debug 
{

    import flash.net.LocalConnection;

    public function gc():void
    {
        try 
        {
            new LocalConnection().connect(__GC_CONNECTION__);
            new LocalConnection().connect(__GC_CONNECTION__);
        } catch (e:Error) {}
    }
    
}

internal const __GC_CONNECTION__:String = "__gc_connection__";
