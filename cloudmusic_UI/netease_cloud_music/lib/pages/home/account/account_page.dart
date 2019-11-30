import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
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

class AccountPage extends StatefulWidget{
  @override
  _AccountPageState createState() => _AccountPageState();
}
User _user = User.fromJson(json.decode(Application.sp.getString('user')));
class _AccountPageState extends State<AccountPage> with AutomaticKeepAliveClientMixin{
  Map<String, String> MenuData = {
    '编辑资料': 'images/icon_music.png',
    '我的消息': 'images/icon_late_play.png',
    '设置': 'images/icon_download_black.png',
    '关于': 'images/icon_broadcast.png',
  };
  List<String> MenuKeys;
  void initState(){
    super.initState();
    MenuKeys = MenuData.keys.toList();
  }
  Widget _buildMenu(){
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curKey = MenuKeys[index];
        var curValue = MenuData[MenuKeys[index]];
        return Container(
          height: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(140),
                child: Align(
                  child: Image.asset(
                    curValue,
                    width: ScreenUtil().setWidth(100),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  curKey,
                  style: commonTextStyle,
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          color: Colors.grey,
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
          height: ScreenUtil().setWidth(0.3),
        );
      },
      itemCount: 4,
    );
  }
  Widget _buildMiddleMessage(){
    return Container(
      padding: EdgeInsets.only(left: 40,top: 10,right: 0,bottom: 0),
      child: Column(
       children: <Widget>[
         Row(
           children: <Widget>[
             Text('动态'),
             HEmptyView(100),
             Text('关注'),
             HEmptyView(100),
             Text('粉丝'),
           ],
         ),
         Row(
           children: <Widget>[
             HEmptyView(10),
             Text('0'),
             HEmptyView(120),
             Text('0'),
             HEmptyView(110),
             Text('0'),
           ],
         )
       ],
      ),
    );
  }
  Widget _buildTopMessage(){
    return Container(

      padding: EdgeInsets.only(left: 40,top: 0,right: 0,bottom: 0),
      child: Row(
        children: <Widget>[
          _user.account.avatarUrl == null ? Container() :Container(
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
              Text(_user.account.userName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),),
              VEmptyView(80),
              Text('lv3',
              style: TextStyle(
                color: Colors.red
              ),),
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
            _buildMenu(),
            VEmptyView(200),
           Center(

             child:Column(

                 children: <Widget>[

                  RaisedButton(
                    child: Text('退出登录',
                    style: TextStyle(
                      fontSize: 30,
                    ),),
                    color: Colors.black26,
                    textColor: Colors.white,
                    onPressed: () { NavigatorUtil.goLoginPage(context);},
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