package com.quartet.resman.entity;

import java.io.InputStream;
import java.util.Date;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Document extends Entry{

    private Long size;
    private String mimeType;
    private String encoding;
    //针对视频文件的属性
    private String imgPath;     //视频截图的存储路径
    private String originStorePath; //原始视频文件的存储路径
    private String storedPath;      //转换后的视频文件存储路径
//    private InputStream content;
    private FileStream fileStream;

    public Document(){}

    public Document(String path, String createBy, FileStream fileStream, Long size) {
        super(path,createBy);
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

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getOriginStorePath() {
        return originStorePath;
    }

    public void setOriginStorePath(String originStorePath) {
        this.originStorePath = originStorePath;
    }

    public String getStoredPath() {
        return storedPath;
    }

    public void setStoredPath(String storedPath) {
        this.storedPath = storedPath;
    }

    @Override
    public String toString() {
        return "Document{" +
                "size=" + size +
                ", mimeType='" + mimeType + '\'' +
                ", encoding='" + encoding + '\'' +
                ", imgPath='" + imgPath + '\'' +
                ", originStorePath='" + originStorePath + '\'' +
                ", storedPath='" + storedPath + '\'' +
                "} " + super.toString();
    }
}
