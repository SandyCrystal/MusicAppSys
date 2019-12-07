package cn.edu.zucc.music.model;

import java.io.Serializable;

public class Like implements Serializable {
    private Integer likeId;

    private String likeUserId;

    private String tolikedId;

    private Integer likeType;

    private static final long serialVersionUID = 1L;

    public Integer getLikeId() {
        return likeId;
    }

    public void setLikeId(Integer likeId) {
        this.likeId = likeId;
    }

    public String getLikeUserId() {
        return likeUserId;
    }

    public void setLikeUserId(String likeUserId) {
        this.likeUserId = likeUserId == null ? null : likeUserId.trim();
    }

    public String getTolikedId() {
        return tolikedId;
    }

    public void setTolikedId(String tolikedId) {
        this.tolikedId = tolikedId;
    }

    public Integer getLikeType() {
        return likeType;
    }

    public void setLikeType(Integer likeType) {
        this.likeType = likeType;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", likeId=").append(likeId);
        sb.append(", likeUserId=").append(likeUserId);
        sb.append(", tolikeId=").append(tolikedId);
        sb.append(", likeType=").append(likeType);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}