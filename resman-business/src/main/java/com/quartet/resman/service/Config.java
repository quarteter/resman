package com.quartet.resman.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;

/**
 * 参数服务
 * User: qfxu
 * Date: 15-1-13
 */
@Service
public class Config {

    public static int SYSTEM_EXECUTION_TIMEOUT = 5; // 5 min

    //个人空间根目录
    @Value("${folder.personal}")
    private String folderPersonal;

    //预览文件目录
    @Value("${rep.dir}")
    private String repDir;

    @Value("${folder.classicCourse}")
    private String folderClassicCourse;

    @Value("${system.openoffice.path}")
    private String SYSTEM_OPENOFFICE_PATH;

    @Value("${system.openoffice.port}")
    private int SYSTEM_OPENOFFICE_PORT;

    @Value("${system.openoffice.tasks}")
    private int SYSTEM_OPENOFFICE_TASKS;

    @Value("${system.imagemagick.convert}")
    private String SYSTEM_IMAGEMAGICK_CONVERT;

    @Value("${system.swftools.pdf2swf}")
    private String SYSTEM_SWFTOOLS_PDF2SWF;

    @Value("${system.ghostscript}")
    private String SYSTEM_GHOSTSCRIPT;

    @Value("${video.dir}")
    private String videoPath;

    public String getFolderPersonal() {
        return folderPersonal;
    }

    public String getRepDir() {
        return repDir;
    }

    public String getFolderClassicCourse() {
        return folderClassicCourse;
    }

    public String getCachSWF() {
        return repDir + File.separator + "cache" + File.separator + "swf";
    }

    public String getCachPDF() {
        return repDir + File.separator + "cache" + File.separator + "pdf";
    }

    public String getOpenofficePath() {
        return SYSTEM_OPENOFFICE_PATH;
    }

    public int getOpenofficePort() {
        return SYSTEM_OPENOFFICE_PORT;
    }

    public int getOpenofficeTasks() {
        return SYSTEM_OPENOFFICE_TASKS;
    }

    public String getImagemagickConvert() {
        return SYSTEM_IMAGEMAGICK_CONVERT;
    }

    public String getSwftoolsPdf2SWF() {
        return SYSTEM_SWFTOOLS_PDF2SWF;
    }

    public String getGhostscript() {
        return SYSTEM_GHOSTSCRIPT;
    }

    public String getVideoPath(){
        return videoPath;
    }
}
