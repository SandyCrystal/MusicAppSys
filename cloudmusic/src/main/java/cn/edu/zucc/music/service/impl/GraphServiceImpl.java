package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.entity.*;
import cn.edu.zucc.music.repository.*;
import cn.edu.zucc.music.service.GraphService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GraphServiceImpl implements GraphService {
    @Autowired
    private SongRepository songRepository;
    @Autowired
    private ArtistRepository artistRepository;
    @Autowired
    private AlbunRepository albunRepository;
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private UserRepository userRepository;
    @Override
    public List<ArtistEntityItem> getArtistItem(String name) {
        List<ArtistEntityItem> list=artistRepository.findByArtistName(name);
        for(ArtistEntityItem artist:list){
           List<AlbumEntityItem>albums= albunRepository.findAllByArtistId(artist.getArtistId());
           for(AlbumEntityItem album : albums){
               album.setSongEntityItemList(songRepository.findAllByAlbumId(album.getAlbumId()));
           }
           System.out.println(albums.size());
            artist.setAlbumEntityItemList(albums);
        }
        return list;
    }

    @Override
    public List<AlbumEntityItem> getAlbumItem(String  Id) {
        return albunRepository.findAllByArtistId(Id);
    }

    @Override
    public List<AlbumEntityItem> getAlbumItemByname(String name) {
        return albunRepository.findByAlbumName(name);
    }

    @Override
    public List<SongEntityItem> getSongByname(String name) {
        return songRepository.findBySongName(name);
    }

    @Override
    public List<SongEntityItem> getSongItem(String id) {
        return songRepository.findAllByAlbumId(id);
    }

    @Override
    public List<ArtistEntityItem> getArtItemByAlb(String id) {
        return artistRepository.findArtByAlb(id);
    }

    @Override
    public List<SongCommentEntityItem> getCommentsBySongId(String id) {

        return commentRepository.findABySongId(id);
    }

    @Override
    public List<AlbumEntityItem> getAlbumItemBySong(String Id) {
        return albunRepository.findAllBySongID(Id);
    }

    @Override
    public List<UserEntityItem> getUserByComment(String id) {
        return userRepository.findAByCommentId(id);
    }

    @Override
    public List<SongCommentEntityItem> getCommentByUser(String id) {
        return commentRepository.findAByUserId(id);
    }

    @Override
    public List<SongEntityItem> getSongByComment(String id) {
        return songRepository.findAByCommentId(id);
    }
}
