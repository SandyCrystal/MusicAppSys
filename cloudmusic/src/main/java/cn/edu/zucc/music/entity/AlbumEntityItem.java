package cn.edu.zucc.music.entity;
import org.neo4j.ogm.annotation.*;

import java.util.List;

@NodeEntity(label="album")
public class AlbumEntityItem {
    @Id
    @GeneratedValue
    private  Long id;
    @Property(name = "albumName")
    private String  albumName;
    @Property(name = "publishTime")
    private String  publishTime;
    @Property(name = "albumId")
    private String  albumId;
    @Property(name = "artistId")
    private String  artistId;
    @Relationship(type = "alb_to_song",direction = Relationship.OUTGOING)
    private List<SongEntityItem> songEntityItemList;

    public List<SongEntityItem> getSongEntityItemList() {
        return songEntityItemList;
    }

    public void setSongEntityItemList(List<SongEntityItem> songEntityItemList) {
        this.songEntityItemList = songEntityItemList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAlbumName() {
        return albumName;
    }

    public void setAlbumName(String albumName) {
        this.albumName = albumName;
    }

    public String getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public String getAlbumId() {
        return albumId;
    }

    public void setAlbumId(String albumId) {
        this.albumId = albumId;
    }

    public String getArtistId() {
        return artistId;
    }

    public void setArtistId(String artistId) {
        this.artistId = artistId;
    }
}
