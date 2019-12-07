import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/pages/home/account/account_page.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/widget_play.dart';
import 'community/community_page.dart';
import 'discover/discover_page.dart';
import 'my/my_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
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
                            text: '发现',
                          ),
                          Tab(
                            text: '我的',
                          ),
                          Tab(
                            text: '社区',
                          ),
                          Tab(
                            text: '账号',
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: ScreenUtil().setWidth(10),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: ScreenUtil().setWidth(50),
                          color: Colors.black87,
                        ),
                        onPressed: () { NavigatorUtil.gonewSearchPage(context);},
                      ),
                    ),
                  ],
                ),
                VEmptyView(20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DiscoverPage(),
                      MyPage(),
                      CommunityPage(),
                      AccountPage(),
                    ],
                  ),
                ),
              ],
            ),
//            PlayWidget(),
          ],
        ),
      ),
    );
  }
}
