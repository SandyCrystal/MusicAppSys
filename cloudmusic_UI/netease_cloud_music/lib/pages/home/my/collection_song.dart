import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/daily_songs.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/song.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_music_list_item.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_app_bar.dart';
import 'package:netease_cloud_music/widgets/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';

class Collection_song extends StatefulWidget{
  @override
  _Collection_songPageState createState() => _Collection_songPageState();
}

class _Collection_songPageState extends State<Collection_song> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  double _expandedHeight = ScreenUtil().setWidth(340);
  int _count;
  DailySongsData data;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          PlayListAppBarWidget(
            backgroundImg: 'images/bg_daily.png',
            count: _count,
            playOnTap: (model) {
              playSongs(model, 0);
            },
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
              ],
            ),
            expandedHeight: _expandedHeight,
            title: '我的收藏',
          ),
          CustomSliverFutureBuilder<DailySongsData>(
            futureFunc: NetUtils.getDailySongsData,
            builder: (context, data) {
              setCount(data.recommend.length);
              return Consumer<PlaySongsModel>(
                builder: (context, model, child) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        this.data = data;
                        var d = data.recommend[index];
                        return WidgetMusicListItem(
                          MusicData(
                              mvid: d.mvid,
                              picUrl: d.album.picUrl,
                              songName: d.name,
                              artists:
                              "${d.artists} - ${d.album.name}"),
                          onTap: () {
                            playSongs(model, index);
                          },
                        );
                      },
                      childCount: data.recommend.length,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  void playSongs(PlaySongsModel model, int index) {
    model.playSongs(
      data.recommend
          .map((r) => Song(
        r.id,
        name: r.name,
        picUrl: r.album.picUrl,
        artists: '${r.artists}',
      ))
          .toList(),
      index: index,
    );
    NavigatorUtil.goPlaySongsPage(context);
  }

  void setCount(int count) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _count = count;
        });
      }
    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
