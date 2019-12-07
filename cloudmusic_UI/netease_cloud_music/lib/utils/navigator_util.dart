import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/search_result.dart' as prefix0;
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/utils/fluro_convert_utils.dart';

import '../application.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        transition: TransitionType.material);
  }

  /// 登录页
  static void goLoginPage(BuildContext context) {
    _navigateTo(context, Routes.login, clearStack: true);
  }
  static void goRegister(BuildContext context) {
    _navigateTo(context, Routes.resigter, clearStack: true);
  }

  /// 首页
  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }

  /// 每日推荐歌曲
  static void goDailySongsPage(BuildContext context) {
    _navigateTo(context, Routes.dailySongs);
  }
  /// 添加歌曲到歌单
  static void goaddSongPage(BuildContext context,
  {@required String data}) {
    _navigateTo(context, "${Routes.addSongs}?data=${data}");
  }
  /// 歌单详情
  static void goPlayListPage(BuildContext context,
      {@required Recommend data}) {
    _navigateTo(context,
        "${Routes.playList}?data=${FluroConvertUtils.object2string(data)}");
  }
  ///其他个人页面
  static void goOtherPerson(BuildContext context,
      {@required User data}){
    _navigateTo(context,
        "${Routes.otherperson}?data=${FluroConvertUtils.object2string(data)}");
  }
  static void goFollowed(BuildContext context) {
    _navigateTo(context, Routes.followed, clearStack: true);
  }
  static void goFans(BuildContext context) {
    _navigateTo(context, Routes.fans, clearStack: true);
  }

  ///搜索页面
  static void goCommunityMessagePage(BuildContext context) {
    _navigateTo(context, Routes.commnuitymessage);
  }
  /// 排行榜首页
  static void goTopListPage(BuildContext context) {
    _navigateTo(context, Routes.topList);
  }
  ///歌单广场
  static void goListSongPage(BuildContext context) {
    _navigateTo(context, Routes.list_song);
  }
  ///专辑
  static void goAlbumPage(BuildContext context) {
    _navigateTo(context, Routes.album);
  }
  /// 歌单详情

  static void goAlbumDetailsPage(BuildContext context,
      {@required Albums data}) {
    _navigateTo(context,
        "${Routes.albumDetails}?data=${FluroConvertUtils.object2string(data)}");
  }

  /// 播放歌曲页面
  static void goPlaySongsPage(BuildContext context) {
    _navigateTo(context, Routes.playSongs);
  }


  /// 评论页面
  static void goCommentPage(BuildContext context,
      {@required CommentHead data}) {
    _navigateTo(context,
        "${Routes.comment}?data=${FluroConvertUtils.object2string(data)}");
  }
///搜索页面
  static void goSearchPage(BuildContext context) {
    _navigateTo(context, Routes.search);
  }
  ///搜索页面
  static void gonewSearchPage(BuildContext context) {
    _navigateTo(context, Routes.newsearch);
  }
  ///添加动态页面
  static void goCreate_commnuityPage(BuildContext context,
      {@required String data}) {
    _navigateTo(context,
        "${Routes.create_commnuity}?data=${FluroConvertUtils.object2string(data)}");
  }
  //修改资料
  static void goChange_account(BuildContext context){
    _navigateTo(context, Routes.change_account);
  }
  static void goChange_name(BuildContext context){
    _navigateTo(context, Routes.change_name);
  }
  static void goChange_introduction(BuildContext context){
    _navigateTo(context, Routes.change_introduction);
  }
  static void goChange_pwd(BuildContext context){
    _navigateTo(context, Routes.change_pwd);
  }
  //个人页面
  static void goPerson(BuildContext context){
    _navigateTo(context, Routes.person);
  }
  //最近播放
  static void goRecently_song(BuildContext context){
    _navigateTo(context, Routes.recently_song);
  }
  //我的收藏
  static void goCollection_song(BuildContext context){
    _navigateTo(context, Routes.collection_song);
  }
}


