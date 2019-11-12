package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Dynamic implements Serializable {
    private Integer dynamicId;

    private String introduction;

    private String dynamicPath;

    private Date createTime;

    private String userId;

    private static final long serialVersionUID = 1L;

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

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", dynamicId=").append(dynamicId);
        sb.append(", introduction=").append(introduction);
        sb.append(", dynamicPath=").append(dynamicPath);
        sb.append(", createTime=").append(createTime);
        sb.append(", userId=").append(userId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}