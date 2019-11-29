package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.SongEntityItem;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface SongRepository extends Neo4jRepository<SongEntityItem, Long>  {
    @Query(value = "MATCH (n:song) return n ; ")
    List<SongEntityItem> findAll();
}
