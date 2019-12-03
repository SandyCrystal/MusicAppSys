package cn.edu.zucc.music.repository;

import cn.edu.zucc.music.entity.UserEntityItem;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface UserRepository extends Neo4jRepository<UserEntityItem,Long> {
    @Query(value = "MATCH (n:user )-[r:user_com]->(m:comment{commentId:{id}}) return n ;")
    List<UserEntityItem> findAByCommentId(@Param("id") String  id);
}
