package com.quartet.resman.core;

import java.util.Arrays;
import java.util.List;

import javax.activation.MimetypesFileTypeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class MimeTypeConfig {

    public static String EXT_SWF = "swf";

    public static String EXT_TXT = "txt";

    public static String EXT_PDF = "pdf";
    public static String EXT_RTF = "rtf";
    public static String EXT_HTML = "html";
    public static String EXT_ZIP = "zip";
    public static String EXT_XML = "xml";
    public static String EXT_SQL = "sql";
    public static String EXT_JAVA = "java";
    public static String EXT_BSH = "bsh";
    public static String EXT_PHP = "php";
    public static String EXT_SH = "sh";
    public static String EXT_POSTSCRIPT = "ps";

    public static String EXT_IMAGE_JPEG = "jpg";
    public static String EXT_IMAGE_PNG = "png";
    public static String EXT_IMAGE_GIF = "gif";
    public static String EXT_IMAGE_TIF = "tif";
    public static String EXT_IMAGE_TIFF = "tiff";
    public static String EXT_IMAGE_BMP = "bmp";
    public static String EXT_IMAGE_ICO = "ico";
    public static String EXT_IMAGE_SVG = "svg";
    public static String EXT_IMAGE_PSD = "psd";

    public static String EXT_BASIC_PROPERTIES = "properties";
    public static String EXT_BASIC_HTM = "htm";
    public static String EXT_BASIC_CSV = "csv";
    public static String EXT_BASIC_RTF = "rtf";

    public static String EXT_OO_ODT = "odt";
    public static String EXT_OO_OTT = "ott";
    public static String EXT_OO_ODP = "odp";
    public static String EXT_OO_OTP = "otp";
    public static String EXT_OO_ODS = "ods";
    public static String EXT_OO_OTS = "ots";
    public static String EXT_OO_ODG = "odg";
    public static String EXT_OO_ODB = "odb";

    public static String EXT_MS_DOC = "doc";
    public static String EXT_MS_DOT = "dot";
    public static String EXT_MS_XLS = "xls";
    public static String EXT_MS_PPT = "ppt";
    public static String EXT_MS_PPS = "pps";

    public static String EXT_MS_DOCX = "docx";
    public static String EXT_MS_DOTX = "dotx";
    public static String EXT_MS_PPTX = "pptx";
    public static String EXT_MS_PPSX = "ppsx";
    public static String EXT_MS_POTS = "potx";
    public static String EXT_MS_XLSX = "xlsx";
    public static String EXT_MS_XLTX = "xltx";

    public static String EXT_MD_MP3 = "mp3";
    public static String EXT_MD_MP4 = "mp4";
    public static String EXT_MD_OGG = "ogg";
    public static String EXT_MD_WEBM = "webm";
    public static String EXT_MD_WAV = "wav";
    public static String EXT_MD_WMV = "wmv";
    public static String EXT_MD_AVI = "avi";
    public static String EXT_MD_FLV = "flv";


    private static List<String> playSupported = Arrays.asList(new String[]{EXT_MD_MP3, EXT_MD_MP4, EXT_MD_OGG, EXT_MD_WEBM, EXT_MD_WAV, EXT_MD_WMV, EXT_MD_AVI, EXT_MD_FLV});

    public static boolean convertibleToPlay(String from) {
        return playSupported.contains(from);
    }


}
