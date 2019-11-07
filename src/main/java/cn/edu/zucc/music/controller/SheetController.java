package cn.edu.zucc.music.controller;

import cn.edu.zucc.music.Until.Result;
import cn.edu.zucc.music.Until.ResultStatus;
import cn.edu.zucc.music.dao.SheetSongMapper;
import cn.edu.zucc.music.model.Sheet;
import cn.edu.zucc.music.model.SheetSong;
import cn.edu.zucc.music.service.SheetService;
import cn.edu.zucc.music.service.SheetSongService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class SheetController {
    @Resource
    private SheetService sheetService;
    @Resource
    private SheetSongService sheetSongService;
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
    @GetMapping(value = "/api/addSong")
    @ResponseBody
    public Result<String > addSong(int sheetid,int songid){
        SheetSong sheetSong=new SheetSong();
        sheetSong.setSheetid(sheetid);
        sheetSong.setSongid(songid);
        if (1==sheetSongService.addSheet(sheetSong))
        return new Result<>(ResultStatus.SUCCESS);
        else
            return new Result<>(ResultStatus.ERROR);
    }

}
