import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/AlbumList.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/play_list.dart' as prefix0;
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/song.dart';
import 'package:netease_cloud_music/pages/List/song_list_page.dart';
import 'package:netease_cloud_music/pages/album/album_detail.dart';
import 'package:netease_cloud_music/pages/album/album_page.dart';
import 'package:netease_cloud_music/pages/comment/comment_page.dart';
import 'package:netease_cloud_music/pages/daily_songs/daily_songs_page.dart';
import 'package:netease_cloud_music/pages/home/account/change_account.dart';
import 'package:netease_cloud_music/pages/home/account/change_account/change_introduction.dart';
import 'package:netease_cloud_music/pages/home/account/change_account/change_name.dart';
import 'package:netease_cloud_music/pages/home/account/change_account/change_pwd.dart';
import 'package:netease_cloud_music/pages/home/community/community_message.dart';
import 'package:netease_cloud_music/pages/home/community/create_community.dart';
import 'package:netease_cloud_music/pages/home/home_page.dart';
import 'package:netease_cloud_music/pages/home/my/Recently_song.dart';
import 'package:netease_cloud_music/pages/home/my/collection_song.dart';
import 'package:netease_cloud_music/pages/login_page.dart';
import 'package:netease_cloud_music/pages/person/fans_page.dart';
import 'package:netease_cloud_music/pages/person/followed_page.dart';
import 'package:netease_cloud_music/pages/person/other_person_page.dart';
import 'package:netease_cloud_music/pages/person/person_page.dart';
import 'package:netease_cloud_music/pages/play_list/play_list_page.dart';
import 'package:netease_cloud_music/pages/play_songs/add_song.dart';
import 'package:netease_cloud_music/pages/play_songs/play_songs_page.dart';
import 'package:netease_cloud_music/pages/register_page.dart';
import 'package:netease_cloud_music/pages/search/new_search_page.dart';
import 'package:netease_cloud_music/pages/splash_page.dart';
import 'package:netease_cloud_music/pages/top_list/top_list_page.dart';
import 'package:netease_cloud_music/utils/fluro_convert_utils.dart';
import 'package:netease_cloud_music/pages/search/search_page.dart';
import 'package:netease_cloud_music/widgets/widget_album_detail_cover.dart';
// splash 页面
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SplashPage();
    });

// 登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return LoginPage();
    });
// 注册页
var registerHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return RegisterPage();
    });
// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return HomePage();
    });

// 跳转到每日推荐歌曲
var dailySongsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return DailySongsPage();
    });

// 跳转到歌单
var playListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String data = params['data'].first;
      return PlayListPage(Recommend.fromJson(FluroConvertUtils.string2map(data)));
    });
var AlbumDetailsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String data = params['data'].first;
      return AlbumDetailsPage(Albums.fromJson(FluroConvertUtils.string2map(data)));
    });
///跳转到将歌曲添加到歌单
var addSongsHandler = new Handler(

    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String data = params['data'].first;
      return Add_songPage(data);
    });
// 跳转到每日推荐歌曲
var topListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return TopListPage();
    });

var communitymessageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return CommunityMessagePage();
    });
//跳转到其他人的页面
var otherpersonHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String data = params['data'].first;
      return OtherPersonPage(User.fromJson(FluroConvertUtils.string2map(data)));
    }
);
//跳转到关注页面
var followedHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return FollowedPage();
    }
);
//跳转到粉丝页面
var fansHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return FansPage();
    }
);
// 跳转到播放歌曲
var playSongsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PlaySongsPage();
    });

// 跳转到评论
var commentHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      String data = params['data'].first;
      return CommentPage(CommentHead.fromJson(FluroConvertUtils.string2map(data)));
    });
//跳转到动态详细

//跳转到搜索
var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SearchPage();
    });
//跳转到搜索
var newsearchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return NewSearchPage();
    });
//跳转到添加动态
var create_commnuityHandler = new Handler(
handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  String data = params['data'].first;
  return Create_CommunityPage(data);
}
);
//跳转到修改资料
var change_accountHandler =new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Change_AccountPage();
    }
);
var change_nameHandler =new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Change_NamePage();
    }
);
var change_introductionHandler =new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Change_IntroductionPage();
    }
);
var change_pwdHandler =new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Change_PwdPage();
    }
);

//跳转到个人界面
var personHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PersonPage();
    }
);
//跳转到最近播放
var recently_songHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Recently_song();
    }
);
//跳转到我的收藏
var collection_songHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Collection_song();
    }
);
//跳转到歌单广场
var list_song_pageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return Song_listPage();
    }
);

//跳转到专辑
var album_pageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return AlbumPage();
    }
);