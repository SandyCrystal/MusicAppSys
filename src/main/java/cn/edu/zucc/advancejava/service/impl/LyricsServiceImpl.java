package cn.edu.zucc.advancejava.service.impl;

import cn.edu.zucc.advancejava.dao.LyricsMapper;
import cn.edu.zucc.advancejava.model.Lyrics;
import cn.edu.zucc.advancejava.service.LyricsService;
import com.hankcs.hanlp.HanLP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service(value = "LyricsService")
public class LyricsServiceImpl implements LyricsService {
    @Autowired
    private LyricsMapper lyricsMapper;

    @Override
    public Map<Long, ArrayList<String>> getAllLyrics() {
        Map<Long, ArrayList<String>> map=new HashMap<>();
        List<Lyrics> lyricsList=lyricsMapper.selectAllLyrics();
        for (int i=0;i<100;i++)
        System.out.println(lyricsList.get(1).getLyric());
        for (Lyrics i:lyricsList){
            ArrayList<String> a= (ArrayList<String>) HanLP.extractKeyword(i.getLyric(),5);

            map.put(i.getMusicId(),a);
        }
        return map;
    }


}
