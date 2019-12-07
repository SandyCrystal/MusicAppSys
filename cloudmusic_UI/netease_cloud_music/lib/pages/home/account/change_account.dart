import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/user.dart';
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


class Change_AccountPage extends StatefulWidget{
  @override
  _Change_AccountPageState createState() => _Change_AccountPageState();
}

class _Change_AccountPageState extends State<Change_AccountPage> with AutomaticKeepAliveClientMixin{


  void initState() {
    super.initState();
  }

  Widget _buildMenu(){
      return Column(
        children: <Widget>[
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('昵称',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {NavigatorUtil.goChange_name(context);},
              ),
            ],
          ),
          Container(width: double.infinity, height: 4.0, color: Color(0xFFF3F3F3),),
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('个性说明',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {NavigatorUtil.goChange_introduction(context);},
              ),
            ],
          ),
          Container(width: double.infinity, height: 18.0, color: Color(0xFFF3F3F3),),
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('头像',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(width: double.infinity, height: 4.0, color: Color(0xFFF3F3F3),),
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('性别',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(width: double.infinity, height: 18.0, color: Color(0xFFF3F3F3),),
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('生日',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(width: double.infinity, height: 4.0, color: Color(0xFFF3F3F3),),
          Row(
            children: <Widget>[

              HEmptyView(10),
              new Text('个人说明',style: TextStyle(
                fontSize: 18,
              ),
              ),
              VEmptyView(100),
              new  IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenUtil().setWidth(50),
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      );
  }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("编辑资料"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),

      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMenu(),
          ],
      ),
    );
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}