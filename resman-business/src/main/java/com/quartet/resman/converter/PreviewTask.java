package com.quartet.resman.converter;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 生成预览文件
 * User: qfxu
 * Date: 15-1-15
 */

public class PreviewTask extends Thread {

    private String uuid;
    private ConverterService converterService;

    public PreviewTask(String uuid, ConverterService converterService) {
        this.uuid = uuid;
        this.converterService = converterService;
    }


    @Override
    public void run() {
        try {
            converterService.convert(uuid);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException("生成预览文件失败", ex);
        }
    }
}
