import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/search_song.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/number_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_music_list_item.dart';
import 'package:provider/provider.dart';

import '../../application.dart';

/// 综合搜索结果页
class NewSearchSongPage extends StatefulWidget {
  final String keywords;
  NewSearchSongPage(this.keywords);
  @override
  _NewSearchSongPageState createState() => _NewSearchSongPageState();
}

class _NewSearchSongPageState extends State<NewSearchSongPage> {
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));
  // 构建单曲模块
  Widget _buildSearchSongs(List<Songs> song) {
    return Container(
      //height:ScreenUtil().setWidth(900),
      width: double.infinity,
      child: new Consumer<PlaySongsModel>(builder: (context, model, child) {
        return ListView(
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: song
              .map((song) => WidgetMusicListItem(MusicData(
                  mvid: 1,
                  picUrl: song.album.picUrl,
                  //index: model.curIndex,
                  songName: song.name,
                  artists: song.artist)))
              .toList(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<SearchSongs>(
      futureFunc: NetUtils.searchMusic,
      params: {'keywords': widget.keywords, 'user_id': _user.account.userid},
      builder: (context, data) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              VEmptyView(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.black87,
                  ),
                  HEmptyView(2),
                  Text(
                    '播放全部',
                    style: common14TextStyle,
                  ),
                ],
              ),
              VEmptyView(20),
              _buildSearchSongs(data.songs)
            ],
          ),
        );
      },
    );
  }
}
