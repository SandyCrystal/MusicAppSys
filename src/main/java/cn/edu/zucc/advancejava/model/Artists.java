package cn.edu.zucc.advancejava.model;

public class Artists {
    private Long artistId;

    private String artistName;

    private String artistIntroduction;

    public Long getArtistId() {
        return artistId;
    }

    public void setArtistId(Long artistId) {
        this.artistId = artistId;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName == null ? null : artistName.trim();
    }

    public String getArtistIntroduction() {
        return artistIntroduction;
    }

    public void setArtistIntroduction(String artistIntroduction) {
        this.artistIntroduction = artistIntroduction == null ? null : artistIntroduction.trim();
    }
}