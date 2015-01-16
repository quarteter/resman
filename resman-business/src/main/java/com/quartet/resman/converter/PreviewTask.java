package com.quartet.resman.converter;

import com.quartet.resman.converter.PDFConverter;
import com.quartet.resman.converter.SWFConverter;
import com.quartet.resman.store.FileService;
import com.quartet.resman.utils.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;

/**
 * 生成预览文件
 * User: qfxu
 * Date: 15-1-15
 */

@Component
@Scope("prototype")
public class PreviewTask extends Thread {

    private List<String> supported = Arrays.asList(new String[]{"doc", "docx", "xls", "xlsx", "txt","ppt","ppts"});

    private static String PDF_EXT = ".pdf";
    private static String SWF_EXT = ".swf";

    private String previewPath;
    @Resource
    private PDFConverter pdfConverter;
    @Resource
    private SWFConverter swfConverter;
    @Resource
    private FileService fileService;
    private String filePath;
    private String fileName;

    public String getPreviewPath() {
        return previewPath;
    }

    public void setPreviewPath(String previewPath) {
        this.previewPath = previewPath;
    }

    public PDFConverter getPdfConverter() {
        return pdfConverter;
    }

    public void setPdfConverter(PDFConverter pdfConverter) {
        this.pdfConverter = pdfConverter;
    }

    public SWFConverter getSwfConverter() {
        return swfConverter;
    }

    public void setSwfConverter(SWFConverter swfConverter) {
        this.swfConverter = swfConverter;
    }

    public FileService getFileService() {
        return fileService;
    }

    public void setFileService(FileService fileService) {
        this.fileService = fileService;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void run() {
        try {
            String extend = FileUtils.getExtend(fileName);
            if(!supported.contains(extend))
                return;
            InputStream in = fileService.readFile(filePath + fileName);
            if(in == null)
                return;
            String dirPath = previewPath + File.separator + filePath;
            File dir = new File(dirPath);
            if(!dir.exists())
                dir.mkdirs();

            String destPath = dir + File.separator + fileName;
            File file = new File(destPath);
            OutputStream os = new FileOutputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[2048];
            while ((bytesRead = in.read(buffer, 0, 2048)) != -1) {
                os.write(buffer, 0, bytesRead);
            }

            IOUtils.closeQuietly(os);
            IOUtils.closeQuietly(in);

            String name = FileUtils.getFilePrefix2(fileName);

            File pdfFile = new File(dirPath + File.separator + name + PDF_EXT);
            File swfFile = new File(dirPath + File.separator + name + SWF_EXT);

            pdfConverter.convert(file, pdfFile);
            swfConverter.convert(pdfFile, swfFile);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new RuntimeException("生成预览文件失败", ex);
        }
    }
}
