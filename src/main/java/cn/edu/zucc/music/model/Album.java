package cn.edu.zucc.music.model;

import java.io.Serializable;
import java.util.Date;

public class Album implements Serializable {
    private String albumId;

    private String albunName;

    private String artistId;

    private Date publishTime;

    private String introduction;

    private String blurPicUrl;

    private static final long serialVersionUID = 1L;

    public String getAlbumId() {
        return albumId;
    }

    public void setAlbumId(String albumId) {
        this.albumId = albumId == null ? null : albumId.trim();
    }

    public String getAlbunName() {
        return albunName;
    }

    public void setAlbunName(String albunName) {
        this.albunName = albunName == null ? null : albunName.trim();
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

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction == null ? null : introduction.trim();
    }

    public String getBlurPicUrl() {
        return blurPicUrl;
    }

    public void setBlurPicUrl(String blurPicUrl) {
        this.blurPicUrl = blurPicUrl == null ? null : blurPicUrl.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", albumId=").append(albumId);
        sb.append(", albunName=").append(albunName);
        sb.append(", artistId=").append(artistId);
        sb.append(", publishTime=").append(publishTime);
        sb.append(", introduction=").append(introduction);
        sb.append(", blurPicUrl=").append(blurPicUrl);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}