package cn.edu.zucc.music.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface PlotService {
    public Map<Integer,Integer> getPerYearSongCount();
    public int[] getMusicDistributed();
}
