/*
 * Version.as
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
package mox 
{
    
    /**
     * A Version class, based on common practices 
     * in Gnome and many other projects.
     * <p>It features a major, minor, revision and build numbers.
     * <ul>
     *   <li>The major number marks important versions with new features, new design.</li>
     *   <li>The minor number marks new features added in the current major version.</li>
     *   <li>The revision number marks bug fixes (not new features) applied to current major.minor version.</li>
     *   <li>The build number marks for example the number of commits applied to the project. (not linked to other numbers).</li>
     * </ul>
     * </p>
     */
    public final class Version 
    {
        
        /**
         * Constructor.
         * 
         * @param major The major number.
         * @param minor The minor number.
         * @param revision The revision number.
         * @param build The build number.
         */
        public function Version(major:uint = 0, minor:uint = 0, revision:uint = 0, build:uint = 0)
        {
            this._raw1 = ((minor & 0xffff) << 16) + (revision & 0xffff);
            this._raw2 = ((major & 0xff) << 24) + (build & 0xffffff);
        }
        
        /** 
         * @private
         */
        internal var _raw1:uint;
        
        /** 
         * @private
         */
        internal var _raw2:uint;
        
        /** 
         * The raw number of this version.
         */
        public function get raw():Number
        {
            return  Number(this.major) * Math.pow(2,56) + 
                    Number(this.minor) * Math.pow(2,40) + 
                    Number(this.revision) * Math.pow(2,24) + 
                    Number(this.build);
        }
        
        /** 
         * The major number of this version.
         */
        public function get major():uint
        {
            return uint((this._raw2 >> 24) & 0xff);
        }
        
        /** 
         * @private
         */
        public function set major(value:uint):void
        {
            this._raw2 = uint(this._raw2 & 0xffffff) + uint((value & 0xff) << 24);
        }
        
        /** 
         * The minor number of this version.
         */
        public function get minor():uint
        {
            return uint((this._raw1 >> 16) & 0xffff);
        }
        
        /** 
         * @private
         */
        public function set minor(value:uint):void
        {
            this._raw1 = uint(this._raw1 & 0xffff) + uint((value & 0xffff) << 16);
        }
        
        /** 
         * The revision number of this version.
         */
        public function get revision():uint
        {
            return uint(this._raw1 & 0xffff);
        }
        
        /** 
         * @private
         */
        public function set revision(value:uint):void
        {
            this._raw1 = uint(this._raw1 & 0xffff0000) + (value & 0xffff);
        }
        
        /** 
         * The build number of this version.
         */
        public function get build():uint
        {
            return uint(this._raw2 & 0xffffff);
        }
        
        /** 
         * @private
         */
        public function set build(value:uint):void
        {
            this._raw1 = uint(this._raw1 & 0xff000000) + uint(value & 0xffffff);
        }
        
        /** 
         * @private
         */
        private static const ALIASES:Object = {M:"major",m:"minor",r:"revision",b:"build"};
        
        /** 
         * @private
         */
        private function arep():String
        {
            var p:String = ALIASES[arguments[1]];
            if (this.hasOwnProperty(p))
                return this[p].toString();
            return "";
        }
        
        /** 
         * The string representation of this version.
         * 
         * @param The format of the string representation.
         * @return The string representation of this version.
         */
        public function toString(format:String = "$M.$m.$r.$b"):String
        {
            return format.replace(/\$(\w)/g, arep);
        }
        
        /** 
         * The raw number of this version.
         * It allows to use &lt;, &gt; &lt;= and &gt;= operators to 
         * compare 2 versions.
         * 
         * @return The string representation of this version.
         */
        public function valueOf():Number
        {
            return this.raw;
        }
        
    }
    
}
