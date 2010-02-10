package 
{

    import mox.strings.Unicode;
    
    public class UnicodeSample extends SampleBase 
    {
        public function UnicodeSample()
        {
            super();
            var tabChar:String = Unicode.TAB;
            println("Tab char  : '"+tabChar+"'");
            println("Tab char2 : '"+Unicode.u0009+"'");
        }
        
    }
    
}
