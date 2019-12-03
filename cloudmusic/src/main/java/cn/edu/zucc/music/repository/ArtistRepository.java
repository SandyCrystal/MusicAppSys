package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.ArtistEntityItem;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface ArtistRepository extends Neo4jRepository<ArtistEntityItem, Long> {
    @Query(value = "MATCH (n:artist {artistName:{name}}) return n;")
    List<ArtistEntityItem> findByArtistName(@Param("name") String name);
    @Query(value = "MATCH (n:artist)-[r:art_to_alb]-(m:album{albumId:{id}}) return n;")
    List<ArtistEntityItem> findArtByAlb(@Param("id") String id);

}
