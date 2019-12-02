package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.SongCommentEntityItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface CommentRepository extends Neo4jRepository<SongCommentEntityItem, Long> {
    @Query(value = "Match(m:comment)-[r:com_song]->(n:song {songId: {id}}) return m;")
    List<SongCommentEntityItem> findABySongId(@Param("id") String id);
    @Query(value = "Match(m:user {userId: {id}})-[r:user_com]->(n:comment) return n;")
    List<SongCommentEntityItem> findAByUserId(@Param("id") String id);
}
