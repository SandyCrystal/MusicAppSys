
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart';
import 'package:netease_cloud_music/model/community.dart';
import 'package:netease_cloud_music/model/get_details.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/widget_edit_play_list.dart';

import '../application.dart';

class CommunityMenuWidget extends StatefulWidget {
  //final Playlist _playlist;
  final CommunityData data;
  // final PlayListModel _model;
  CommunityMenuWidget(this.data);
  //SongMenuWidget(this._playlist, this._model);
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));

  @override
  _CommunityMenuWidgetState createState() => _CommunityMenuWidgetState();
}

class _CommunityMenuWidgetState extends State<CommunityMenuWidget> {
  Widget _buildMenuItem(String img, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: ScreenUtil().setWidth(110),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(140),
              child: Align(
                child: Image.asset(
                  img,
                  width: ScreenUtil().setWidth(80),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: common14TextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenUtil().setWidth(40)),
              topRight: Radius.circular(ScreenUtil().setWidth(40))),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Offstage(
            offstage: widget._user.userId==widget.data.user.userId,//widget._playlist.creator.userid != widget._model.user.account.userid,  ///判断是否属于我的动态
            child: _buildMenuItem('images/icon_del.png', '删除',()async{
              NetUtils.deleteDynamic(context,params:{"dynamicId":widget.data.dynamic_id}).then((m)=>(Utils.showToast(m.data)));
              Navigator.pop(context, "");
            }),
          ),
          /*_buildMenuItem('images/icon_del.png', '删除', () async {
            NetUtils.deletePlaylist(context, params: {'id': widget._playlist.id}).then((v){
              if(v.code == 200) Navigator.pop(context, widget._playlist..type = 1);
              else Utils.showToast('删除失败，请重试');
            });
          }),*/
          Container(
            color: Colors.grey,
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
            height: ScreenUtil().setWidth(0.3),
          ),
        ],
      ),
    );
  }
}
