package cn.edu.zucc.music.entity;
import org.neo4j.ogm.annotation.*;

import java.io.Serializable;
import java.util.List;

@NodeEntity(label = "artist")
public class ArtistEntityItem   implements Serializable {
    @Id
    @GeneratedValue
    private  Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    @Property(name = "artistName")
    private String  artistName;
    @Property(name = "artistId")
    private String  artistId;
    @Property(name = "musicSize")
    private String  musicSize;
    @Property(name = "albumSize")
    private String  albumSize;
    @Relationship(type = "art_to_alb",direction = Relationship.OUTGOING)
    private List<AlbumEntityItem> albumEntityItemList;

    public List<AlbumEntityItem> getAlbumEntityItemList() {
        return albumEntityItemList;
    }

    public void setAlbumEntityItemList(List<AlbumEntityItem> albumEntityItemList) {
        this.albumEntityItemList = albumEntityItemList;
    }

    public String getArtistId() {
        return artistId;
    }

    public void setArtistId(String artistId) {
        this.artistId = artistId;
    }

    public String getMusicSize() {
        return musicSize;
    }

    public void setMusicSize(String musicSize) {
        this.musicSize = musicSize;
    }

    public String getAlbumSize() {
        return albumSize;
    }

    public void setAlbumSize(String albumSize) {
        this.albumSize = albumSize;
    }

    public String getArtistName() {
        return artistName;
    }

    public void setArtistName(String artistName) {
        this.artistName = artistName;
    }
}
