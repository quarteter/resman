package com.quartet.resman.converter;

import java.io.File;

/**
 * 文件类型转换接口
 * User: qfxu
 * Date: 14-1-17
 */
public interface Converter {
    /**
     * 一种文件类型转换另一种类型文件
     *
     * @param source 源文件
     * @param dest   目标文件
     */
    public void convert(File source, File dest);
}
