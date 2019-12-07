import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
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

User _user = User.fromJson(json.decode(Application.sp.getString('user')));
class Change_IntroductionPage extends StatefulWidget{
  @override
  _Change_IntroductionPageState createState() => _Change_IntroductionPageState();
}

class _Change_IntroductionPageState extends State<Change_IntroductionPage> with AutomaticKeepAliveClientMixin{
  final TextEditingController _introduction = TextEditingController();
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("更改个人说明"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text('保存',
            ),
            onPressed: (){
              _introduction.text.isEmpty ?
              Utils.showToast('个人说明不能为空'):{
                ///数据
                ///
                ///
                ///
                ///
                ///
                // _user.account.userName = _name.text,
                Navigator.pop(context)
              };
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VEmptyView(30),
          TextField(
            controller: _introduction,
            decoration: InputDecoration(
              hintText: _user.account.introduction,
              // border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
