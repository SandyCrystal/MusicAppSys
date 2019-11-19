package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class AlbumComment implements Serializable {
    private Integer albumCommentId;

    private Integer albumId;

    private String userId;

    private String userName;

    private String commentContent;

    private Date commentTime;

    private Integer likeCount;

    private static final long serialVersionUID = 1L;

    public Integer getAlbumCommentId() {
        return albumCommentId;
    }

    public void setAlbumCommentId(Integer albumCommentId) {
        this.albumCommentId = albumCommentId;
    }

    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
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
        sb.append(", albumCommentId=").append(albumCommentId);
        sb.append(", albumId=").append(albumId);
        sb.append(", userId=").append(userId);
        sb.append(", userName=").append(userName);
        sb.append(", commentContent=").append(commentContent);
        sb.append(", commentTime=").append(commentTime);
        sb.append(", likeCount=").append(likeCount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}