package cn.edu.zucc.music.model;

import java.io.Serializable;

public class Artist implements Serializable {
    private String artistId;

    private String artistName;

    private Integer albumSize;

    private Integer musicSize;

    private String artistPicUrl;

    private static final long serialVersionUID = 1L;

    public String getArtistId() {
        return artistId;
    }

    public void setArtistId(String artistId) {
        this.artistId = artistId == null ? null : artistId.trim();
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName == null ? null : artistName.trim();
    }

    public Integer getAlbumSize() {
        return albumSize;
    }

    public void setAlbumSize(Integer albumSize) {
        this.albumSize = albumSize;
    }

    public Integer getMusicSize() {
        return musicSize;
    }

    public void setMusicSize(Integer musicSize) {
        this.musicSize = musicSize;
    }

    public String getArtistPicUrl() {
        return artistPicUrl;
    }

    public void setArtistPicUrl(String artistPicUrl) {
        this.artistPicUrl = artistPicUrl == null ? null : artistPicUrl.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", artistId=").append(artistId);
        sb.append(", artistName=").append(artistName);
        sb.append(", albumSize=").append(albumSize);
        sb.append(", musicSize=").append(musicSize);
        sb.append(", artistPicUrl=").append(artistPicUrl);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}