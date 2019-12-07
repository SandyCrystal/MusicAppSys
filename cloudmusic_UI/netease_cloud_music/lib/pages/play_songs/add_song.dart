import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/deleted.dart';
import 'package:netease_cloud_music/model/get_details.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/comment/comment_type.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_button.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/model/album.dart';
import 'package:netease_cloud_music/model/banner.dart' as prefix0;
import 'package:netease_cloud_music/model/mv.dart';
import 'package:netease_cloud_music/model/recommend.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_banner.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class Add_songPage extends StatefulWidget{
  final String song;

  Add_songPage(this.song);
  @override
  _Add_songPageState createState() => _Add_songPageState();
}

class _Add_songPageState extends State<Add_songPage>{
  PlayListModel _playListModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((d){
      _playListModel = Provider.of<PlayListModel>(context);
      _playListModel.getSelfPlaylistData(context);
    });
  }

  Widget _buildPlayListItem(List<Playlist> data) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var curPlayList = data[index];
          return ListTile(
            onTap: () {
             NetUtils.addSong(context,params: {'sheetId':curPlayList.id,'songId':widget.song}).then((m)=>Utils.showToast(m.data));
             Navigator.pop(context);
            },
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(5)),
              child: Text(curPlayList.name),
            ),
            subtitle: Text(
              '${curPlayList.trackCount}首',
              style: smallGrayTextStyle,
            ),
            leading: RoundedNetImage(
              curPlayList.picurl,
              width: 110,
              height: 110,
              radius: ScreenUtil().setWidth(12),
            ),
          );
        },
        itemCount: data.length);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("添加到歌单"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){Navigator.pop(context);},
          ),
        ),
      body: Column(
          children: <Widget>[
            _playListModel==null ?
            Container(  height: ScreenUtil().setWidth(400),
              alignment: Alignment.center,
              child: CupertinoActivityIndicator()):
            _buildPlayListItem(_playListModel.selfCreatePlayList),
      ],
      ),
    );

  }

}