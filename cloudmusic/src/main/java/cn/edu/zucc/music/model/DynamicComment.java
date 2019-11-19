package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class DynamicComment implements Serializable {
    private Integer dynamicCommentId;

    private Integer dynamicId;

    private String userId;

    private String commentContent;

    private Date commentTime;

    private static final long serialVersionUID = 1L;

    public Integer getDynamicCommentId() {
        return dynamicCommentId;
    }

    public void setDynamicCommentId(Integer dynamicCommentId) {
        this.dynamicCommentId = dynamicCommentId;
    }

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

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent == null ? null : commentContent.trim();
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", dynamicCommentId=").append(dynamicCommentId);
        sb.append(", dynamicId=").append(dynamicId);
        sb.append(", userId=").append(userId);
        sb.append(", commentContent=").append(commentContent);
        sb.append(", commentTime=").append(commentTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}