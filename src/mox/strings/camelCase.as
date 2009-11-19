package mox.strings 
{

    public function camelCase(string:String):String
    {
        var camelCased:String = "";
        var length:int = string.length;
        var i:int = -1;
        var buffer:String = "";
        var upperCaseNextChar:Boolean = false;
        while (++i<length)
        {
            var char:String = string.charAt(i);
            if (!isalnum(char))
            {
                upperCaseNextChar = true;
            }
            else
            {
                if (upperCaseNextChar)
                {
                    camelCased += char.toUpperCase();
                    upperCaseNextChar = false;
                }
                else
                    camelCased += char;
            }
        }
        return camelCased;
    }
    
}

