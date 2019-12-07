import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/List/List_score/otherlist.dart';
import 'package:netease_cloud_music/pages/List/List_score/recommend.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Song_listPage extends StatefulWidget {
  @override
  _Song_listPageState createState() => _Song_listPageState();
}

class _Song_listPageState extends State<Song_listPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 8);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("歌单广场"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                        isScrollable: true,
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(fontSize: 14),
                        indicator: UnderlineTabIndicator(),
                        controller: _tabController,
                        tabs: [
                          Tab(
                            text: '推荐',
                          ),
                          Tab(
                            text: '官方',
                          ),
                          Tab(
                            text: '精品',
                          ),
                          Tab(
                            text: '华语',
                          ),
                          Tab(
                            text: '流行',
                          ),
                          Tab(
                            text: '民谣',
                          ),
                          Tab(
                            text: '电子',
                          ),
                          Tab(
                            text: '轻音乐',
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: ScreenUtil().setWidth(10),
                      child: IconButton(
                        icon: Icon(
                          Icons.games,
                          size: ScreenUtil().setWidth(50),
                          color: Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                VEmptyView(20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      RecommendPage(),
                      OtherlistPage(),
                      OtherlistPage(),
                      OtherlistPage(),
                      OtherlistPage(),
                      OtherlistPage(),
                      OtherlistPage(),
                      OtherlistPage(),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
