import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/search_result.dart';
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
import 'package:netease_cloud_music/widgets/widget_ovar_img.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_cover.dart';
import 'package:provider/provider.dart';

/// 综合搜索结果页
class SearchMultipleResultPage extends StatefulWidget {
  final String keywords;

  SearchMultipleResultPage(this.keywords);

  @override
  _SearchMultipleResultPageState createState() =>
      _SearchMultipleResultPageState();
}

class _SearchMultipleResultPageState extends State<SearchMultipleResultPage> {
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
        VEmptyView(20),
        ...contentWidget,
        moreText != null ? VEmptyView(10) : Container(),
        moreText != null ? _buildMoreText(moreText, onMoreTextTap) : Container(),
      ],
    );
  }

  // 构建单曲模块
  Widget _buildSearchSongs(Song song) {
    return Consumer<PlaySongsModel>(
      builder: (context, model, child) {
        return _buildModuleTemplate("单曲",
            contentWidget: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: song.songs
                    .map((song) => WidgetMusicListItem(MusicData(
                    songName: song.name,
                    mvid: song.mv,
                    artists:
                    song.ar.map((a) => a.name).toList().join('/'))))
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
            moreText: song.moreText,
            onMoreTextTap: () {});
      },
    );
  }

  // 构建歌单模块
  Widget _buildSearchPlayList(PlayList playList) {
    return _buildModuleTemplate('歌单',
        contentWidget: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: playList.playLists.map((p) {
              return Padding(
                padding:
                EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    RoundedNetImage(
                      p.coverImgUrl,
                      width: 140,
                      height: 140,
                      radius: 8,
                    ),
                    HEmptyView(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            p.name,
                            style: common14TextStyle,
                          ),
                          VEmptyView(10),
                          Text(
                            '${p.trackCount}首 by${p.creator.nickname}，播放${NumberUtils.formatNum(p.playCount)}次',
                            style: smallGrayTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        moreText: playList.moreText,
        onMoreTextTap: () {});
  }

  // 构建更多文字
  Widget _buildMoreText(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: common14GrayTextStyle,
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  // 构建相关搜索模块
  Widget _buildSimQuery(SimQuery sim) {
    return _buildModuleTemplate('相关搜索', contentWidget: [
      Wrap(
        spacing: ScreenUtil().setWidth(20),
        children: sim.sim_querys
            .map((v) => GestureDetector(
          onTap: () {},
          child: Chip(
            label: Text(
              v.keyword,
              style: common14TextStyle,
            ),
            backgroundColor: Color(0xFFf2f2f2),
          ),
        ))
            .toList(),
      ),
    ]);
  }

  Widget _buildSearchArtists(Artist artist) {
    return _buildModuleTemplate('歌手',
        contentWidget: [
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: artist.artists.map((a) {
              return Padding(
                padding:
                EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    OverImgWidget(
                      a.picUrl,
                      120,
                      fit: BoxFit.contain,
                    ),
                    HEmptyView(10),
                    Text(a.name),
                    Spacer(),
                    a.accountId == null || a.accountId == 0
                        ? Container()
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          color: Colors.red,
                          size: ScreenUtil().setWidth(30),
                        ),
                        HEmptyView(5),
                        Text(
                          '已入驻',
                          style: smallGrayTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        moreText: artist.moreText,
        onMoreTextTap: () {});
  }

  Widget _buildSearchAlbum(Album album){
    return _buildModuleTemplate('歌单',
        contentWidget: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: album.albums.map((p) {
              return Padding(
                padding:
                EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RoundedNetImage(
                          p.blurPicUrl,
                          width: 140,
                          height: 140,
                          radius: 8,
                        ),
                        Image.asset('images/icon_album.png', height: ScreenUtil().setWidth(140),)
                      ],
                    ),
                    HEmptyView(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            p.name,
                            style: common14TextStyle,
                          ),
                          VEmptyView(10),
                          Text(
                            '${p.artists.map((a) => a.name).toList().join('/')} ${DateUtil.formatDateMs(p.publishTime, format: "yyyy.MM.dd")}',
                            style: smallGrayTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        moreText: album.moreText,
        onMoreTextTap: () {});
  }

  Widget _buildSearchUser(User user){
    return _buildModuleTemplate('用户',
        contentWidget: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: user.users.map((p) {
              return Padding(
                padding:
                EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    OverImgWidget(
                      p.avatarUrl,
                      140,
                    ),
                    HEmptyView(10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            p.nickname,
                            style: common14TextStyle,
                          ),
                          VEmptyView(10),
                          Text(
                            '${p.description}',
                            style: smallGrayTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        moreText: user.moreText,
        onMoreTextTap: () {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<SearchMultipleData>(
      futureFunc: NetUtils.searchMultiple,
      params: {'keywords': widget.keywords, 'type': 1018},
      builder: (context, data) {
        return ListView(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(20),
              vertical: ScreenUtil().setWidth(20)),
          children: <Widget>[
            _buildSearchSongs(data.result.song),
            VEmptyView(20),
            _buildSearchPlayList(data.result.playList),
            VEmptyView(20),
            _buildSimQuery(data.result.sim_query),
            VEmptyView(20),
            _buildSearchArtists(data.result.artist),
            VEmptyView(20),
            _buildSearchAlbum(data.result.album),
            VEmptyView(20),
            _buildSearchUser(data.result.user),
          ],
        );
      },
    );
  }
}
