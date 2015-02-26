package com.quartet.resman.converter;

import com.quartet.resman.core.MimeTypeConfig;
import com.quartet.resman.entity.ExecutionResult;
import com.quartet.resman.service.Config;
import com.quartet.resman.store.FileService;
import com.quartet.resman.utils.ExecutionUtils;
import com.quartet.resman.utils.FileUtils;
import com.quartet.resman.utils.FormatUtil;
import com.quartet.resman.utils.TemplateUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

import org.apache.commons.io.IOUtils;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeException;
import org.artofsolving.jodconverter.office.OfficeManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.RandomAccessFileOrArray;
import com.lowagie.text.pdf.codec.TiffImage;

import freemarker.template.TemplateException;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;

@Component
public class DocConverter {
    private static Logger log = LoggerFactory.getLogger(DocConverter.class);
    public static ArrayList<String> validOpenOffice = new ArrayList<String>();
    public static ArrayList<String> validImageMagick = new ArrayList<String>();
    private static ArrayList<String> validGhoscript = new ArrayList<String>();
    private static ArrayList<String> validInternal = new ArrayList<String>();
    private static DocConverter instance = null;
    private static OfficeManager officeManager = null;

    @Resource
    private Config config;

    @Resource
    private FileService fileService;

    private DocConverter() {
        // Basic
        validOpenOffice.add(MimeTypeConfig.EXT_BASIC_PROPERTIES);
        validOpenOffice.add(MimeTypeConfig.EXT_HTML);
        validOpenOffice.add(MimeTypeConfig.EXT_BASIC_HTM);
        validOpenOffice.add(MimeTypeConfig.EXT_BASIC_CSV);
        validOpenOffice.add(MimeTypeConfig.EXT_BASIC_RTF);

        // OpenOffice.org OpenDocument
        validOpenOffice.add(MimeTypeConfig.EXT_OO_ODT);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_OTT);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_ODP);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_OTP);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_ODS);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_OTS);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_ODG);
        validOpenOffice.add(MimeTypeConfig.EXT_OO_ODB);

        // Microsoft Office
        validOpenOffice.add(MimeTypeConfig.EXT_MS_DOC);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_DOT);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_XLS);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_PPT);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_PPS);

        // Microsoft Office 2007
        validOpenOffice.add(MimeTypeConfig.EXT_MS_DOCX);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_DOTX);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_PPTX);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_PPSX);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_POTS);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_XLSX);
        validOpenOffice.add(MimeTypeConfig.EXT_MS_XLTX);

        // Postcript
        validGhoscript.add(MimeTypeConfig.EXT_POSTSCRIPT);

        // Images
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_BMP);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_GIF);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_ICO);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_JPEG);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_PNG);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_PSD);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_SVG);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_TIF);
        validImageMagick.add(MimeTypeConfig.EXT_IMAGE_TIFF);

        // Internal conversion
        validInternal.add(MimeTypeConfig.EXT_ZIP);
        validInternal.add(MimeTypeConfig.EXT_XML);
        validInternal.add(MimeTypeConfig.EXT_SQL);
        validInternal.add(MimeTypeConfig.EXT_JAVA);
        validInternal.add(MimeTypeConfig.EXT_PHP);
        validInternal.add(MimeTypeConfig.EXT_BSH);
        validInternal.add(MimeTypeConfig.EXT_SH);

    }


    @PostConstruct
    public void start() {
        if (officeManager == null) {
            officeManager = new DefaultOfficeManagerConfiguration().setOfficeHome(config.getOpenofficePath())
                    .setMaxTasksPerProcess(config.getOpenofficeTasks()).setPortNumber(config.getOpenofficePort())
                    .buildOfficeManager();
        }
        if (officeManager != null) {
            officeManager.start();
        }
    }


    @PreDestroy
    public void stop() {
        if (officeManager != null) {
            officeManager.stop();
        }
    }

    /**
     * Obtain OpenOffice Manager
     */
    public OfficeManager getOfficeManager() {
        return officeManager;
    }

    /**
     * Test if a MIME document can be converted to PDF
     */
    public boolean convertibleToPdf(String from) {
        log.trace("convertibleToPdf({})", from);
        boolean ret = false;

        if ((!config.getOpenofficePath().equals("")) && validOpenOffice.contains(from)) {
            ret = true;
        } else if (!config.getImagemagickConvert().equals("") && validImageMagick.contains(from)) {
            ret = true;
        } else if (validInternal.contains(from)) {
            ret = true;
        }

        log.trace("convertibleToPdf: {}", ret);
        return ret;
    }

    /**
     * Test if a MIME document can be converted to SWF
     */
    public boolean convertibleToSwf(String from) {
        log.trace("convertibleToSwf({})", from);
        boolean ret = false;

        if (!config.getSwftoolsPdf2SWF().equals("") && (MimeTypeConfig.EXT_PDF.equals(from) || convertibleToPdf(from))) {
            ret = true;
        }

        log.trace("convertibleToSwf: {}", ret);
        return ret;
    }

    /**
     * Convert a document format to another one.
     */
    public void convert(File inputFile, String mimeType, File outputFile) {
        log.debug("convert({}, {}, {})", new Object[]{inputFile, mimeType, outputFile});

        if (config.getOpenofficePath().equals("")) {
            throw new RuntimeException("[system.openoffice.path] not configured");
        }

        if (!validOpenOffice.contains(mimeType)) {
            throw new ConversionException("Invalid document conversion MIME type: " + mimeType);
        }

        try {
            if (!config.getOpenofficePath().equals("")) {
                // Document conversion managed by local OO instance
                OfficeDocumentConverter converter = new OfficeDocumentConverter(officeManager);
                converter.convert(inputFile, outputFile);
            }
        } catch (OfficeException e) {
            throw new ConversionException("Error converting document: " + e.getMessage());
        }
    }

    /**
     * Convert document to PDF.
     */
    public void doc2pdf(File input, String mimeType, File output) throws ConversionException, IOException {
        log.debug("** Convert from {} to PDF **", mimeType);
        FileOutputStream fos = null;

        try {
            long start = System.currentTimeMillis();
            convert(input, mimeType, output);
            log.debug("Elapse doc2pdf time: {}", FormatUtil.formatSeconds(System.currentTimeMillis() - start));
        } catch (Exception e) {
            throw new ConversionException("Error in " + mimeType + " to PDF conversion", e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert a document from repository and put the result in the repository.
     *
     * @param token   Authentication info.
     * @param docId   The path that identifies an unique document or its UUID.
     * @param dstPath The path of the resulting PDF document (with the name).
     */
    public void doc2pdf(String token, String docId, String dstPath) throws IOException {
        File docIn = null;
        File docOut = null;
        InputStream docIs = null;
        OutputStream docOs = null;

        try {
            com.quartet.resman.entity.Document doc = fileService.getFileInfoByUUID(docId);
            String ext = doc.getMimeType();

            // Store in filesystem
            docIn = FileUtils.createTempFileFromExt(ext);
            docOut = FileUtils.createTempFileFromExt(MimeTypeConfig.EXT_PDF);
            docOs = new FileOutputStream(docIn);
            IOUtils.copy(docIs, docOs);
            IOUtils.closeQuietly(docIs);
            IOUtils.closeQuietly(docOs);

            // Convert to PDF
            doc2pdf(docIn, ext, docOut);

            // Upload to OpenKM
            docIs = new FileInputStream(docOut);

        } finally {
            IOUtils.closeQuietly(docIs);
            IOUtils.closeQuietly(docOs);
            FileUtils.deleteQuietly(docIn);
            FileUtils.deleteQuietly(docOut);
        }
    }

    /**
     * Convert RTF to HTML.
     */
    public void rtf2html(InputStream input, OutputStream output) throws ConversionException {
        File docIn = null;
        File docOut = null;
        InputStream docIs = null;
        OutputStream docOs = null;

        try {
            docIn = FileUtils.createTempFileFromExt(MimeTypeConfig.EXT_RTF);
            docOut = FileUtils.createTempFileFromExt(MimeTypeConfig.EXT_HTML);
            docOs = new FileOutputStream(docIn);
            IOUtils.copy(input, docOs);
            IOUtils.closeQuietly(docOs);

            // Conversion
            rtf2html(docIn, docOut);

            docIs = new FileInputStream(docOut);
            IOUtils.copy(docIs, output);
        } catch (IOException e) {
            throw new ConversionException("IO exception", e);
        } finally {
            IOUtils.closeQuietly(docIs);
            IOUtils.closeQuietly(docOs);
            FileUtils.deleteQuietly(docIn);
            FileUtils.deleteQuietly(docOut);
        }
    }

    /**
     * Convert RTF to HTML.
     */
    public void rtf2html(File input, File output) {
        log.debug("** Convert from RTF to HTML **");
        FileOutputStream fos = null;

        try {
            long start = System.currentTimeMillis();
            convert(input, MimeTypeConfig.EXT_RTF, output);
            log.debug("Elapse rtf2html time: {}", FormatUtil.formatSeconds(System.currentTimeMillis() - start));
        } catch (Exception e) {
            throw new ConversionException("Error in RTF to HTML conversion", e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert PS to PDF (for document preview feature).
     */
    public void ps2pdf(File input, File output) throws IOException {
        log.debug("** Convert from PS to PDF **");
        FileOutputStream fos = null;
        String cmd = null;

        if (!input.getName().toLowerCase().endsWith(".ps")) {
            log.warn("ps2pdf conversion needs *.ps as input file");
        }

        try {
            // Performs conversion
            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("fileIn", input.getPath());
            hm.put("fileOut", output.getPath());
            String tpl = config.getGhostscript() + " ${fileIn} ${fileOut}";
            cmd = TemplateUtils.replace("SYSTEM_GHOSTSCRIPT_PS2PDF", tpl, hm);
            ExecutionResult er = ExecutionUtils.runCmd(cmd);

            if (er.getExitValue() != 0) {
                throw new ConversionException(er.getStderr());
            }
        } catch (SecurityException e) {
            throw new ConversionException("Security exception executing command: " + cmd, e);
        } catch (InterruptedException e) {
            throw new ConversionException("Interrupted exception executing command: " + cmd, e);
        } catch (IOException e) {
            throw new ConversionException("IO exception executing command: " + cmd, e);
        } catch (TemplateException e) {
            throw new ConversionException("Template exception", e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert IMG to PDF (for document preview feature).
     * <p/>
     * [0] => http://www.rubblewebs.co.uk/imagemagick/psd.php
     */
    public void img2pdf(File input, String mimeType, File output) throws IOException {
        log.debug("** Convert from {} to PDF **", mimeType);
        FileOutputStream fos = null;
        String cmd = null;

        try {
            // Performs conversion
            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("fileIn", input.getPath());
            hm.put("fileOut", output.getPath());

            if (MimeTypeConfig.EXT_IMAGE_PSD.equals(mimeType)) {
                String tpl = config.getImagemagickConvert() + " ${fileIn}[0] ${fileOut}";
                cmd = TemplateUtils.replace("SYSTEM_IMAGEMAGICK_CONVERT", tpl, hm);
            } else {
                String tpl = config.getImagemagickConvert() + " ${fileIn} ${fileOut}";
                cmd = TemplateUtils.replace("SYSTEM_IMAGEMAGICK_CONVERT", tpl, hm);
            }

            ExecutionResult er = ExecutionUtils.runCmd(cmd);

            if (er.getExitValue() != 0) {
                throw new ConversionException(er.getStderr());
            }
        } catch (SecurityException e) {
            throw new ConversionException("Security exception executing command: " + cmd, e);
        } catch (InterruptedException e) {
            throw new ConversionException("Interrupted exception executing command: " + cmd, e);
        } catch (IOException e) {
            throw new ConversionException("IO exception executing command: " + cmd, e);
        } catch (TemplateException e) {
            throw new ConversionException("Template exception", e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert SRC to PDF
     */
    public void src2pdf(File input, File output, String lang) throws IOException {
        log.debug("** Convert from SRC to PDF **");
        FileOutputStream fos = null;
        FileInputStream fis = null;

        try {
            fos = new FileOutputStream(output);
            fis = new FileInputStream(input);

            // Make syntax highlight
            String source = IOUtils.toString(fis);
           // JaSHi jashi = new JaSHi(source, lang);
            // jashi.EnableLineNumbers(1);
            //String parsed = jashi.ParseCode();

            // Make conversion to PDF
            Document doc = new Document(PageSize.A4.rotate());
            PdfWriter.getInstance(doc, fos);
            doc.open();
            HTMLWorker html = new HTMLWorker(doc);
            html.parse(new StringReader(source));
            doc.close();
        } catch (DocumentException e) {
            throw new ConversionException("Exception in conversion: " + e.getMessage(), e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert HTML to PDF
     */
    public void html2pdf(File input, File output) throws IOException {
        log.debug("** Convert from HTML to PDF **");
        FileOutputStream fos = null;

        try {
            fos = new FileOutputStream(output);

            // Make conversion
            Document doc = new Document(PageSize.A4);
            PdfWriter.getInstance(doc, fos);
            doc.open();
            HTMLWorker html = new HTMLWorker(doc);
            html.parse(new FileReader(input));
            doc.close();
        } catch (DocumentException e) {
            throw new ConversionException("Exception in conversion: " + e.getMessage(), e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert TXT to PDF
     */
    public void txt2pdf(InputStream is, File output) throws IOException {
        log.debug("** Convert from TXT to PDF **");
        FileOutputStream fos = null;
        String line = null;

        try {
            fos = new FileOutputStream(output);

            // Make conversion
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            Document doc = new Document(PageSize.A4);
            PdfWriter.getInstance(doc, fos);
            doc.open();

            while ((line = br.readLine()) != null) {
                doc.add(new Paragraph(12F, line));
            }

            doc.close();
        } catch (DocumentException e) {
            throw new ConversionException("Exception in conversion: " + e.getMessage(), e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }

    /**
     * Convert ZIP to PDF
     */
    @SuppressWarnings("rawtypes")
    public void zip2pdf(File input, File output) throws IOException {
        log.debug("** Convert from ZIP to PDF **");
        FileOutputStream fos = null;
        ZipFile zipFile = null;

        try {
            fos = new FileOutputStream(output);

            // Make conversion
            zipFile = new ZipFile(input);
            Document doc = new Document(PageSize.A4);
            PdfWriter.getInstance(doc, fos);
            doc.open();

            for (Enumeration e = zipFile.entries(); e.hasMoreElements(); ) {
                ZipEntry entry = (ZipEntry) e.nextElement();
                doc.add(new Paragraph(12F, entry.getName()));
            }

            doc.close();
            zipFile.close();
        } catch (ZipException e) {
            throw new ConversionException("Exception in conversion: " + e.getMessage(), e);
        } catch (DocumentException e) {
            throw new ConversionException("Exception in conversion: " + e.getMessage(), e);
        } finally {
            IOUtils.closeQuietly(fos);
        }
    }


    /**
     * Convert PDF to SWF (for document preview feature).
     */
    public void pdf2swf(File input, File output) throws IOException {
        log.debug("** Convert from PDF to SWF **");
        BufferedReader stdout = null;
        String cmd = null;

        try {
            // Performs conversion
            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("fileIn", input.getPath());
            hm.put("fileOut", output.getPath());
            cmd = TemplateUtils.replace("SYSTEM_PDF2SWF", config.getSwftoolsPdf2SWF(), hm);
            ExecutionResult er = ExecutionUtils.runCmd(cmd);

            if (er.getExitValue() != 0) {
                throw new ConversionException(er.getStderr());
            }
        } catch (SecurityException e) {
            throw new ConversionException("Security exception executing command: " + cmd, e);
        } catch (InterruptedException e) {
            throw new ConversionException("Interrupted exception executing command: " + cmd, e);
        } catch (IOException e) {
            throw new ConversionException("IO exception executing command: " + cmd, e);
        } catch (TemplateException e) {
            throw new ConversionException("Template exception", e);
        } finally {
            IOUtils.closeQuietly(stdout);
        }
    }

    /**
     * Convert PDF to IMG (for document preview feature).
     */
    public void pdf2img(File input, File output) throws IOException {
        log.debug("** Convert from PDF to IMG **");
        File tmpDir = FileUtils.createTempDir();
        String cmd = null;

        try {
            // Performs step 1: split pdf into several images
            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("fileIn", input.getPath());
            hm.put("fileOut", tmpDir + File.separator + "out.jpg");
            String tpl = config.getImagemagickConvert() + " -bordercolor #666 -border 2x2 ${fileIn} ${fileOut}";
            cmd = TemplateUtils.replace("SYSTEM_IMG2PDF", tpl, hm);
            ExecutionResult er = ExecutionUtils.runCmd(cmd);

            if (er.getExitValue() != 0) {
                throw new ConversionException(er.getStderr());
            }

            // Performs step 2: join split images into a big one
            hm = new HashMap<String, Object>();
            StringBuilder sb = new StringBuilder();
            File files[] = tmpDir.listFiles();
            Arrays.sort(files, new FileOrderComparator());

            for (File f : files) {
                sb.append(f.getPath()).append(" ");
            }

            hm.put("fileIn", sb.toString());
            hm.put("fileOut", output.getPath());
            tpl = config.getImagemagickConvert() + " ${fileIn}-append ${fileOut}";
            cmd = TemplateUtils.replace("SYSTEM_IMG2PDF", tpl, hm);
            er = ExecutionUtils.runCmd(cmd);

            if (er.getExitValue() != 0) {
                throw new ConversionException(er.getStderr());
            }
        } catch (SecurityException e) {
            throw new ConversionException("Security exception executing command: " + cmd, e);
        } catch (InterruptedException e) {
            throw new ConversionException("Interrupted exception executing command: " + cmd, e);
        } catch (IOException e) {
            throw new ConversionException("IO exception executing command: " + cmd, e);
        } catch (TemplateException e) {
            throw new ConversionException("Template exception", e);
        } finally {
            org.apache.commons.io.FileUtils.deleteQuietly(tmpDir);
        }
    }

    /**
     * User by pdf2img
     */
    private class FileOrderComparator implements Comparator<File> {
        @Override
        public int compare(File o1, File o2) {
            // Filenames are out-1.jpg, out-2.jpg, ..., out-10.jpg, ...
            int o1Ord = Integer.parseInt((o1.getName().split("\\.")[0]).split("-")[1]);
            int o2Ord = Integer.parseInt((o2.getName().split("\\.")[0]).split("-")[1]);

            if (o1Ord > o2Ord)
                return 1;
            else if (o1Ord < o2Ord)
                return -1;
            else
                return 0;
        }
    }

    /**
     * TIFF to PDF conversion
     */
    public void tiff2pdf(File input, File output) throws ConversionException {
        RandomAccessFileOrArray ra = null;
        Document doc = null;

        try {
            // Open PDF
            doc = new Document();
            PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream(output));
            PdfContentByte cb = writer.getDirectContent();
            doc.open();
            // int pages = 0;

            // Open TIFF
            ra = new RandomAccessFileOrArray(input.getPath());
            int comps = TiffImage.getNumberOfPages(ra);

            for (int c = 0; c < comps; ++c) {
                Image img = TiffImage.getTiffImage(ra, c + 1);

                if (img != null) {
                    log.debug("tiff2pdf - page {}", c + 1);

                    if (img.getScaledWidth() > 500 || img.getScaledHeight() > 700) {
                        img.scaleToFit(500, 700);
                    }

                    img.setAbsolutePosition(20, 20);
                    // doc.add(new Paragraph("page " + (c + 1)));
                    cb.addImage(img);
                    doc.newPage();
                    // ++pages;
                }
            }
        } catch (FileNotFoundException e) {
            throw new ConversionException("File not found: " + e.getMessage(), e);
        } catch (DocumentException e) {
            throw new ConversionException("Document exception: " + e.getMessage(), e);
        } catch (IOException e) {
            throw new ConversionException("IO exception: " + e.getMessage(), e);
        } finally {
            if (ra != null) {
                try {
                    ra.close();
                } catch (IOException e) {
                    // Ignore
                }
            }

            if (doc != null) {
                doc.close();
            }
        }
    }

    /**
     * Rotate an image.
     *
     * @param imgIn  Image to rotate.
     * @param imgOut Image rotated.
     * @param angle  Rotation angle.
     * @throws java.io.IOException
     */
    public void rotateImage(File imgIn, File imgOut, double angle) throws ConversionException {
        String cmd = null;

        try {
            // Performs conversion
            HashMap<String, Object> hm = new HashMap<String, Object>();
            hm.put("fileIn", imgIn.getPath());
            hm.put("fileOut", imgOut.getPath());
            String tpl = config.getImagemagickConvert() + " -rotate " + angle + " ${fileIn} ${fileOut}";
            cmd = TemplateUtils.replace("SYSTEM_IMG2PDF", tpl, hm);
            ExecutionUtils.runCmd(cmd);
        } catch (SecurityException e) {
            throw new ConversionException("Security exception executing command: " + cmd, e);
        } catch (InterruptedException e) {
            throw new ConversionException("Interrupted exception executing command: " + cmd, e);
        } catch (IOException e) {
            throw new ConversionException("IO exception executing command: " + cmd, e);
        } catch (TemplateException e) {
            throw new ConversionException("Template exception", e);
        }
    }
}
