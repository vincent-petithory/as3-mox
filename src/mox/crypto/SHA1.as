/*
 * SHA1.as
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
package mox.crypto 
{
    
    import flash.utils.ByteArray;
    
    /**
     * The SHA1 class implements the SHA-1 algorithm.
     * The description of the SHA-1 algorithm can be found at 
     * 
     *     http://www.ietf.org/rfc/rfc3174.txt
     * 
     */
    public class SHA1 implements IHash 
    {
    
        /**
         * @private
         */
        private var h0:uint;
        /**
         * @private
         */
        private var h1:uint;
        /**
         * @private
         */
        private var h2:uint;
        /**
         * @private
         */
        private var h3:uint;
        /**
         * @private
         */
        private var h4:uint;
        
        /**
         * @private
         */
        private var bytes:ByteArray;
        
        /**
         * Constructor.
         * @param input an input of any type to be immediately 
         * processed, if defined.
         * 
         */
        public function SHA1(input:* = undefined)
        {
            h0 = 0x67452301;
            h1 = 0xEFCDAB89;
            h2 = 0x98BADCFE;
            h3 = 0x10325476;
            h4 = 0xC3D2E1F0;
            this.bytes = new ByteArray();
            if (input)
                this.update(input);
        }
        
        /**
         * @inheritDoc
         */
        public function update(input:*):void
        {
            var position:uint = bytes.position;
            bytes.position = bytes.length;
            if (input is ByteArray)
                bytes.writeBytes(input, input.position);
            else if (input is String)
                bytes.writeUTFBytes(input);
            else
                bytes.writeObject(input);
            bytes.position = position;
            this.processBlocks();
        }
        
        /**
         * @inheritDoc
         */
        public function digest():ByteArray
        {
            this.pad();
            this.processBlocks();
            var digestBytes:ByteArray = new ByteArray();
            digestBytes.writeUnsignedInt(h0);
            digestBytes.writeUnsignedInt(h1);
            digestBytes.writeUnsignedInt(h2);
            digestBytes.writeUnsignedInt(h3);
            digestBytes.writeUnsignedInt(h4);
            return digestBytes;
        }
        
        /**
         * @inheritDoc
         */
        public function hexDigest():String
        {
            this.pad();
            this.processBlocks();
            return hex(h0)+hex(h1)+hex(h2)+hex(h3)+hex(h4);
        }
        
        /**
         * @inheritDoc
         */
        public function copy():IHash
        {
            var sha1:SHA1 = new SHA1();
            sha1.h0 = h0;
            sha1.h1 = h1;
            sha1.h2 = h2;
            sha1.h3 = h3;
            sha1.h4 = h4;
            sha1.bytes.writeBytes(this.bytes);
            sha1.bytes.position = this.bytes.position;
            return sha1;
        }
        
        /**
         * @private
         */
        private function hex(h:uint):String
        {
            var hex:String = h.toString(16);
            var count:int = 8-hex.length;
            while (--count > -1)
            {
                hex = "0"+hex;
            }
            return hex;
        }
        
        /**
         * @private
         * Applies the padding to the input bytes.
         */
        private function pad():void
        {
            var position:uint = bytes.position;
            var length:uint = bytes.length;
            var len:uint = length*8;
            // 512 - (length % 512) - 2*32 - 8 :
            //      block 512-bit
            //      bytes missing to have a length multiple of 512 bits
            //      2 32-bit integers for the original length
            //      8-bit for the 1st pad byte : 1000 0000
            var numZeroBytes:int = 55 - (len % 512)/8;
            if (numZeroBytes < 0)
                numZeroBytes += 64;
            bytes.position = length;
            bytes.writeByte(0x80);
            
            // Append the zeros
            while (--numZeroBytes>-1)
            {
                bytes.writeByte(0);
            }
            // Append the 64-bit length
            // length will always be < 2^32 so the 1st word is all zero
            bytes.writeUnsignedInt(0);
            // append the length now
            bytes.writeUnsignedInt(len);
            // now the input has n 512-bit blocks. Process each block
            bytes.position = position;
        }
        
        /**
         * @inheritDoc
         */
        public function toString():String
        {
            return this.hexDigest();
        }
        
        /**
         * @inheritDoc
         */
        public function valueOf():ByteArray
        {
            return this.digest();
        }
        
        /**
         * @private
         * Processes all available 512-bit blocks.
         */
        private function processBlocks():void
        {
            var a:uint;
            var b:uint;
            var c:uint;
            var d:uint;
            var e:uint;
            
            var temp:uint;
            
            var w0:uint;
            var w1:uint;
            var w2:uint;
            var w3:uint;
            var w4:uint;
            var w5:uint;
            var w6:uint;
            var w7:uint;
            var w8:uint;
            var w9:uint;
            var w10:uint;
            var w11:uint;
            var w12:uint;
            var w13:uint;
            var w14:uint;
            var w15:uint;
            var w16:uint;
            var w17:uint;
            var w18:uint;
            var w19:uint;
            var w20:uint;
            var w21:uint;
            var w22:uint;
            var w23:uint;
            var w24:uint;
            var w25:uint;
            var w26:uint;
            var w27:uint;
            var w28:uint;
            var w29:uint;
            var w30:uint;
            var w31:uint;
            var w32:uint;
            var w33:uint;
            var w34:uint;
            var w35:uint;
            var w36:uint;
            var w37:uint;
            var w38:uint;
            var w39:uint;
            var w40:uint;
            var w41:uint;
            var w42:uint;
            var w43:uint;
            var w44:uint;
            var w45:uint;
            var w46:uint;
            var w47:uint;
            var w48:uint;
            var w49:uint;
            var w50:uint;
            var w51:uint;
            var w52:uint;
            var w53:uint;
            var w54:uint;
            var w55:uint;
            var w56:uint;
            var w57:uint;
            var w58:uint;
            var w59:uint;
            var w60:uint;
            var w61:uint;
            var w62:uint;
            var w63:uint;
            var w64:uint;
            var w65:uint;
            var w66:uint;
            var w67:uint;
            var w68:uint;
            var w69:uint;
            var w70:uint;
            var w71:uint;
            var w72:uint;
            var w73:uint;
            var w74:uint;
            var w75:uint;
            var w76:uint;
            var w77:uint;
            var w78:uint;
            var w79:uint;
        
            while (bytes.bytesAvailable >= 64)
            {
                a = h0;
                b = h1;
                c = h2;
                d = h3;
                e = h4;
            
                // NOTE : + is defined by z = (x + y) % 2^32. 
                // It is automatically handled by the uint type.
            
                //-----------------------------------------------------------------
                // Initialize the 16 first words
                //-----------------------------------------------------------------

                // 0
                w0 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w0 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 1
                w1 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w1 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 2
                w2 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w2 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 3
                w3 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w3 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 4
                w4 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w4 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 5
                w5 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w5 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 6
                w6 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w6 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 7
                w7 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w7 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 8
                w8 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w8 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 9
                w9 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w9 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 10
                w10 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w10 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 11
                w11 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w11 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 12
                w12 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w12 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 13
                w13 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w13 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 14
                w14 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w14 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 15
                w15 = bytes.readUnsignedInt();
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w15 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                //-----------------------------------------------------------------
                // Make words until having 80 of them
                //-----------------------------------------------------------------

                // 16
                temp = w13 ^ w8 ^ w2 ^ w0;
                w16 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w16 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 17
                temp = w14 ^ w9 ^ w3 ^ w1;
                w17 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w17 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 18
                temp = w15 ^ w10 ^ w4 ^ w2;
                w18 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w18 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 19
                temp = w16 ^ w11 ^ w5 ^ w3;
                w19 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (~b & d)) + e + w19 + 0x5A827999;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 20
                temp = w17 ^ w12 ^ w6 ^ w4;
                w20 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w20 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 21
                temp = w18 ^ w13 ^ w7 ^ w5;
                w21 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w21 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 22
                temp = w19 ^ w14 ^ w8 ^ w6;
                w22 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w22 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 23
                temp = w20 ^ w15 ^ w9 ^ w7;
                w23 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w23 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 24
                temp = w21 ^ w16 ^ w10 ^ w8;
                w24 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w24 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 25
                temp = w22 ^ w17 ^ w11 ^ w9;
                w25 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w25 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 26
                temp = w23 ^ w18 ^ w12 ^ w10;
                w26 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w26 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 27
                temp = w24 ^ w19 ^ w13 ^ w11;
                w27 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w27 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 28
                temp = w25 ^ w20 ^ w14 ^ w12;
                w28 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w28 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 29
                temp = w26 ^ w21 ^ w15 ^ w13;
                w29 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w29 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 30
                temp = w27 ^ w22 ^ w16 ^ w14;
                w30 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w30 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 31
                temp = w28 ^ w23 ^ w17 ^ w15;
                w31 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w31 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 32
                temp = w29 ^ w24 ^ w18 ^ w16;
                w32 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w32 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 33
                temp = w30 ^ w25 ^ w19 ^ w17;
                w33 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w33 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 34
                temp = w31 ^ w26 ^ w20 ^ w18;
                w34 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w34 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 35
                temp = w32 ^ w27 ^ w21 ^ w19;
                w35 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w35 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 36
                temp = w33 ^ w28 ^ w22 ^ w20;
                w36 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w36 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 37
                temp = w34 ^ w29 ^ w23 ^ w21;
                w37 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w37 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 38
                temp = w35 ^ w30 ^ w24 ^ w22;
                w38 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w38 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 39
                temp = w36 ^ w31 ^ w25 ^ w23;
                w39 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w39 + 0x6ED9EBA1;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 40
                temp = w37 ^ w32 ^ w26 ^ w24;
                w40 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w40 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 41
                temp = w38 ^ w33 ^ w27 ^ w25;
                w41 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w41 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 42
                temp = w39 ^ w34 ^ w28 ^ w26;
                w42 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w42 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 43
                temp = w40 ^ w35 ^ w29 ^ w27;
                w43 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w43 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 44
                temp = w41 ^ w36 ^ w30 ^ w28;
                w44 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w44 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 45
                temp = w42 ^ w37 ^ w31 ^ w29;
                w45 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w45 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 46
                temp = w43 ^ w38 ^ w32 ^ w30;
                w46 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w46 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 47
                temp = w44 ^ w39 ^ w33 ^ w31;
                w47 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w47 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 48
                temp = w45 ^ w40 ^ w34 ^ w32;
                w48 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w48 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 49
                temp = w46 ^ w41 ^ w35 ^ w33;
                w49 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w49 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 50
                temp = w47 ^ w42 ^ w36 ^ w34;
                w50 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w50 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 51
                temp = w48 ^ w43 ^ w37 ^ w35;
                w51 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w51 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 52
                temp = w49 ^ w44 ^ w38 ^ w36;
                w52 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w52 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 53
                temp = w50 ^ w45 ^ w39 ^ w37;
                w53 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w53 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 54
                temp = w51 ^ w46 ^ w40 ^ w38;
                w54 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w54 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 55
                temp = w52 ^ w47 ^ w41 ^ w39;
                w55 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w55 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 56
                temp = w53 ^ w48 ^ w42 ^ w40;
                w56 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w56 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 57
                temp = w54 ^ w49 ^ w43 ^ w41;
                w57 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w57 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 58
                temp = w55 ^ w50 ^ w44 ^ w42;
                w58 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w58 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 59
                temp = w56 ^ w51 ^ w45 ^ w43;
                w59 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + ((b & c) | (b & d) | (c & d)) + e + w59 + 0x8F1BBCDC;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 60
                temp = w57 ^ w52 ^ w46 ^ w44;
                w60 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w60 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 61
                temp = w58 ^ w53 ^ w47 ^ w45;
                w61 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w61 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 62
                temp = w59 ^ w54 ^ w48 ^ w46;
                w62 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w62 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 63
                temp = w60 ^ w55 ^ w49 ^ w47;
                w63 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w63 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 64
                temp = w61 ^ w56 ^ w50 ^ w48;
                w64 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w64 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 65
                temp = w62 ^ w57 ^ w51 ^ w49;
                w65 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w65 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 66
                temp = w63 ^ w58 ^ w52 ^ w50;
                w66 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w66 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 67
                temp = w64 ^ w59 ^ w53 ^ w51;
                w67 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w67 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 68
                temp = w65 ^ w60 ^ w54 ^ w52;
                w68 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w68 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 69
                temp = w66 ^ w61 ^ w55 ^ w53;
                w69 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w69 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 70
                temp = w67 ^ w62 ^ w56 ^ w54;
                w70 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w70 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 71
                temp = w68 ^ w63 ^ w57 ^ w55;
                w71 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w71 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 72
                temp = w69 ^ w64 ^ w58 ^ w56;
                w72 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w72 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 73
                temp = w70 ^ w65 ^ w59 ^ w57;
                w73 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w73 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 74
                temp = w71 ^ w66 ^ w60 ^ w58;
                w74 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w74 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 75
                temp = w72 ^ w67 ^ w61 ^ w59;
                w75 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w75 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 76
                temp = w73 ^ w68 ^ w62 ^ w60;
                w76 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w76 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 77
                temp = w74 ^ w69 ^ w63 ^ w61;
                w77 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w77 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 78
                temp = w75 ^ w70 ^ w64 ^ w62;
                w78 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w78 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // 79
                temp = w76 ^ w71 ^ w65 ^ w63;
                w79 = (temp << 1) | (temp >>> 31);
                temp = ((a << 5) | (a >>> 27)) + (b ^ c ^ d) + e + w79 + 0xCA62C1D6;
                e = d;
                d = c;
                c = (b << 30) | (b >>> 2);
                b = a;
                a = temp;

                // update hexs
                h0 += a;
                h1 += b;
                h2 += c;
                h3 += d;
                h4 += e;
            }
        }
        
    }
    
    
}
