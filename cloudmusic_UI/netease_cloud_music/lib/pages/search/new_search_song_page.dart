import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/search_song.dart';
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

/// 综合搜索结果页
class NewSearchSongPage extends StatefulWidget {
  final String keywords;
  NewSearchSongPage(this.keywords);
  @override
  _NewSearchSongPageState createState() => _NewSearchSongPageState();
}

class _NewSearchSongPageState extends State<NewSearchSongPage> {
  // 构建模块基础模板
  Widget _buildModuleTemplate(String title,
      {@required List<Widget> contentWidget,
      Widget titleTrail,
      String moreText,
      VoidCallback onMoreTextTap}) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              title,
              style: bold18TextStyle,
            ),
            Spacer(),
            titleTrail ?? Container(),
          ],
        ),
      ],
    );
  }

  // 构建单曲模块
  Widget _buildSearchSongs(List<Songs> song) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        return _buildModuleTemplate("单曲",
            contentWidget: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: song
                    .map((song) => WidgetMusicListItem(MusicData(
                        mvid: 0,
                        picUrl: song.album.picUrl,
                        index: model.curIndex,
                        songName: song.name,
                        artists: song.artist)))
                    .toList(),
              ),
            ],
            titleTrail: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(15),
                  vertical: ScreenUtil().setWidth(5)),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff2f2f2)),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Row(
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
            ),
            moreText: "more",
            onMoreTextTap: () {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<SearchSongs>(
      futureFunc: NetUtils.searchMusic,
      params: {'keywords': widget.keywords},
      builder: (context, data) {
        return ListView(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setWidth(20)),
          children: <Widget>[
            _buildSearchSongs(data.songs),
            VEmptyView(20),
          ],
        );
      },
    );
  }
}
