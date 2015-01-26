package com.quartet.resman.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author qfxu
 */
public class FileUtils {
    private static Logger log = LoggerFactory.getLogger(FileUtils.class);

    /**
     * Returns the name of the file without the extension.
     */
    public static String getFileName(String file) {
        log.debug("getFileName({})", file);
        int idx = file.lastIndexOf(".");
        String ret = idx >= 0 ? file.substring(0, idx) : file;
        log.debug("getFileName: {}", ret);
        return ret;
    }

    /**
     * Returns the filename extension.
     */
    public static String getFileExtension(String file) {
        log.debug("getFileExtension({})", file);
        int idx = file.lastIndexOf(".");
        String ret = idx >= 0 ? file.substring(idx + 1) : "";
        log.debug("getFileExtension: {}", ret);
        return ret;
    }

    /**
     * Creates a temporal and unique directory
     *
     * @throws IOException If something fails.
     */
    public static File createTempDir() throws IOException {
        File tmpFile = File.createTempFile("resman", null);

        if (!tmpFile.delete())
            throw new IOException();
        if (!tmpFile.mkdir())
            throw new IOException();
        return tmpFile;
    }

    /**
     * Create temp file
     */
    public static File createTempFile() throws IOException {
        return File.createTempFile("resman", ".tmp");
    }

    /**
     * Create temp file with extension from mime
     */
    public static File createTempFileFromExt(String ext) throws IOException {
        return File.createTempFile("resman", "." + ext);
    }

    /**
     * Wrapper for FileUtils.deleteQuietly
     *
     * @param file File or directory to be deleted.
     */
    public static boolean deleteQuietly(File file) {
        return org.apache.commons.io.FileUtils.deleteQuietly(file);
    }

    /**
     * Wrapper for FileUtils.cleanDirectory
     *
     * @param directory File or directory to be deleted.
     */
    public static void cleanDirectory(File directory) throws IOException {
        org.apache.commons.io.FileUtils.cleanDirectory(directory);
    }

    /**
     * Wrapper for FileUtils.listFiles
     */
    @SuppressWarnings("unchecked")
    public static Collection<File> listFiles(File directory, String[] extensions, boolean recursive) {
        return org.apache.commons.io.FileUtils.listFiles(directory, extensions, recursive);
    }

    /**
     * Wrapper for FileUtils.readFileToByteArray
     *
     * @param file File or directory to be deleted.
     */
    public static byte[] readFileToByteArray(File file) throws IOException {
        return org.apache.commons.io.FileUtils.readFileToByteArray(file);
    }

    /**
     * Delete directory if empty
     */
    public static void deleteEmpty(File file) {
        if (file.isDirectory()) {
            if (file.list().length == 0) {
                file.delete();
            }
        }
    }

    /**
     * Count files and directories from a selected directory.
     */
    public static int countFiles(File dir) {
        File[] found = dir.listFiles();
        int ret = 0;

        if (found != null) {
            for (int i = 0; i < found.length; i++) {
                if (found[i].isDirectory()) {
                    ret += countFiles(found[i]);
                }

                ret++;
            }
        }

        return ret;
    }


    /**
     * Copy InputStream to File.
     */
    public static void copy(InputStream input, File output) throws IOException {
        FileOutputStream fos = new FileOutputStream(output);
        IOUtils.copy(input, fos);
        fos.flush();
        fos.close();
    }

    /**
     * Copy Reader to File.
     */
    public static void copy(Reader input, File output) throws IOException {
        FileOutputStream fos = new FileOutputStream(output);
        IOUtils.copy(input, fos);
        fos.flush();
        fos.close();
    }

    /**
     * Copy File to OutputStream
     */
    public static void copy(File input, OutputStream output) throws IOException {
        FileInputStream fis = new FileInputStream(input);
        IOUtils.copy(fis, output);
        fis.close();
    }

    /**
     * Copy File to File
     */
    public static void copy(File input, File output) throws IOException {
        org.apache.commons.io.FileUtils.copyFile(input, output);
    }

    /**
     * Create "year / month / day" directory structure.
     */
    public static File createDateDir(String parent) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy" + File.separator + "MM" + File.separator + "dd");
        File dateDir = new File(parent, sdf.format(new Date()));

        if (!dateDir.exists()) {
            dateDir.mkdirs();
        }

        return dateDir;
    }
}
