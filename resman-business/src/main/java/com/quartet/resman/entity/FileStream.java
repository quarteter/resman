package com.quartet.resman.entity;

import java.io.InputStream;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class FileStream {

    protected String path;

    protected InputStream content;

    public FileStream (){}

    public FileStream(InputStream content){
        this.content = content;
    }

    public InputStream getContent() {
        return content;
    }

    public void setContent(InputStream content) {
        this.content = content;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }
}
