import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart';
import 'package:netease_cloud_music/model/community.dart';
import 'package:netease_cloud_music/model/user.dart' as prefix;
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_community1.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';

import '../../application.dart';

class OtherPersonPage extends StatefulWidget {
  final User user;
  OtherPersonPage(this.user);
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<OtherPersonPage>
    with TickerProviderStateMixin {
  prefix.User _user =
      prefix.User.fromJson(json.decode(Application.sp.getString('user')));
  Widget _buildTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            HEmptyView(50),
            ClipOval(
              child: Image.network(
                widget.user.avatarUrl,
                width: 50,
                height: 50,
              ),
            ),
            new Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  HEmptyView(10),
                ],
              ),
            ),
            widget.user.isfollowed
                ? MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: new Text('取消关注'),
                    onPressed: () {},
                  )
                : MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: new Text('+ 关注'),
                    onPressed: () {},
                  )
          ],
        ),
        VEmptyView(20),
        Row(
          children: <Widget>[
            HEmptyView(150),
            new Text(
              widget.user.nickname,
              style: TextStyle(fontSize: 24, color: Colors.black54),
            ),
          ],
        ),
        VEmptyView(10),
        Row(
          children: <Widget>[
            HEmptyView(30),
            Text(
              '关注： ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              widget.user.follow.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              '|    粉丝： ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Text(
              widget.user.fans.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMenu() {
    return CustomFutureBuilder<ComDynamic>(
      futureFunc: NetUtils.getUserDynamic,
      params: {'user_id': widget.user.userId},
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '个人页面',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          VEmptyView(100),
          _buildTop(),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Color(0xFFF3F3F3),
          ),
          _buildMenu()
        ],
      ),
    );
  }
}
