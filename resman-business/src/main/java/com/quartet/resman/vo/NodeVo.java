package com.quartet.resman.vo;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class NodeVo {

    private String name;
    private String path;
    private String mimeType;

    public NodeVo() {
    }

    public NodeVo(String name, String path, String mimeType) {
        this.mimeType = mimeType;
        this.name = name;
        this.path = path;
    }

    public String getMimeType() {
        return mimeType;
    }

    public void setMimeType(String mimeType) {
        this.mimeType = mimeType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Override
    public String toString() {
        return "NodeVo{" +
                "mimeType='" + mimeType + '\'' +
                ", name='" + name + '\'' +
                ", path='" + path + '\'' +
                '}';
    }
}