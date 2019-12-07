import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/login_page.dart';
import 'package:netease_cloud_music/route/route_handles.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String resigter= "resigter";
  static String dailySongs = "/daily_songs";
  static String playList = "/play_list";
  static String topList = "/top_list";
  static String playSongs = "/play_songs ";
  static String comment = "/comment";
  static String commnuitymessage="/commnuitymessage";
  static String search = "/search";
  static String newsearch = "/newsearch";
  static String create_commnuity="/create_commnuity";
  static String change_account="/change_account";
  static String change_name="/change_name";
  static String change_introduction="/change_introduction";
  static String change_pwd="/change_pwd";
  static String person="/person";
  static String addSongs = "/add_songs ";
  static String otherperson="/otherperson";
  static String recently_song="/recently_song";
  static String collection_song="/collection_song";
  static String list_song="/list_song";
  static String album = "/album";
  static String albumDetails = "/albumDetails";
  static String followed = "/followed";
  static String fans="/fans";
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return LoginPage();
    });
    router.define(root, handler: splashHandler);
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
    router.define(dailySongs, handler: dailySongsHandler);
    router.define(playList, handler: playListHandler);
    router.define(albumDetails, handler: AlbumDetailsHandler);
    router.define(topList, handler: topListHandler);
    router.define(playSongs, handler: playSongsHandler);
    router.define(comment, handler: commentHandler);
    router.define(search, handler: searchHandler);
    router.define(addSongs, handler: addSongsHandler);
    router.define(newsearch, handler: newsearchHandler);
    router.define(create_commnuity, handler: create_commnuityHandler);
    router.define(change_account, handler: change_accountHandler);
    router.define(change_name, handler: change_nameHandler);
    router.define(change_introduction, handler: change_introductionHandler);
    router.define(change_pwd, handler: change_pwdHandler);
    router.define(person, handler:personHandler);
    router.define(recently_song, handler: recently_songHandler);
    router.define(collection_song, handler: collection_songHandler);
    router.define(list_song, handler: list_song_pageHandler);
    router.define(album, handler: album_pageHandler);
    router.define(otherperson, handler:otherpersonHandler);
    router.define(commnuitymessage, handler: communitymessageHandler);
    router.define(resigter, handler: registerHandler);
    router.define(followed, handler: followedHandler);
    router.define(fans, handler: fansHandler);
  }
}
