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

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 构建轮播图
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));
  Widget _buildBanner() {
    return CustomFutureBuilder<prefix0.Banner>(
      futureFunc: NetUtils.getBannerData,
      builder: (context, data) {
        return CustomBanner(data.banners.map((e) => e.pic).toList());
      },
    );
  }

  Widget _buildRecommendPlayList() {
    return CustomFutureBuilder<RecommendData>(
      futureFunc: NetUtils.getRecommendData,
      params: {'userid': _user.account.userid},
      builder: (context, snapshot) {
        var data = snapshot.recommend;
        return Container(
            height: ScreenUtil().setWidth(900),
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
                  iscollected: data[index].iscollected,
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
                  VEmptyView(20),
                  Text(
                    '推荐歌单',
                    style: commonTextStyle,
                  ),
                  _buildRecommendPlayList(),
                ],
              ),
            ),
            VEmptyView(20),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
