import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/AlbumList.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/model/song.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/album/album_details_Descdialog.dart';
import 'package:netease_cloud_music/pages/comment/comment_type.dart';
import 'package:netease_cloud_music/pages/play_list/play_list_desc_dialog.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_album_detail_cover.dart';
import 'package:netease_cloud_music/widgets/widget_footer_tab.dart';
import 'package:netease_cloud_music/widgets/widget_music_list_item.dart';
import 'package:netease_cloud_music/widgets/widget_ovar_img.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_app_bar.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_cover.dart';
import 'package:netease_cloud_music/widgets/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';

import '../../application.dart';

class AlbumDetailsPage extends StatefulWidget {
  final Albums data;

  AlbumDetailsPage(this.data);

  @override
  _AlbumDetailsPagePageState createState() => _AlbumDetailsPagePageState();
}

class _AlbumDetailsPagePageState extends State<AlbumDetailsPage> {
  double _expandedHeight = ScreenUtil().setWidth(630);
  AlbumList _data;
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));

  /// 构建歌单简介
  Widget buildDescription() {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return AlbumDetailsDescDialog(_data);
          },
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150),
          transitionBuilder: _buildMaterialDialogTransitions,
        );
      },
      child: _data != null
          ? Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '',
                    style: smallWhite70TextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white70,
                ),
              ],
            )
          : Container(),
    );
  }

  var count = 1; //标记是否已经收藏该歌单
  var pic = 'images/icon_dislike.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          PlayListAppBarWidget(
            sigma: 20,
            playOnTap: (model) {
              playSongs(model, 0);
            },
            content: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(35),
                  right: ScreenUtil().setWidth(35),
                  top: ScreenUtil().setWidth(120),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AlbumDetailCoverWidget(
                          widget.data.picUrl,
                          width: 250,
                          playCount: null,
                        ),
                        HEmptyView(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                widget.data.name,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: mWhiteBoldTextStyle,
                              ),
                              VEmptyView(10),
                              Row(
                                children: <Widget>[
                                  _data == null
                                      ? Container()
                                      : OverImgWidget(
                                          _data.artist.avatarUrl, 40),
                                  HEmptyView(5),
                                  Expanded(
                                    child: _data == null
                                        ? Container()
                                        : Text(
                                            _data.artist.artistName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: commonWhite70TextStyle,
                                          ),
                                  ),
                                  _data == null
                                      ? Container()
                                      : Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.white70,
                                        ),
                                ],
                              ),
                              VEmptyView(10),
                              buildDescription(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VEmptyView(15),
                  ],
                ),
              ),
            ),
            expandedHeight: _expandedHeight,
            backgroundImg: widget.data.picUrl,
            title: widget.data.name,
            count: _data == null ? null : _data.tracks.length,
          ),
          CustomSliverFutureBuilder<AlbumListData>(
            futureFunc: NetUtils.getAlbumDetails,
            params: {
              'album_id': widget.data.id,
              'user_id': _user.account.userid
            },
            builder: (context, data) {
              setData(data.albumList);
              return Consumer<PlaySongsModel>(builder: (context, model, child) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  var d = data.albumList.tracks[index];
                  return WidgetMusicListItem(
                    MusicData(
                        index: index + 1,
                        songName: d.name,
                        artists: '${d.artist} - ${d.album.name}',
                        iscollected: d.iscollected),
                    onTap: () {
                      playSongs(model, index);
                    },
                  );
                }, childCount: data.albumList.tracks.length));
              });
            },
          ),
        ],
      ),
    );
  }

  void playSongs(PlaySongsModel model, int index) {
    model.playSongs(
      _data.tracks
          .map((r) => Song(r.id,
              name: r.name,
              picUrl: r.album.picUrl,
              artists: '${r.artist}',
              iscollected: r.iscollected))
          .toList(),
      index: index,
    );
    NavigatorUtil.goPlaySongsPage(context);
  }

  void setData(AlbumList data) {
    Future.delayed(Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _data = data;
        });
      }
    });
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
