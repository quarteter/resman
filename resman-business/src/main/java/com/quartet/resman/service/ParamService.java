package com.quartet.resman.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * 参数服务
 * User: qfxu
 * Date: 15-1-13
 */
@Service
public class ParamService {

    //个人空间根目录
    @Value("${folder.personal}")
    private String folderPersonal;

    //预览文件目录
    @Value("${preview.path}")
    private String previewPath;

    @Value("${folder.classicCourse}")
    private String folderClassicCourse;

    public String getFolderPersonal() {
        return folderPersonal;
    }

    public String getPreviewPath() {
        return previewPath;
    }

    public String getFolderClassicCourse() {
        return folderClassicCourse;
    }
}
