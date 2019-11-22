package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.User;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;

public class PackerController {
    public static JSONObject transformSheetToJson(Sheet sheet) {
        JSONObject json = new JSONObject();
        json.put("id", sheet.getSheetId());
        json.put("name", sheet.getSheetName());
        json.put("picUrl", sheet.getSheetPicUrl());
        json.put("playCount", sheet.getPlayCount());
        json.put("createTime", sheet.getCreateTime());

        String resources = "generatorConfig.xml";
        Reader reader = null;

        try {
            reader = Resources.getResourceAsReader(resources);
            SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
            SqlSession session = sqlMapper.openSession();

            User user = session.selectOne("selectByPrimaryKey", sheet.getSheetId());
            JSONObject tmp = PackerController.transformUserToJson(user);
            json.put("creator", tmp);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return json;
    }

    public static JSONObject transformUserToJson(User user) {
        JSONObject json = new JSONObject();
        json.put("user_id", user.getUserId());
        json.put("user_name", user.getUserName());
        json.put("user_type", user.getUserType());
        json.put("avatar_url", user.getAvatarUrl());
        json.put("introduction", user.getIntroduction());

        return json;
    }
}