package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Dynamic implements Serializable {
    private Integer dynamicId;

    private String userId;

    private String introducion;

    private String dynamicPath;

    private Date createTime;

    private Integer likeCount;

    private Integer dynamicType;

    public Integer getDynamicType() {
        return dynamicType;
    }

    public void setDynamicType(Integer dynamicType) {
        this.dynamicType = dynamicType;
    }

    private static final long serialVersionUID = 1L;

    public Integer getDynamicId() {
        return dynamicId;
    }

    public void setDynamicId(Integer dynamicId) {
        this.dynamicId = dynamicId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getIntroducion() {
        return introducion;
    }

    public void setIntroducion(String introducion) {
        this.introducion = introducion == null ? null : introducion.trim();
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

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", dynamicId=").append(dynamicId);
        sb.append(", userId=").append(userId);
        sb.append(", introducion=").append(introducion);
        sb.append(", dynamicPath=").append(dynamicPath);
        sb.append(", createTime=").append(createTime);
        sb.append(", likeCount=").append(likeCount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}