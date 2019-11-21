package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.service.SheetService;
import com.alibaba.fastjson.JSONObject;
import jdk.internal.loader.Resource;
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
    @GetMapping(value = "/api/createSheet")
    @ResponseBody
    public JSONObject recommandSheet() {
        JSONObject jsonObject = new JSONObject();
        String resources = "mybatis.xml";
        Reader reader = null;
        List<Sheet> list = new ArrayList<Sheet>();
        try {
            reader = Resources.getResourceAsReader(resources);
            SqlSessionFactory sqlMapper = new SqlSessionFactoryBuilder().build(reader);
            SqlSession session = sqlMapper.openSession();

            list = session.selectList("selectTenSheets");
            if(list.size() < 10) {
                jsonObject.put("code", 4000);
            }

            List<JSONObject> data = new ArrayList<JSONObject>();
            for(Sheet sheet : list) {
                JSONObject tmp = PackerController.transformSheetToJson(sheet);
                data.add(tmp);
            }

            jsonObject.put("data", data);
        } catch (IOException e) {
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
