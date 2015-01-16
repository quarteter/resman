package com.quartet.resman.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class ConvUtils {
	private static final Logger logger = LoggerFactory
			.getLogger(ConvUtils.class);

	public static boolean isEmpty(String str) {
		return (str == null) || (str.length() == 0);
	}

	public static boolean isNumeric(String str) {
		if (str == null)
			return false;
		int sz = str.length();
		for (int i = 0; i < sz; i++) {
			if (!Character.isDigit(str.charAt(i)))
				return false;
		}
		return true;
	}

	public static boolean equals(String str1, String str2) {
		return str2 == null ? true : str1 != null ? str1.equals(str2) : false;
	}

	public static boolean equalsIgnoreCase(String str1, String str2) {
		return str2 == null ? true : str1 != null ? str1.equalsIgnoreCase(str2)
				: false;
	}

	public static String hash(byte[] unencodedPassword, String algorithm) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance(algorithm);
		} catch (Exception e) {
			logger.error("Exception: " + e);

			return null;
		}

		md.reset();

		md.update(unencodedPassword);

		byte[] encodedPassword = md.digest();

		StringBuffer buf = new StringBuffer();

		for (int i = 0; i < encodedPassword.length; i++) {
			if ((encodedPassword[i] & 0xFF) < 16) {
				buf.append("0");
			}

			buf.append(Long.toString(encodedPassword[i] & 0xFF, 16));
		}

		return buf.toString();
	}

	public static String hash(String password, String algorithm) {
		return hash(password.getBytes(), algorithm);
	}

	public static String[] splitString(String data, int[] len) {
		if (data == null)
			return null;
		if (len == null) {
			return null;
		}
		List list = new ArrayList();

		String tmp1 = data;
		try {
			for (int i = 0; i < len.length; i++) {
				if (tmp1.getBytes("UTF-8").length < len[i]) {
					list.add(tmp1);
					break;
				}

				String tmp2 = "";
				if (tmp1.substring(0, 1).getBytes("UTF-8").length > len[i]) {
					list.add("");
				} else {
					while ((tmp2 + tmp1.substring(0, 1)).getBytes("UTF-8").length <= len[i]) {
						tmp2 = tmp2 + tmp1.substring(0, 1);
						tmp1 = tmp1.substring(1);
						if (tmp1.equals("")) {
							break;
						}
					}
					list.add(tmp2);
				}
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		String[] ret = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			ret[i] = ((String) list.get(i));
		}

		return ret;
	}

	public static String toHtml(String s) {
		if (s == null) {
			return s;
		}
		s = strReplace(s, "&", "&amp;");
		s = strReplace(s, "<", "&lt;");
		s = strReplace(s, ">", "&gt;");
		s = strReplace(s, "\r", "");
		s = strReplace(s, "\n", "<br>\n");
		s = strReplace(s, "\"", "&quot;");
		return s;
	}

	public static String toHtmlText(String s) {
		if (s == null) {
			return s;
		}
		s = strReplace(s, "&", "&amp;");
		s = strReplace(s, "<", "&lt;");
		s = strReplace(s, ">", "&gt;");
		s = strReplace(s, "\r", "");
		s = strReplace(s, "\n　　", "\n");
		for (int i = 0; i < 4; i++) {
			s = strReplace(s, "\n ", "\n");
		}
		for (int i = 0; i < 2; i++) {
			s = strReplace(s, "\n\n", "\n");
		}
		s = strReplace(s, "\n", "\n<p>　　");

		s = "　　" + s;
		return s;
	}

	public static String toText(String s) {
		if (s == null) {
			return s;
		}
		s = strReplace(s, "\r", "");
		s = strReplace(s, "<br>\n", "\n");
		return s;
	}

	public static int strToInt(String s) {
		if (s == null) {
			return 0;
		}
		try {
			return Integer.parseInt(s.trim());
		} catch (Exception e) {
		}
		return 0;
	}

	public static long strToLong(String s) {
		if (s == null) {
			return 0L;
		}
		try {
			return Long.parseLong(s.trim());
		} catch (Exception e) {
		}
		return 0L;
	}

	public static long[] strsToLongs(String[] s) {
		if (s == null) {
			return null;
		}
		long[] ret = new long[s.length];
		for (int i = 0; i < s.length; i++) {
			ret[i] = strToLong(s[i]);
		}
		return ret;
	}

	public static int[] strsToInts(String[] s) {
		if (s == null) {
			return null;
		}
		int[] ret = new int[s.length];
		for (int i = 0; i < s.length; i++) {
			ret[i] = strToInt(s[i]);
		}
		return ret;
	}

	public static double strToDouble(String s) {
		if (s == null) {
			return 0.0D;
		}

		String temp = "";
		for (int i = 0; i < s.length(); i++) {
			if (!s.substring(i, i + 1).equals(",")) {
				temp = temp + s.substring(i, i + 1);
			}
		}
		s = temp;
		try {
			return Double.parseDouble(s.trim());
		} catch (Exception e) {
		}
		return 0.0D;
	}

	public static String strReplace(String sBody, String sFrom, String sTo) {
		int i = 0;
		int j = sFrom.length();
		int k = sTo.length();

		while (sBody.indexOf(sFrom, i) != -1) {
			i = sBody.indexOf(sFrom, i);
			sBody = sBody.substring(0, i) + sTo + sBody.substring(i + j);
			i += k;
		}
		return sBody;
	}

	public static byte[] encrypt(byte[] plainText, byte[] passwd,
			String algorithm) throws NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidKeyException,
			IllegalBlockSizeException, BadPaddingException {
		SecretKey key = new SecretKeySpec(passwd, algorithm);
		Cipher c1 = Cipher.getInstance(algorithm);
		c1.init(1, key);
		byte[] cipherByte = c1.doFinal(plainText);
		return cipherByte;
	}

	public static byte[] decrypt(byte[] cipherText, byte[] passwd,
			String algorithm) throws NoSuchAlgorithmException,
			NoSuchPaddingException, InvalidKeyException,
			IllegalBlockSizeException, BadPaddingException {
		SecretKey key = new SecretKeySpec(passwd, algorithm);
		Cipher c1 = Cipher.getInstance(algorithm);
		c1.init(2, key);
		byte[] clearByte = c1.doFinal(cipherText);
		return clearByte;
	}

	public static boolean matchStrings(String pattern, String str) {
		char[] patArr = pattern.toCharArray();
		char[] strArr = str.toCharArray();
		int patIdxStart = 0;
		int patIdxEnd = patArr.length - 1;
		int strIdxStart = 0;
		int strIdxEnd = strArr.length - 1;

		boolean containsStar = false;
		for (int i = 0; i < patArr.length; i++) {
			if (patArr[i] == '*') {
				containsStar = true;
				break;
			}
		}

		if (!containsStar) {
			if (patIdxEnd != strIdxEnd) {
				return false;
			}
			for (int i = 0; i <= patIdxEnd; i++) {
				char ch = patArr[i];
				if (ch != '?') {
					if (ch != strArr[i]) {
						return false;
					}
				}
			}
			return true;
		}

		if (patIdxEnd == 0) {
			return true;
		}
		char ch;
		while (((ch = patArr[patIdxStart]) != '*')
				&& (strIdxStart <= strIdxEnd)) {
			if (ch != '?') {
				if (ch != strArr[strIdxStart]) {
					return false;
				}
			}
			patIdxStart++;
			strIdxStart++;
		}
		if (strIdxStart > strIdxEnd) {
			for (int i = patIdxStart; i <= patIdxEnd; i++) {
				if (patArr[i] != '*') {
					return false;
				}
			}
			return true;
		}

		while (((ch = patArr[patIdxEnd]) != '*') && (strIdxStart <= strIdxEnd)) {
			if (ch != '?') {
				if (ch != strArr[strIdxEnd]) {
					return false;
				}
			}
			patIdxEnd--;
			strIdxEnd--;
		}
		if (strIdxStart > strIdxEnd) {
			for (int i = patIdxStart; i <= patIdxEnd; i++) {
				if (patArr[i] != '*') {
					return false;
				}
			}
			return true;
		}

		while ((patIdxStart != patIdxEnd) && (strIdxStart <= strIdxEnd)) {
			int patIdxTmp = -1;
			for (int i = patIdxStart + 1; i <= patIdxEnd; i++) {
				if (patArr[i] == '*') {
					patIdxTmp = i;
					break;
				}
			}
			if (patIdxTmp == patIdxStart + 1) {
				patIdxStart++;
			} else {
				int patLength = patIdxTmp - patIdxStart - 1;
				int strLength = strIdxEnd - strIdxStart + 1;
				int foundIdx = -1;
				label454: for (int i = 0; i <= strLength - patLength; i++) {
					for (int j = 0; j < patLength; j++) {
						ch = patArr[(patIdxStart + j + 1)];
						if ((ch != '?')
								&& (ch != strArr[(strIdxStart + i + j)])) {
							break label454;
						}

					}

					foundIdx = strIdxStart + i;
					break;
				}

				if (foundIdx == -1) {
					return false;
				}

				patIdxStart = patIdxTmp;
				strIdxStart = foundIdx + patLength;
			}

		}

		for (int i = patIdxStart; i <= patIdxEnd; i++) {
			if (patArr[i] != '*') {
				return false;
			}
		}
		return true;
	}

	public static String addSpace(String str, int size) {
		return addSpace(str, " ", size);
	}

	public static String addSpace(String str, String str1, int size) {
		if ((str == null) || ("".equals(str))) {
			StringBuffer strBuffer = new StringBuffer("");
			for (int j = 0; j < size; j++) {
				strBuffer.insert(0, str1);
			}
			return strBuffer.toString();
		}

		str = str.trim();
		if (str.length() > size) {
			return str;
		}

		StringBuffer stringBuffer = new StringBuffer(str);
		for (int i = 0; i < size - str.length(); i++) {
			stringBuffer.insert(stringBuffer.length(), str1);
		}
		return stringBuffer.toString();
	}

	public static String addZero(String srcString, int destLenth) {
		return addZero(srcString, "0", destLenth);
	}

	public static String addZero(String srcString, String strZero, int destLenth) {
		int ilen = 0;
		String rtn = "";
		if (isEmpty(srcString))
			return "";
		srcString = srcString.trim();
		if (srcString.length() >= destLenth)
			return srcString;
		ilen = destLenth - srcString.length();
		for (int i = 0; i < ilen; i++) {
			rtn = rtn + strZero;
		}
		return rtn + srcString;
	}

	public static String rmEndChar(String srcString) {
		if (isEmpty(srcString)) {
			return srcString;
		}

		return srcString.substring(0, srcString.length() - 1);
	}

	public static String subFixLength(String str, int fix) {
		if ((str == null) || (str.length() <= fix)) {
			return str;
		}

		return str.substring(0, fix);
	}

	/**
	 * 去除特殊符号
	 * 
	 * @param filedName
	 * @return
	 */
	public static String getFiledNameNoKey(String filedName) {
		int index = filedName.indexOf(".");
		if (index > -1) {
			return filedName.substring(index + 1);
		}

		return filedName;
	}
}
