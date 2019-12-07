import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/attention.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/dynamic.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../application.dart';


class CommunityPage extends StatefulWidget{
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;
  var userId=json.decode(Application.sp.getString('user'));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置没有高度的 appbar，目的是为了设置状态栏的颜色
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
        ),
        preferredSize: Size.zero,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(50)),
                      child: TabBar(
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                        indicator: UnderlineTabIndicator(),
                        controller: _tabController,
                        tabs: [
                          Tab(
                            text: '动态',
                          ),
                          Tab(
                            text: '关注',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                VEmptyView(20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DynamicPage(),
                      AttentionPage(),
                    ],
                  ),
                ),
              ],
            ),
//            PlayWidget(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {NavigatorUtil.goCreate_commnuityPage(context,data: userId["data"]["user_id"]);},
        child: new Icon(Icons.add_a_photo),
        elevation: 3.0,
        highlightElevation: 2.0,
        backgroundColor: Colors.red,
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}