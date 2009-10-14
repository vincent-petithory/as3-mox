package 
{
    
    import astre.api.*;

    import coreutils.*;
    
    import flash.display.Sprite;

    public final class AllTests extends Sprite 
    {
        
        public static function suite():TestSuite
        {
            var list:TestSuite = new TestSuite();
            list.add(coreutils.AllTests.suite());
            return list;
        }

        public function AllTests()
        {
            CLITestRunner.run(suite());
        }
        
    }
}

