package com.quartet.resman.vo;

/**
 * Created by XWANG on 2015/1/14.
 */
public class QuestionVo {

    public QuestionVo()
    {
        resCount = 0L;
    }

    Long id;

    /**
     * 问题
     */
    String question;

    public Long getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public Long getResCount() {
        return resCount;
    }

    public String getTime() {
        return time;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public void setResCount(Long resCount) {
        this.resCount = resCount;
    }

    public void setTime(String time) {
        this.time = time;
    }

    /**
     * 多少人回复
     */
    Long resCount;

    /**
     * 最新回复距离当前有多久
     */
    String time;

}

