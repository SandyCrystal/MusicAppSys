package cn.edu.zucc.music.entity;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Property;

import java.io.Serializable;

@NodeEntity(label = "comment")
public class SongCommentEntityItem  implements Serializable {
    @Id
    @GeneratedValue
    private  Long id;
    @Property(name = "commentId")
    private String commentId;
    @Property(name = "commentTime")
    private String commentTime;
    @Property(name = "songId")
    private String songId;
    @Property(name = "userId")
    private String userId;
    @Property(name = "likes")
    private String  likes;

    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    public String getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public String getSongId() {
        return songId;
    }

    public void setSongId(String songId) {
        this.songId = songId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String  getLikes() {
        return likes;
    }

    public void setLikes(String  likes) {
        this.likes = likes;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
