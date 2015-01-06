package com.quartet.resman.entity;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Folder extends BaseFolder {

    private String status;
    private String visibility;

    public Folder() {
    }

    public Folder(String path, String name,String createBy,
                  String status, String visibility) {
        this.path = path;
        this.name = name;
        this.createBy = createBy;
        this.status = status;
        this.visibility = visibility;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }

    @Override
    public String toString() {
        return "Folder{" +
                "status='" + status + '\'' +
                ", visibility='" + visibility + '\'' +
                "} " + super.toString();
    }
}
