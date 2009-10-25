package 
{
    
    import tinker.*;

    public class VarDumpSample extends SampleBase 
    {
        public function VarDumpSample()
        {
            super();
            
            // display a string
            var str:String = "I m a the value of a String";
            println(tinker.varDump(str));
        }
        
    }
    
}
