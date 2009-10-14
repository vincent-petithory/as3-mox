package coreutils 
{
    
    import astre.api.*;

    public final class AllTests 
    {
        
        public static function suite():TestSuite
        {
            var list:TestSuite = new TestSuite();
            list.add(signalTest);
            return list;
        }
        
    }
}

