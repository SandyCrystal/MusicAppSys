package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class SongComment implements Serializable {
    private String songCommentId;

    private String songId;

    private String userId;

    private String commentContent;

    private Date commentTime;

    private Integer likeCount;


    private static final long serialVersionUID = 1L;

    public String getSongCommentId() {
        return songCommentId;
    }

    public void setSongCommentId(String songCommentId) {
        this.songCommentId = songCommentId;
    }

    public String getSongId() {
        return songId;
    }

    public void setSongId(String songId) {
        this.songId = songId == null ? null : songId.trim();
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
        sb.append(", songCommentId=").append(songCommentId);
        sb.append(", songId=").append(songId);
        sb.append(", userId=").append(userId);
        sb.append(", commentContent=").append(commentContent);
        sb.append(", commentTime=").append(commentTime);
        sb.append(", likeCount=").append(likeCount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}