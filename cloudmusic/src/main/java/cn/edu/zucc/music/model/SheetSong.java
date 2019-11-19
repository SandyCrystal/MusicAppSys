package cn.edu.zucc.music.model;

import java.io.Serializable;

public class SheetSong implements Serializable {
    private Integer sheetSongId;

    private String sheetId;

    private String songId;

    private static final long serialVersionUID = 1L;

    public Integer getSheetSongId() {
        return sheetSongId;
    }

    public void setSheetSongId(Integer sheetSongId) {
        this.sheetSongId = sheetSongId;
    }

    public String getSheetId() {
        return sheetId;
    }

    public void setSheetId(String sheetId) {
        this.sheetId = sheetId == null ? null : sheetId.trim();
    }

    public String getSongId() {
        return songId;
    }

    public void setSongId(String songId) {
        this.songId = songId == null ? null : songId.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", sheetSongId=").append(sheetSongId);
        sb.append(", sheetId=").append(sheetId);
        sb.append(", songId=").append(songId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}