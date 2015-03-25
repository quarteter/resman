package com.quartet.resman.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by lcheng on 2015/3/24.
 * 新闻
 */
@Entity
@Table(name = "r_news")
public class News extends BaseText {

    private boolean bannerNews;
    private String bannerImgUrl;

    public boolean isBannerNews() {
        return bannerNews;
    }

    public void setBannerNews(boolean bannerNews) {
        this.bannerNews = bannerNews;
    }

    public String getBannerImgUrl() {
        return bannerImgUrl;
    }

    public void setBannerImgUrl(String bannerImgUrl) {
        this.bannerImgUrl = bannerImgUrl;
    }
}
