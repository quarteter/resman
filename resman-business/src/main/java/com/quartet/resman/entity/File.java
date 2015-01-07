package com.quartet.resman.entity;

import java.io.InputStream;
import java.util.Date;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class File extends Entry{

    private Long size;
    private String mimeType;
    private String encoding;
//    private InputStream content;
    private FileStream fileStream;

    public File(){}

    public File(String path,String createBy,FileStream fileStream, Long size) {
        this.path = path;
        this.createBy = createBy;
        this.fileStream = fileStream;
        this.size = size;
    }

//    public InputStream getContent() {
//        return content;
//    }
//
//    public void setContent(InputStream is) {
//        this.content = is;
//    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public String getEncoding() {
        return encoding;
    }

    public void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public FileStream getFileStream() {
        return fileStream;
    }

    public void setFileStream(FileStream fileStream) {
        this.fileStream = fileStream;
    }

    @Override
    public String toString() {
        return "File{" +
                "encoding='" + encoding + '\'' +
                ", mimeType='" + mimeType + '\'' +
                ", size=" + size +
                "} " + super.toString();
    }
}
