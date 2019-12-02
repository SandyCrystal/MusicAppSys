package cn.edu.zucc.music.service.impl;

import cn.edu.zucc.music.dao.ArtistMapper;
import cn.edu.zucc.music.dao.SongMapper;
import cn.edu.zucc.music.service.PlotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class PlotServiceImpl implements PlotService {
    @Resource
    private SongMapper songMapper;
    @Resource
    private ArtistMapper artistMapper;
    @Override
    public Map<Integer, Integer> getPerYearSongCount() {
        Map<Integer,Integer> data=new HashMap<>();
        for (int i=1970;i<=2019;i++){
            String start=i+"-1-1 00:00:00";
            String end=(i+1)+"-1-1 00:00:00";
            Integer count=songMapper.getYearSongCount(start,end);
            System.out.println("year:"+i+" coun:"+count);
//            Integer count=songMapper.getYearSongCount();
            data.put(i,count);
        }
        return data;
    }

    @Override
    public int[] getMusicDistributed(){
        int[] list=new int[6];
        int[] start=new int[]{0,11,101,1001,5001,10001};
        int[] end=new int[]{10,100,1000,5000,10000,100000};
        for (int i=0;i<6;i++){
            list[i]=artistMapper.getDistribute(start[i],end[i]);
        }
        return list;
    }

}
