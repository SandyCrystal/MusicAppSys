import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/person/followed_page.dart';
import 'package:netease_cloud_music/pages/person/followed_page.dart';
import 'package:netease_cloud_music/pages/person/followed_page.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';

import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin {
  void initState() {
    super.initState();
  }

  User _user = User.fromJson(json.decode(Application.sp.getString('user')));
  Widget buildMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        MaterialButton(
          child: new Text(
            '编辑资料',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          onPressed: () {
            NavigatorUtil.goChange_account(context);
          },
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        MaterialButton(
          child: new Text(
            '修改密码',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          onPressed: () {
            NavigatorUtil.goChange_pwd(context);
          },
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        MaterialButton(
          child: new Text(
            '设置',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          onPressed: () {
            NavigatorUtil.goHomePage(context);
          },
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Color(0xFFF3F3F3),
        ),
        MaterialButton(
          child: new Text(
            '关于我们',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          onPressed: () {
            NavigatorUtil.goHomePage(context);
          },
        ),
        Container(
          width: double.infinity,
          height: 8.0,
          color: Color(0xFFF3F3F3),
        ),
      ],
    );
  }

  Widget _buildMiddleMessage() {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 10, right: 0, bottom: 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MaterialButton(
                child: new Text(
                  '动态',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  NavigatorUtil.goPerson(context);
                },
              ),
              HEmptyView(10),
              MaterialButton(
                child: new Text(
                  '关注',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  NavigatorUtil.goFollowed(context);
                },
              ),
              HEmptyView(10),
              MaterialButton(
                child: new Text(
                  '粉丝',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  NavigatorUtil.goFans(context);
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              HEmptyView(40),
              Text(_user.account.dynamicSize.toString()),
              HEmptyView(90),
              Text(_user.account.follow.toString()),
              HEmptyView(90),
              Text(_user.account.fans.toString()),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTopMessage() {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 0, right: 0, bottom: 0),
      child: Row(
        children: <Widget>[
          _user.account.avatarUrl == null
              ? Container()
              : Container(
                  width: ScreenUtil().setWidth(100),
                  height: ScreenUtil().setWidth(100),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Utils.showNetImage(_user.account.avatarUrl),
                    ],
                  ),
                ),
          HEmptyView(40),
          Column(
            children: <Widget>[
              Text(
                _user.account.userName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              VEmptyView(80),
              Text(
                'lv3',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildTopMessage(),
            VEmptyView(80),
            _buildMiddleMessage(),
            Container(
              color: Color(0xfff5f5f5),
              height: ScreenUtil().setWidth(40),
            ),
            buildMenu(),
            VEmptyView(200),
            Center(
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      '退出登录',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    color: Colors.black26,
                    textColor: Colors.white,
                    onPressed: () {
                      Application.sp.remove('user');
                      NavigatorUtil.goLoginPage(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
