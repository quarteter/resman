package com.quartet.resman.converter;

import com.quartet.resman.utils.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;

/**
 * 转换成SWF类型文件，仅支持PDF格式转换成SWF文件，使用SWFTools进行转换
 * User: qfxu
 * Date: 14-1-17
 */
@Component
public class SWFConverter implements Converter {
    @Value("${system.swftools.pdf2swf}")
    private String swftoolsHome;     //SWFTools安装路径

    private static Logger logger = LoggerFactory.getLogger(SWFConverter.class);

    @Override
    public void convert(File source, File dest) {
        if (!source.exists()) {
            logger.info("源文件不存在");
            return;
        }

        String extend = FileUtils.getExtend(source.getName());
        if (!extend.endsWith("pdf")) {
            throw new RuntimeException("文件格式错误，仅支持PDF格式的文件转换");
        }

        String command = swftoolsHome + " " + source.getPath() + " -o " + dest.getPath() + " -T 9";
        try {
            // 开始转换文档
            Process process = Runtime.getRuntime().exec(command);
            StreamGobbler errorGobbler = new StreamGobbler(
                    process.getErrorStream(), "Error");
            StreamGobbler outputGobbler = new StreamGobbler(
                    process.getInputStream(), "Output");
            errorGobbler.start();
            outputGobbler.start();
            try {
                process.waitFor();
                logger.info("时间-------" + process.waitFor());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
