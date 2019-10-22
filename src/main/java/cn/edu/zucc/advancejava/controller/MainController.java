package cn.edu.zucc.advancejava.controller;

import cn.edu.zucc.advancejava.Until.Result;
import cn.edu.zucc.advancejava.Until.ResultStatus;
import cn.edu.zucc.advancejava.model.Albums;
import cn.edu.zucc.advancejava.model.User;
import cn.edu.zucc.advancejava.service.AlbumsService;
import cn.edu.zucc.advancejava.service.LyricsService;
import com.hankcs.hanlp.HanLP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
public class MainController {
    @Autowired
    private AlbumsService albumsService;
    @Autowired
    private LyricsService lyricsService;
    @GetMapping(value = "getUser")
    public String getUser(String callback){
        return "admin";
    }
    @CrossOrigin
    @PostMapping(value = "api/login")
    @ResponseBody
    public Result login(@RequestBody User requestUser) {
        // 对 html 标签进行转义，防止 XSS 攻击
        String username = requestUser.getUsername();
        username = HtmlUtils.htmlEscape(username);
        Albums a=albumsService.findAlbum(5818);
        System.out.println(a.getTitle());
        if (!Objects.equals("admin", username) || !Objects.equals("123456", requestUser.getPassword())) {
            String message = "账号密码错误";
            return new Result(ResultStatus.ERROR);
        } else {
            return new Result(ResultStatus.SUCCESS);
        }
    }
    @CrossOrigin
    @GetMapping(value = "api/TF_IDF")
    @ResponseBody
    public void getKeyWord(){
        Map<Long, ArrayList<String>> map=lyricsService.getAllLyrics();
        for (Map.Entry<Long, ArrayList<String>> entry:map.entrySet()) {
            System.out.println(entry.getKey());
            ArrayList<String > a=entry.getValue();
            for (String i:a){
                System.out.println(i);
            }
        }

//        String content ="";
//        List<String> keywordList = HanLP.extractKeyword(content, 5);
//        System.out.println(keywordList);
//        return (ArrayList<String>) keywordList;
    }

}
