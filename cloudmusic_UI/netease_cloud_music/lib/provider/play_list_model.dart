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
    if (value != null) {
      _allPlayList = value;
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
    notifyListeners();
  }

  void addPlayList(Playlist playlist) {
    _allPlayList.add(playlist);
    _splitPlayList();
  }

  void delPlayList(Playlist playlist) {
    _allPlayList.remove(playlist);
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
