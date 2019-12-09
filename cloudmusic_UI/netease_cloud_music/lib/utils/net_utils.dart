import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netease_cloud_music/model/AlbumList.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/banner.dart' as mBanner;
import 'package:netease_cloud_music/model/com_dynamic.dart' as prefix1;
import 'package:netease_cloud_music/model/daily_songs.dart';
import 'package:netease_cloud_music/model/deleted.dart';
import 'package:netease_cloud_music/model/follow.dart' as prefix2;
import 'package:netease_cloud_music/model/get_details.dart';
import 'package:netease_cloud_music/model/hot_search.dart';
import 'package:netease_cloud_music/model/lyric.dart';
import 'package:netease_cloud_music/model/mv.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/search_result.dart' hide User;
import 'package:netease_cloud_music/model/search_song.dart';
import 'package:netease_cloud_music/model/song_comment.dart' hide User;
import 'package:netease_cloud_music/model/song_comment.dart' as prefix0;
import 'package:netease_cloud_music/model/song_detail.dart';
import 'package:netease_cloud_music/model/top_list.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/comment/comment_type.dart';
import 'package:netease_cloud_music/route/navigate_service.dart';
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/loading.dart';
import 'package:path_provider/path_provider.dart';

import '../application.dart';
import 'custom_log_interceptor.dart';

class NetUtils {
  static Dio _dio;
  static final String baseUrl = 'http://127.0.0.1';

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio(BaseOptions(baseUrl: '$baseUrl:8080', followRedirects: false))
      ..interceptors.add(CookieManager(cj))
      ..interceptors
          .add(CustomLogInterceptor(responseBody: true, requestBody: true));
  }

  static Future<Response> _get(
    BuildContext context,
    String url, {
    Map<String, dynamic> params,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) Loading.showLoading(context);
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
          _reLogin();
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static void _reLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      Application.getIt<NavigateService>().popAndPushNamed(Routes.login);
      Utils.showToast('登录失效，请重新登录');
    });
  }

  /// 登录
  static Future<User> login(
      BuildContext context, String phone, String password) async {
    var response = await _get(context, '/api/login', params: {
      'username': phone,
      'pwd': password,
    });

    return User.fromJson(response.data);
  }

  ///注册
  static Future<User> register(
      BuildContext context, String username, String pwd1, String pwd2) async {
    var response = await _get(context, '/api/register', params: {
      'userName': username,
      'pwd1': pwd1,
      'pwd2': pwd2,
    });
    return User.fromJson(response.data);
  }

  ///修改密码
  static Future<User> change_pwd(BuildContext context, String username,
      String pwdOld, String pwdNew) async {
    var response = await _get(context, '/api/modifyPwd', params: {
      'username': username,
      'pwd1': pwdOld,
      'pwd2': pwdNew,
    });
    return User.fromJson(response.data);
  }

  static Future<Response> refreshLogin(BuildContext context) async {
    return await _get(context, '/login/refresh', isShowLoading: false)
        .catchError((e) {
      Utils.showToast('网络错误！');
    });
  }

  /// 首页 Banner
  static Future<mBanner.Banner> getBannerData(BuildContext context) async {
    var response = await _get(context, '/api/banner');
    return mBanner.Banner.fromJson(response.data);
  }

  /// 推荐歌单
  static Future<RecommendData> getRecommendData(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/recommandSheet', params: params);
    return RecommendData.fromJson(response.data);
  }

  ///获取专辑列表
  static Future<AlbumData> getAlbumData(BuildContext context) async {
    var response = await _get(context, '/api/getAlbumList');
    return AlbumData.fromJson(response.data);
  }

  /// 加入歌曲到歌单

  /// MV 排行
  static Future<MVData> getTopMvData(
    BuildContext context, {
    Map<String, dynamic> params = const {
      'offset': 1,
      'limit': 10,
    },
  }) async {
    var response = await _get(context, '/top/mv', params: params);
    return MVData.fromJson(response.data);
  }

  /// 每日推荐歌曲
  static Future<DailySongsData> getDailySongsData(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/recommandSong', params: params);
    return DailySongsData.fromJson(response.data);
  }

  static Future<DailySongsData> getCollectionSong(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response =
        await _get(context, '/api/getCollectionSong', params: params);
    return DailySongsData.fromJson(response.data);
  }

  /// 歌单详情
  static Future<PlayListData> getPlayListData(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getSheetDetails', params: params);
    return PlayListData.fromJson(response.data);
  }

  static Future<AlbumListData> getAlbumDetails(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getAlbumDetails', params: params);
    return AlbumListData.fromJson(response.data);
  }

  /// 歌曲详情
  static Future<SongDetailData> getSongsDetailData(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/song/detail', params: params);
    return SongDetailData.fromJson(response.data);
  }

  static Future<GetData> collection(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/collection', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> follow(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/followUser', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> unfollow(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/unfollowUser', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> uncollection(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/uncollection', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> like(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/like', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> dislike(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/dislike', params: params);
    return GetData.fromJson(response.data);
  }

  static Future<prefix2.FollowData> getFollowed(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getFollowed', params: params);
    return prefix2.FollowData.fromJson(response.data);
  }

  static Future<prefix2.FollowData> getFans(
    BuildContext context, {
    Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getFans', params: params);
    return prefix2.FollowData.fromJson(response.data);
  }

  /// 排行榜首页
  static Future<TopListData> getTopListData(BuildContext context) async {
    var response = await _get(context, '/toplist/detail');
    return TopListData.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<SongCommentData> getSongCommentData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getMusicComment',
        params: params, isShowLoading: false);
    return SongCommentData.fromJson(response.data);
  }

  /// 获取动态列表
  static Future<prefix1.ComDynamic> getDynamicData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getDynamicData',
        params: params, isShowLoading: false);
    return prefix1.ComDynamic.fromJson(response.data);
  }

  /// 获取动态列表
  static Future<prefix1.ComDynamic> getFollowedDynamicData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getDynamicData',
        params: params, isShowLoading: false);
    return prefix1.ComDynamic.fromJson(response.data);
  }

  ///获取用户动态
  static Future<prefix1.ComDynamic> getUserDynamic(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getPersonalDynamic',
        params: params, isShowLoading: false);
    return prefix1.ComDynamic.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<SongCommentData> getCommentData(
    BuildContext context,
    int type, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getMusicComment',
        params: params, isShowLoading: false);
    return SongCommentData.fromJson(response.data);
  }

  /// 获取评论列表
  static Future<Comment2> sendComment(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/makeSongComment',
        params: params, isShowLoading: true);
    return Comment2.fromJson(response.data);
  }

  static Future<prefix1.ComDynamic> sendDynamic(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var res = await _get(context, '/api/uploadPic',
        params: {'filepath': params['picUrl']});
    params['picUrl'] = res.data['data'];
    var response = await _get(context, '/api/createDynamic',
        params: params, isShowLoading: true);
    return prefix1.ComDynamic.fromJson(response.data);
  }

  static Future<GetData> updatePic(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/uploadPic',
        params: params, isShowLoading: true);
    return GetData.fromJson(response.data);
  }

  static Future<GetData> deleteDynamic(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/deleteDynamic',
        params: params, isShowLoading: true);
    return GetData.fromJson(response.data);
  }

  /// 获取歌词
  static Future<LyricData> getLyricData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var dioa = new Dio();
    var response = await dioa.get('http://music.163.com/api/song/media',
        queryParameters: params);
    var data = response.data;
    data = json.decode(data);
    return LyricData.fromJson(data);
  }

  /// 获取个人歌单
  static Future<MyPlayListData> getSelfPlaylistData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getPersonalSheet',
        params: params, isShowLoading: false);
    return MyPlayListData.fromJson(response.data);
  }

  static Future<MyPlayListData> getCollectionPlaylistData(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/getCollectionSheet',
        params: params, isShowLoading: false);
    return MyPlayListData.fromJson(response.data);
  }

  /// 创建歌单
  static Future<PlayListData> createPlaylist(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/createSheet',
        params: params, isShowLoading: true);
    return PlayListData.fromJson(response.data);
  }

  /// 删除歌单
  static Future<Deleted> deletePlaylist(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/deleteSheet',
        params: params, isShowLoading: true);
    return Deleted.fromJson(response.data);
  }

  static Future<GetData> addSong(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/addSong',
        params: params, isShowLoading: true);
    return GetData.fromJson(response.data);
  }

  static Future<HotSearchData> getHotSearchData(BuildContext context) async {
    var response =
        await _get(context, '/search/hot/detail', isShowLoading: false);
    return HotSearchData.fromJson(response.data);
  }

  static Future<SearchMultipleData> searchMultiple(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response =
        await _get(context, '/search', params: params, isShowLoading: true);
    return SearchMultipleData.fromJson(response.data);
  }

  static Future<SearchSongs> searchMusic(
    BuildContext context, {
    @required Map<String, dynamic> params,
  }) async {
    var response = await _get(context, '/api/searchSong',
        params: params, isShowLoading: true);
    return SearchSongs.fromJson(response.data);
  }
}
