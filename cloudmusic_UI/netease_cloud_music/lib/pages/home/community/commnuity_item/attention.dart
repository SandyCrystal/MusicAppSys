import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart';
import 'package:netease_cloud_music/model/community.dart';
import 'package:netease_cloud_music/model/user.dart' as prefix0;
import 'package:netease_cloud_music/widgets/common_text_style.dart';

import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_banner.dart';
import 'package:netease_cloud_music/widgets/widget_community.dart';
import 'package:netease_cloud_music/widgets/widget_community1.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application.dart';

class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage>
    with AutomaticKeepAliveClientMixin {
  prefix0.User _user =
      prefix0.User.fromJson(json.decode(Application.sp.getString('user')));
  @override
  Widget _buildRecommendPlayList() {
    return CustomFutureBuilder<ComDynamic>(
      futureFunc: NetUtils.getFollowedDynamicData,
      params: {
        "user_id": _user.account.userid,
      },
      builder: (context, snapshot) {
        var data = snapshot.comdynamics;
        return Container(
            height: ScreenUtil().setWidth(1100),
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return HEmptyView(ScreenUtil().setWidth(30));
              },
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
              itemBuilder: (context, index) {
                return WidgetCommnuity((CommunityData(
                  user: data[index].user,
                  dynamic_id: data[index].dynamicId,
                  like_count: data[index].likeCount,
                  content: data[index].content,
                  create_time: data[index].createTime,
                  pic_url: data[index].picUrl,
                  isliked: data[index].isliked,
                )));
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
                    '关注',
                    style: commonTextStyle,
                  ),
                  _buildRecommendPlayList(),
                ],
              ),
            ),
            VEmptyView(20)
          ],
        ),
      ),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
