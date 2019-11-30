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

class Create_CommunityPage extends StatefulWidget{
  @override
  _Create_CommunityPageState createState() => _Create_CommunityPageState();
}
class _Create_CommunityPageState extends State<Create_CommunityPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  Map<String, String> topMenuData = {
    '所在位置': 'images/icon_song_more.png',
    '谁可以看': 'images/icon_song_more.png',
  };
  List<String> topMenuKeys;
  @override
  void initState() {

    super.initState();
    topMenuKeys = topMenuData.keys.toList();
  }
  Widget _buildMenu() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var curKey = topMenuKeys[index];
        var curValue = topMenuData[topMenuKeys[index]];
        return Container(
          height: ScreenUtil().setWidth(110),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
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
      itemCount: 2,
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.zero,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: new Text('取消',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),),
                    onPressed: () {},
                  ),
                  HEmptyView(230),
                  MaterialButton (
                    child: new Text('发送',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),),
                    onPressed: () {},
                  )
                ],
              ),
              VEmptyView(20),

                  TextField(
                    decoration: InputDecoration(
                      hintText: '随便聊一聊',
                      border: OutlineInputBorder(),
                    ),
                  ),
              VEmptyView(200),
              IconButton(icon: Icon(
                Icons.border_inner
              ),
                  iconSize: 50,
                  onPressed: (){}),
              VEmptyView(100),
              _buildMenu(),
                ],


              crossAxisAlignment: CrossAxisAlignment.start,
          ),
    )
    );
  }
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}