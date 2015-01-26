package com.quartet.resman.converter;

import com.quartet.resman.core.MimeTypeConfig;
import com.quartet.resman.entity.Document;
import com.quartet.resman.service.Config;
import com.quartet.resman.store.FileService;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.PathUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.util.HashMap;
import java.util.Map;

/**
 * User: qfxu
 * Date: 15-1-23
 */
@Service
public class ConverterService {
    private static Logger log = LoggerFactory.getLogger(ConverterService.class);
    public static final String FILE_CONVERTER_STATUS = "file_converter_status";

    @Resource
    private FileService fileService;

    @Resource
    private DocConverter docConverter;

    @Resource
    private Config config;

    public void convert(String uuid) throws IOException {
        log.debug("convert({})", uuid);
        File tmp = null;
        InputStream is = null;

        try {
            // Now an document can be located by UUID
            if (!uuid.equals("")) {
                Document doc = fileService.getFileInfoByUUID(uuid);
                String fileName = PathUtils.getName(doc.getPath());
                String mimeType = FileUtils.getFileExtension(fileName).toLowerCase();
                if(mimeType.equals(MimeTypeConfig.EXT_TXT)){
                    mimeType = MimeTypeConfig.EXT_OO_ODT;
                }

                if(!docConverter.convertibleToPdf(mimeType) && !docConverter.convertibleToSwf(mimeType))
                    return;

                // Save content to temporary file
                tmp = File.createTempFile("resman", "." + mimeType);
                is = fileService.readFile(doc.getPath());

                FileUtils.copy(is, tmp);
                IOUtils.closeQuietly(is);

                // Prepare conversion
                ConversionData cd = new ConversionData();
                cd.uuid = uuid;
                cd.fileName = fileName;
                cd.mimeType = mimeType;
                cd.file = tmp;

                if (docConverter.convertibleToPdf(cd.mimeType)) {
                    try {
                        toPDF(cd);
                    } catch (ConversionException e) {
                        log.error(e.getMessage(), e);
                        InputStream tis = ConverterService.class.getResourceAsStream("conversion_problem.pdf");
                        FileUtils.copy(tis, cd.file);
                    }
                }

                if (docConverter.convertibleToSwf(cd.mimeType)) {
                    try {
                        toSWF(cd);
                    } catch (ConversionException e) {
                        log.error(e.getMessage(), e);
                        InputStream tis = ConverterService.class.getResourceAsStream("conversion_problem.swf");
                        FileUtils.copy(tis, cd.file);
                    }
                }


            } else {
                log.error("Missing Conversion Parameters");
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new ConversionException("");
        } finally {
            FileUtils.deleteQuietly(tmp);
        }

        log.debug("service: void");
    }

    /**
     * Handles PDF conversion
     */
    private void toPDF(ConversionData cd) throws IOException {
        log.debug("toPDF({})", cd);
        File pdfCache = new File(config.getCachPDF() + File.separator + cd.uuid + ".pdf");

        File parentDir = pdfCache.getParentFile();
        if(!parentDir.exists())
            parentDir.mkdirs();

        if (docConverter.convertibleToPdf(cd.mimeType)) {
            if (!pdfCache.exists()) {
                try {
                    if (cd.mimeType.equals(MimeTypeConfig.EXT_PDF)) {
                        // Document already in PDF format
                    //}else if (cd.mimeType.equals(MimeTypeConfig.EXT_ZIP)) {   //不支持ZIP文件的预览
                       // docConverter.zip2pdf(cd.file, pdfCache);
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_XML)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.src2pdf(cd.file, pdfCache, "xml");
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_SQL)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.src2pdf(cd.file, pdfCache, "sql");
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_JAVA) || cd.mimeType.equals(MimeTypeConfig.EXT_BSH)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.src2pdf(cd.file, pdfCache, "java");
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_PHP)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.src2pdf(cd.file, pdfCache, "php");
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_SH)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.src2pdf(cd.file, pdfCache, "bash");
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_HTML)) {
                        // This is an internal conversion and does not need 3er party software
                        docConverter.html2pdf(cd.file, pdfCache);
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_POSTSCRIPT)) {
                        docConverter.ps2pdf(cd.file, pdfCache);
                    } else if (DocConverter.validImageMagick.contains(cd.mimeType)) {
                        docConverter.img2pdf(cd.file, cd.mimeType, pdfCache);
                    } else if (DocConverter.validOpenOffice.contains(cd.mimeType)) {
                        docConverter.doc2pdf(cd.file, cd.mimeType, pdfCache);
                    } else {
                        throw new ConversionException("Conversion from '" + cd.mimeType + "' to PDF not available");
                    }


                } catch (ConversionException e) {
                    pdfCache.delete();
                    throw e;
                } finally {
                    FileUtils.deleteQuietly(cd.file);
                    cd.mimeType = MimeTypeConfig.EXT_PDF;
                    cd.fileName = FileUtils.getFileName(cd.fileName) + ".pdf";
                }
            }

            if (pdfCache.exists()) cd.file = pdfCache;
            cd.mimeType = MimeTypeConfig.EXT_PDF;
            cd.fileName = FileUtils.getFileName(cd.fileName) + ".pdf";
        } else {
            throw new ConversionException("Conversion from '" + cd.mimeType + "' to PDF not available");
        }

        log.debug("toPDF: {}", cd);
    }

    /**
     * Handles SWF conversion
     */
    private void toSWF(ConversionData cd) throws IOException {
        log.debug("toSWF({})", cd);
        File swfCache = new File(config.getCachSWF() + File.separator + cd.uuid + ".swf");

        File parentDir = swfCache.getParentFile();
        if(!parentDir.exists())
            parentDir.mkdirs();

        boolean delTmp = true;

        if (docConverter.convertibleToSwf(cd.mimeType)) {
            if (!swfCache.exists()) {
                try {
                    if (cd.mimeType.equals(MimeTypeConfig.EXT_SWF)) {
                        // Document already in SWF format
                    } else if (cd.mimeType.equals(MimeTypeConfig.EXT_PDF)) {
                        docConverter.pdf2swf(cd.file, swfCache);
                    } else if (docConverter.convertibleToPdf(cd.mimeType)) {
                        toPDF(cd);
                        delTmp = false;

                        docConverter.pdf2swf(cd.file, swfCache);
                    } else {
                        throw new ConversionException("Conversion from '" + cd.mimeType + "' to SWF not available");
                    }
                } catch (ConversionException e) {
                    swfCache.delete();
                    throw e;
                } finally {
                    if (delTmp) {
                        FileUtils.deleteQuietly(cd.file);
                    }
                    cd.mimeType = MimeTypeConfig.EXT_SWF;
                    cd.fileName = FileUtils.getFileName(cd.fileName) + ".swf";
                }
            }

            if (swfCache.exists()) cd.file = swfCache;
            cd.mimeType = MimeTypeConfig.EXT_SWF;
            cd.fileName = FileUtils.getFileName(cd.fileName) + ".swf";
        } else {
            throw new ConversionException("Conversion from '" + cd.mimeType + "' to SWF not available");
        }

        log.debug("toSWF: {}", cd);
    }

    /**
     * For internal use only.
     */
    private class ConversionData {
        private String uuid;
        private String fileName;
        private String mimeType;
        private File file;

        public String toString() {
            StringBuilder sb = new StringBuilder();
            sb.append("{");
            sb.append("uuid=").append(uuid);
            sb.append(", fileName=").append(fileName);
            sb.append(", mimeType=").append(mimeType);
            sb.append(", file=").append(file);
            sb.append("}");
            return sb.toString();
        }
    }
}
