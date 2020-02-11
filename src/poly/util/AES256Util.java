package poly.util;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
 
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
 
import org.apache.commons.codec.binary.Base64;
 
/*
Copyright 회사명 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
 
public class AES256Util {
    private String iv;
    private Key keySpec;
    
    public AES256Util(String key) throws UnsupportedEncodingException {
        this.iv = key.substring(0, 16);
        
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if (len > keyBytes.length) {
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        
        this.keySpec = keySpec;
    }//키의 길이를 확인하는 aes의 확인자
    
 
    // 암호화
    public String aesEncode(String str) throws java.io.UnsupportedEncodingException, 
                                                    NoSuchAlgorithmException, 
                                                    NoSuchPaddingException, 
                                                    InvalidKeyException, 
                                                    InvalidAlgorithmParameterException, 
                                                    IllegalBlockSizeException, 
                                                    BadPaddingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        //암호화처리 클래스                                      패딩(알아야댐)/빈칸(블럭) 채워주는 역할(256중 200을 사용시 56을 패딩으로 채움)
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
        //초기화		  /암호화
 
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
        //암호화 확인
        
        return enStr;
    }
 
    //복호화
    public String aesDecode(String str) throws java.io.UnsupportedEncodingException,
                                                        NoSuchAlgorithmException,
                                                        NoSuchPaddingException, 
                                                        InvalidKeyException, 
                                                        InvalidAlgorithmParameterException,
                                                        IllegalBlockSizeException, 
                                                        BadPaddingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
        			 //디크립트 모드/인크립트 모드 알기
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
 
        return new String(c.doFinal(byteStr),"UTF-8");
    }
    
    public String testSHA256(String str) {
    	String SHA ="";
    	try {
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++) {
               sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            SHA = sb.toString();
         }catch(NoSuchAlgorithmException e) {
            e.printStackTrace();
            SHA = null;
         }
         return SHA;
      }
    
    public String testMD5(String str) {
    	String MD5 ="";
    	try {
            MessageDigest sh = MessageDigest.getInstance("MD5");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++) {
               sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            MD5 = sb.toString();
         }catch(NoSuchAlgorithmException e) {
            e.printStackTrace();
            MD5 = null;
         }
         return MD5;
      }
 
}