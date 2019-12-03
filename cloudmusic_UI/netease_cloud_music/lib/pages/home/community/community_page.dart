import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/attention.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/dynamic.dart';
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



class CommunityPage extends StatefulWidget{
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;
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
                    Positioned(
                      left: ScreenUtil().setWidth(10),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: ScreenUtil().setWidth(50),
                          color: Colors.black87,
                        ),
                        onPressed: () {NavigatorUtil.goCreate_commnuityPage(context);},
                      ),
                    ),

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
        onPressed: () {NavigatorUtil.goCreate_commnuityPage(context);},
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