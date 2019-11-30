package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.AlbumEntityItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;
import java.util.Optional;

public interface AlbunRepository extends Neo4jRepository<AlbumEntityItem, Long> {
    @Query(value = "MATCH (n:album {Id:{id}}) return n ;")
    List<AlbumEntityItem> findallById(@Param("id") Long id);
    @Query(value = "MATCH (n:artist {artistName:{name}})-[r:art_to_alb]->(m:album) return m ;")
    List<AlbumEntityItem> findAllByArtistName(@Param("name") String name);
    @Query(value = "MATCH (n:artist {artistId:{id}})-[r:art_to_alb]->(m:album) return m ;")
    List<AlbumEntityItem> findAllByArtistId(@Param("id") String  id);
}
