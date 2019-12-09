
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/follow.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/widget_edit_play_list.dart';
import 'package:netease_cloud_music/model/user.dart' as prefix;

import '../application.dart';

class UserFollowedMenuWidget extends StatefulWidget {
  //final Playlist _playlist;
  // final PlayListModel _model;
  final User user;
  UserFollowedMenuWidget(this.user);
  //SongMenuWidget(this._playlist, this._model);

  @override
  _UserFollowedMenuWidgetState createState() => _UserFollowedMenuWidgetState();
}

class _UserFollowedMenuWidgetState extends State<UserFollowedMenuWidget> {


  prefix.User _user =
  prefix.User.fromJson(json.decode(Application.sp.getString('user')));


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
          //_buildMenuItem('images/icon_del.png', '取消关注', (){}),
          _buildMenuItem('images/icon_del.png', '删除', () async {
            NetUtils.unfollow(context, params: {'fromUserId': _user.account.userid,
              "toUserId": widget.user.userid})
                .then((v){
              if(v.code == 200) Navigator.pop(context, {_user.account.isfollowed=false,_user.account.follow--});
              else Utils.showToast('删除失败，请重试');
            });
          }),
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
