package 
{
    
    import astre.api.*;

    import flash.display.Sprite;

    public final class AllTests extends Sprite 
    {
        
        public static function suite():TestSuite
        {
            var list:TestSuite = new TestSuite();
            //list.add(path.to.sub.AllTests.suite());
            return list;
        }

        public function AllTests()
        {
            CLITestRunner.run(suite());
        }
        
    }
}

