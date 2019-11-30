package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.SongEntityItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface SongRepository extends Neo4jRepository<SongEntityItem, Long>  {
    @Query(value = "MATCH (n:album {albumName:%name%})-[r:alb_to_song]->(m:song) return m ;")
    List<SongEntityItem> findAllByAlbumName(@Param("name") String name);
    @Query(value = "MATCH (n:album {albumId:{id}})-[r:alb_to_song]->(m:song) return m ;")
    List<SongEntityItem> findAllByAlbumId(@Param("id") String  id);
}
