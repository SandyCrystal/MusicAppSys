package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.User;
import cn.edu.zucc.music.service.SheetService;
import cn.edu.zucc.music.service.UserService;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;


@Controller
public class SheetController {
    @Autowired
    private SheetService sheetService;
    @Autowired
    private UserService userService;
    @CrossOrigin
    @GetMapping(value = "/api/createSheet")
    @ResponseBody
    public Result<String > createSheet(String userid, String sheetname ){
        Sheet sheet =new Sheet();
        sheet.setSheetName(sheetname);
        sheet.setUserId(userid);
        int a=sheetService.addSheet(sheet);
        System.out.println(a);
        return new Result<>(ResultStatus.SUCCESS);
    }

    @CrossOrigin
    @GetMapping(value = "/api/recommandSheet")
    @ResponseBody
    public JSONObject recommandSheet() {
        JSONObject jsonObject = new JSONObject();
//        String resources = "/resource/mapper/mybatis.xml";
//        Reader reader = null;
        List<Sheet> list = new ArrayList<Sheet>();
        try {
//            reader = Resources.getResourceAsReader(resources);
//            SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
//            SqlSession session = sqlMapper.openSession();

//            list = session.selectList("selectTenSheets");
            list=sheetService.selectTenSheets();
//            if(list.size() < 10) {
//                jsonObject.put("code", 4000);
//            }
            jsonObject.put("code", 200);
            List<JSONObject> data = new ArrayList<JSONObject>();
            for(Sheet sheet : list) {
                User user=userService.findById(sheet.getUserId());
                JSONObject tmp = PackerController.transformSheetToJson(sheet,user);
                data.add(tmp);
            }

            jsonObject.put("data", data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonObject;
    }

//    @CrossOrigin
//    @GetMapping(value = "/api/addSong")
//    @ResponseBody
//    public Result<String > addSong(int sheetid,int songid){
//        SheetSong sheetSong=new SheetSong();
//        sheetSong.setSheetid(sheetid);
//        sheetSong.setSongid(songid);
//        if (1==sheetSongService.addSheet(sheetSong))
//        return new Result<>(ResultStatus.SUCCESS);
//        else
//            return new Result<>(ResultStatus.ERROR);
//    }

}
