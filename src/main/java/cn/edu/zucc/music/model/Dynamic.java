package cn.edu.zucc.music.model;

import java.util.Date;

public class Dynamic {
    private Integer id;

    private Integer dynamicId;

    private String introduction;

    private String dynamicPath;

    private Date createTime;

    private String userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDynamicId() {
        return dynamicId;
    }

    public void setDynamicId(Integer dynamicId) {
        this.dynamicId = dynamicId;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction == null ? null : introduction.trim();
    }

    public String getDynamicPath() {
        return dynamicPath;
    }

    public void setDynamicPath(String dynamicPath) {
        this.dynamicPath = dynamicPath == null ? null : dynamicPath.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }
}