import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';

import '../application.dart';

class PlayListModel with ChangeNotifier {
  User user;

  List<Playlist> _selfCreatePlayList = []; // 我创建的歌单
  List<Playlist> _collectPlayList = []; // 收藏的歌单
  List<Playlist> _allPlayList = []; // 所有的
  List<Playlist> get selfCreatePlayList => _selfCreatePlayList;

  List<Playlist> get collectPlayList => _collectPlayList;

  List<Playlist> get allPlayList => _allPlayList;

  void setPlayList(List<Playlist> value) {
    if (_allPlayList.length > 0) {
      if (value != null) {
        _allPlayList.addAll(value);
      }
    } else {
      if (value != null) {
        _allPlayList = value;
      }
    }
    var index=[];
    for(int i=0;i<_allPlayList.length;i++){
      if(index.contains(_allPlayList[i].id)){
        _allPlayList.removeAt(i);
      }else{
        index.add(_allPlayList[i].id);
      }
    }
    _splitPlayList();
  }

  void _splitPlayList() {

    _selfCreatePlayList = _allPlayList
        .where((p) =>
            p.creator.userid ==
            User.fromJson(json.decode(Application.sp.getString('user')))
                .account
                .userid)
        .toList();
    _collectPlayList = _allPlayList
        .where((p) =>
            p.creator.userid !=
            User.fromJson(json.decode(Application.sp.getString('user')))
                .account
                .userid)
        .toList();
    var index=[];
    for(int i=0;i<_selfCreatePlayList.length;i++){
      if(index.contains(_selfCreatePlayList[i].id)){
        _selfCreatePlayList.removeAt(i);
      }else{
        index.add(_selfCreatePlayList[i].id);
      }
    }
    index=[];
    for(int i=0;i<_collectPlayList.length;i++){
      if(index.contains(_collectPlayList[i].id)){
        _collectPlayList.removeAt(i);
      }else{
        index.add(_collectPlayList[i].id);
      }
    }
    notifyListeners();
  }

  void addPlayList(Playlist playlist) {
    _allPlayList.add(playlist);
    var index=[];
    for(int i=0;i<_allPlayList.length;i++){
      if(index.contains(_allPlayList[i].id)){
        _allPlayList.removeAt(i);
      }else{
        index.add(_allPlayList[i].id);
      }
    }
    _splitPlayList();
  }

  void delPlayList(String id) {

    var index=[];
    for(int i=0;i<_allPlayList.length;i++){
      if(_allPlayList[i].id==id)_allPlayList.removeAt(i);
      if(index.contains(_allPlayList[i].id)){
        _allPlayList.removeAt(i);
      }else{
        index.add(_allPlayList[i].id);
      }
    }
    _splitPlayList();
  }

  void getSelfPlaylistData(BuildContext context) async {
    var result = await NetUtils.getSelfPlaylistData(context, params: {
      'user_id': User.fromJson(json.decode(Application.sp.getString('user')))
          .account
          .userid
    });
    setPlayList(result.playlist);
  }

  void getCollectionPlaylistData(BuildContext context) async {
    var result = await NetUtils.getCollectionPlaylistData(context, params: {
      'user_id': User.fromJson(json.decode(Application.sp.getString('user')))
          .account
          .userid
    });
    setPlayList(result.playlist);
  }
}
