package com.quartet.resman.entity;

import java.util.HashMap;
import java.util.Map;

/**
 * @author lcheng
 * @version 1.0
 *          ${tags}
 */
public class Result {
    private boolean success = true;
    private String msg;
    private Map<String, Object> data = new HashMap<>();

    public Result() {

    }

    public Result(boolean success, String msg) {
        this.success = success;
        this.msg = msg;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
