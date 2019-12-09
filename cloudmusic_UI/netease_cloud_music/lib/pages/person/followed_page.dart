import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/follow.dart';

import 'package:netease_cloud_music/model/user.dart' as prefix;
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';

import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';

import 'package:netease_cloud_music/widgets/widget_user_item.dart';

import '../../application.dart';

class FollowedPage extends StatefulWidget {
  @override
  _FollowedPageState createState() => _FollowedPageState();
}

class _FollowedPageState extends State<FollowedPage> {
  Widget _buildRecommendPlayList() {
    prefix.User _user =
        prefix.User.fromJson(json.decode(Application.sp.getString('user')));
    return CustomFutureBuilder<FollowData>(
      futureFunc: NetUtils.getFollowed,
      params: {'fromUserId': _user.account.userid},
      builder: (context, snapshot) {
        var data = snapshot.users;
        return Container(
            height: ScreenUtil().setWidth(1300),
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return HEmptyView(ScreenUtil().setWidth(30));
              },
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(15)),
              itemBuilder: (context, index) {
                return WidgetUserItem((User(
                    userid: data[index].userid,
                    userName: data[index].userName,
                    userType: data[index].userType,
                    isfollowed: data[index].isfollowed,
                    introduction: data[index].introduction,
                    fans: data[index].fans,
                    follow: data[index].follow,
                    avatarUrl: data[index].avatarUrl,
                    createTime: data[index].createTime)));
              },
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.total,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '关注',
          style: TextStyle(
            fontSize: 20,
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
          Container(
            width: double.infinity,
            height: 8.0,
            color: Color(0xFFF3F3F3),
          ),
          Text(
            '全部关注',
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Color(0xFFF3F3F3),
          ),
          _buildRecommendPlayList()
        ],
      ),
    );

    return null;
  }
}
