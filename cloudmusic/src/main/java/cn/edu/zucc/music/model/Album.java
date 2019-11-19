package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Album implements Serializable {
    private String albumId;

    private String artistId;

    private Date publishTime;

    private String albumName;

    private String introduction;

    private String albumPicUrl;

    private Integer subCount;

    private Integer commentCount;

    private Integer shareCount;

    private static final long serialVersionUID = 1L;

    public String getAlbumId() {
        return albumId;
    }

    public void setAlbumId(String albumId) {
        this.albumId = albumId == null ? null : albumId.trim();
    }

    public String getArtistId() {
        return artistId;
    }

    public void setArtistId(String artistId) {
        this.artistId = artistId == null ? null : artistId.trim();
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getAlbumName() {
        return albumName;
    }

    public void setAlbumName(String albumName) {
        this.albumName = albumName == null ? null : albumName.trim();
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction == null ? null : introduction.trim();
    }

    public String getAlbumPicUrl() {
        return albumPicUrl;
    }

    public void setAlbumPicUrl(String albumPicUrl) {
        this.albumPicUrl = albumPicUrl == null ? null : albumPicUrl.trim();
    }

    public Integer getSubCount() {
        return subCount;
    }

    public void setSubCount(Integer subCount) {
        this.subCount = subCount;
    }

    public Integer getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(Integer commentCount) {
        this.commentCount = commentCount;
    }

    public Integer getShareCount() {
        return shareCount;
    }

    public void setShareCount(Integer shareCount) {
        this.shareCount = shareCount;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", albumId=").append(albumId);
        sb.append(", artistId=").append(artistId);
        sb.append(", publishTime=").append(publishTime);
        sb.append(", albumName=").append(albumName);
        sb.append(", introduction=").append(introduction);
        sb.append(", albumPicUrl=").append(albumPicUrl);
        sb.append(", subCount=").append(subCount);
        sb.append(", commentCount=").append(commentCount);
        sb.append(", shareCount=").append(shareCount);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}