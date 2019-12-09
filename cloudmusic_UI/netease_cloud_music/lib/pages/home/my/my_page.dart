import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/play_list.dart' as prefix1;
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/recommend.dart' as prefix0;
import 'package:netease_cloud_music/pages/home/my/playlist_title.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/widget_create_play_list.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_menu.dart';
import 'package:provider/provider.dart';

import '../../../application.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  Map<String, String> topMenuData = {
    '最近播放': 'images/icon_late_play.png',
    '下载管理': 'images/icon_download_black.png',
    '我的收藏': 'images/icon_collect.png',
  };
  String userId =
      json.decode(Application.sp.getString('user'))['data']['user_id'];
  List<String> topMenuKeys;
  bool selfPlayListOffstage = false;
  bool collectPlayListOffstage = false;
  PlayListModel _playListModel;
  @override
  void initState() {
    super.initState();
    topMenuKeys = topMenuData.keys.toList();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      _playListModel = Provider.of<PlayListModel>(context);
      _playListModel.getSelfPlaylistData(context);
      _playListModel.getCollectionPlaylistData(context);
    });
  }

  Widget buildMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        Row(
          children: <Widget>[
            Image.asset("images/icon_late_play.png", width: 50, height: 50),
            MaterialButton(
              child: new Text(
                '最近播放',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              onPressed: () {
                NavigatorUtil.goRecently_song(context);
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        Row(
          children: <Widget>[
            Image.asset("images/icon_collect.png", width: 50, height: 50),
            MaterialButton(
              child: new Text(
                '我的收藏',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              onPressed: () {
                NavigatorUtil.goCollection_song(context);
              },
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 8.0,
          color: Color(0xFFF3F3F3),
        ),
      ],
    );
  }

  Widget _buildTopMenu() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curKey = topMenuKeys[index];
        var curValue = topMenuData[topMenuKeys[index]];
        return Container(
          height: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(140),
                child: Align(
                  child: Image.asset(
                    curValue,
                    width: ScreenUtil().setWidth(100),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  curKey,
                  style: commonTextStyle,
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
          height: ScreenUtil().setWidth(0.3),
        );
      },
      itemCount: 3,
    );
  }

  /// 构建「我创建的歌单」「收藏的歌单」
  Widget _buildPlayListItem(List<Playlist> data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var curPlayList = data[index];
          prefix0.Creator creator = new prefix0.Creator(
              userid: curPlayList.creator.userid,
              userName: curPlayList.creator.userName,
              userType: curPlayList.creator.userType,
              introduction: curPlayList.creator.introduction,
              avatarUrl: curPlayList.creator.avatarUrl);
          return ListTile(
            onTap: () {
              NavigatorUtil.goPlayListPage(context,
                  data: Recommend(
                    picUrl: curPlayList.picurl,
                    name: curPlayList.name,
                    playcount: curPlayList.playcount,
                    id: curPlayList.id,
                    creator: creator,
                    type: curPlayList.type,
                    iscollected: curPlayList.iscollected,
                  ));
            },
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
              child: Text(curPlayList.name),
            ),
            subtitle: Text(
              '${curPlayList.trackCount == null ? 0 : curPlayList.trackCount}首',
              style: smallGrayTextStyle,
            ),
            leading: RoundedNetImage(
              curPlayList.picurl,
              width: 110,
              height: 110,
              radius: ScreenUtil().setWidth(12),
            ),
            trailing: SizedBox(
              height: ScreenUtil().setWidth(50),
              width: ScreenUtil().setWidth(70),
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showModalBottomSheet<Playlist>(
                          context: context,
                          builder: (context) {
                            return PlayListMenuWidget(
                                curPlayList, _playListModel);
                          },
                          backgroundColor: Colors.transparent)
                      .then((v) {
                    if (v != null) {
                      // 1 为删除
                      if (v.type == 1) {
                        Utils.showToast('删除成功');
                        _playListModel.delPlayList(curPlayList.id);
                      }
                    }
                  });
                },
                padding: EdgeInsets.zero,
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  Widget _realBuildPlayList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PlaylistTitle("创建的歌单", _playListModel.selfCreatePlayList.length, () {
          setState(() {
            selfPlayListOffstage = !selfPlayListOffstage;
          });
        }, () {},
            trailing: SizedBox(
              height: ScreenUtil().setWidth(50),
              width: ScreenUtil().setWidth(70),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black87,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CreatePlayListWidget(
                          submitCallback: (name, isPrivate) {
                            _createPlaylist(name, isPrivate);
                          },
                        );
                      });
                },
                padding: EdgeInsets.zero,
              ),
            )),
        Offstage(
          offstage: selfPlayListOffstage,
          child: _buildPlayListItem(_playListModel.selfCreatePlayList),
        ),
        PlaylistTitle(
          "收藏的歌单",
          _playListModel.collectPlayList.length,
          () {
            setState(() {
              collectPlayListOffstage = !collectPlayListOffstage;
            });
          },
          () {},
        ),
        Offstage(
          offstage: collectPlayListOffstage,
          child: _buildPlayListItem(_playListModel.collectPlayList),
        ),
      ],
    );
  }

  /// 构建歌单
  Widget _buildPlayList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
      child: _realBuildPlayList(),
    );
  }

  /// 创建歌单
  void _createPlaylist(String name, bool isPrivate) async {
    NetUtils.createPlaylist(context,
        params: {'sheetname': name, 'user_id': userId}).catchError((e) {
      Utils.showToast('创建失败');
    }).then((result) {
      Utils.showToast('创建成功');
      Navigator.of(context).pop();
      _playListModel.addPlayList(result.playlist);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildMenu(),
            Container(
              height: ScreenUtil().setWidth(25),
            ),
            _playListModel == null
                ? Container(
                    height: ScreenUtil().setWidth(400),
                    alignment: Alignment.center,
                    child: CupertinoActivityIndicator(),
                  )
                : _buildPlayList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
