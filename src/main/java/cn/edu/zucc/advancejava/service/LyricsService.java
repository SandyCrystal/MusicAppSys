package cn.edu.zucc.advancejava.service;

import java.util.ArrayList;
import java.util.Map;

public interface LyricsService {
    Map<Long, ArrayList<String>> getAllLyrics();
}
