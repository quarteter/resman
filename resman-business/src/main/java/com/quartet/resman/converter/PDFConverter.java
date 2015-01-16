package com.quartet.resman.converter;

import com.quartet.resman.utils.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileNotFoundException;

/**
 * 转换成PDF类型文件，暂时支持WORD、EXCEL、TXT等转换成PDF类型文件。通过调用OpenOffice提供的服务将其转换为PDF格式的文件
 * User: qfxu
 * Date: 14-1-17
 */
@Component
public class PDFConverter implements Converter {
    @Value("${system.openoffice.path}")
    private String officeHome;     //OpenOffice安装路径

    private static int[] port = {8100};
    private static OfficeManager officeManager;
    private static Logger logger = LoggerFactory.getLogger(PDFConverter.class);

    @Override
    public void convert(File source, File dest) {
        if (!source.exists())
            throw new RuntimeException("转换文件未找到，文件路径：" + source.getPath());
        String extend = FileUtils.getExtend(source.getName());

        startService();
        logger.info("进行文档转换转换:" + source.getName() + " --> " + dest.getName());
        OfficeDocumentConverter converter = new OfficeDocumentConverter(
                officeManager);
        try {
            converter.convert(source, dest);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        stopService();
        logger.info("进行文档转换转换---- 结束----");
    }

    /**
     * 启动服务
     */
    private void startService() {
        DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
        try {
            if (StringUtils.isEmpty(officeHome))
                throw new FileNotFoundException("OpenOffice未安装或者Office安装路径配置不正确");
            //设置openOffice安装路径
            configuration.setOfficeHome(officeHome);
            //设置转换端口
            configuration.setPortNumbers(port);
            //设置任务执行超时为5分钟
            configuration.setTaskExecutionTimeout(1000 * 60 * 5L);
            //设置任务队列超时为24小时
            configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);

            officeManager = configuration.buildOfficeManager();
            officeManager.start();
            logger.info("Office转换服务启动成功");
        } catch (Exception ex) {
            logger.info("Office转换服务启动失败");
        }
    }

    /**
     * 停止服务
     */
    private void stopService() {
        if (officeManager != null)
            officeManager.stop();
        logger.info("Office转换服务关闭成功");
    }
}
