import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/banner.dart' as prefix0;
import 'package:netease_cloud_music/model/mv.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_banner.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _HomePrePageState createState() => _HomePrePageState();
}

class _HomePrePageState extends State<DiscoverPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));

  /// 构建轮播图
  Widget _buildBanner() {
    return CustomFutureBuilder<prefix0.Banner>(
      futureFunc: NetUtils.getBannerData,
      builder: (context, data) {
        return CustomBanner(data.banners.map((e) => e.pic).toList());
      },
    );
  }

  /// 构建分类列表
  Widget _buildHomeCategoryList() {
    var map = {
      '每日推荐': 'images/icon_daily.png',
      '歌单': 'images/icon_playlist.png',
      '专辑': 'images/icon_rank.png',
    };

    var keys = map.keys.toList();
    var width = ScreenUtil().setWidth(100);

    return GridView.custom(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: keys.length,
        childAspectRatio: 1 / 1.1,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              switch (index) {
                case 0:
                  NavigatorUtil.goDailySongsPage(context);
                  break;
                case 1:
                  NavigatorUtil.goListSongPage(context);
                  break;
                case 2:
                  NavigatorUtil.goAlbumPage(context);
                  break;
              }
            },
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width / 2),
                          border: Border.all(color: Colors.black12, width: 0.5),
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFFFF8174),
                              Colors.blue,
                            ],
                            center: Alignment(-1.7, 0),
                            radius: 1,
                          ),
                          color: Colors.blue),
                    ),
                    Image.asset(
                      map[keys[index]],
                      width: width,
                      height: width,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3),
                      child: keys[index] == '每日推荐'
                          ? Text(
                              '${DateUtil.formatDate(DateTime.now(), format: 'dd')}',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(''),
                    )
                  ],
                ),
                VEmptyView(10),
                Text(
                  '${keys[index]}',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          );
        },
        childCount: keys.length,
      ),
    );
  }

  /// 构建推荐歌单
  Widget _buildRecommendPlayList() {
    return CustomFutureBuilder<RecommendData>(
      futureFunc: NetUtils.getRecommendData,
      params: {'user_id': _user.account.userid},
      builder: (context, snapshot) {
        var data = snapshot.recommend;
        print(data[0].name);
        return Container(
            height: ScreenUtil().setWidth(600),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                //childAspectRatio: 50,
              ),
              itemBuilder: (context, index) {
                return PlayListWidget(
                  text: data[index].name,
                  picUrl: data[index].picUrl,
                  playCount: data[index].playcount,
                  maxLines: 1,
                  onTap: () {
                    NavigatorUtil.goPlayListPage(context, data: data[index]);
                  },
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBanner(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  VEmptyView(40),
                  _buildHomeCategoryList(),
                  VEmptyView(20),
                  Text(
                    '推荐歌单',
                    style: commonTextStyle,
                  ),
                ],
              ),
            ),
            VEmptyView(20),
            _buildRecommendPlayList(),
            //VEmptyView(30),
            //Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: ScreenUtil().setWidth(15),
            //   ),
            //   child: Text(
            //     '新碟上架',
            //     style: commonTextStyle,
            //   ),
            //  ),
            //  VEmptyView(20),
            //_buildNewAlbum(),
            //VEmptyView(30),
            // Padding(
            //padding: EdgeInsets.symmetric(
            //   horizontal: ScreenUtil().setWidth(15),
            //  ),
            //  child: Text(
            //    'MV 排行',
            //    style: commonTextStyle,
            //  ),
            // ),
            // VEmptyView(20),
            //_buildTopMv(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
