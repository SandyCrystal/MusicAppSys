
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/widget_edit_play_list.dart';

class SongMenuWidget extends StatefulWidget {
  //final Playlist _playlist;
  // final PlayListModel _model;

  //SongMenuWidget(this._playlist, this._model);

  @override
  _SongMenuWidgetState createState() => _SongMenuWidgetState();
}

class _SongMenuWidgetState extends State<SongMenuWidget> {
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
            offstage: false,//widget._playlist.creator.userid != widget._model.user.account.userid,  ///判断是否存在于我的收藏中
            child: _buildMenuItem('images/icon_liked.png', '我的收藏',(){}),
          ),
          Offstage(
            offstage: false,//offstage: widget._playlist.creator.userid != widget._model.user.account.userid,判断是否存在于我的收藏中
            child: Container(
              color: Colors.grey,
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(140)),
              height: ScreenUtil().setWidth(0.3),
            ),
          ),
          Offstage(
            offstage: false,//offstage: widget._playlist.creator.userid != widget._model.user.account.userid,  ///判断是否存在于我的歌单或者我的收藏中
            child: _buildMenuItem('images/icon_del.png', '删除',(){}),

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
