import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/follow.dart';
import 'package:netease_cloud_music/model/com_dynamic.dart' as prefix0;
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_new_ima_menu.dart';
import 'package:netease_cloud_music/widgets/widget_song_menu.dart';

import '../application.dart';
import 'common_text_style.dart';
import 'h_empty_view.dart';
import 'widget_user_followed_menu.dart';
import 'package:netease_cloud_music/model/user.dart' as prefix;
class WidgetUserItem extends StatelessWidget {
  final User _data;
  final VoidCallback onTap;

  WidgetUserItem(this._data, {this.onTap});


  prefix.User _user =
  prefix.User.fromJson(json.decode(Application.sp.getString('user')));
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: Application.screenWidth,
        height: ScreenUtil().setWidth(120),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HEmptyView(15),
            //_data.picUrl == null
            //? Container()
            //:
            newImageMenuWidget(
                _data.avatarUrl //_data.user.account.avatarUrl
                ,
                50, onTap: () {
              NavigatorUtil.goOtherPerson(context,
                  data: prefix0.User.fromJson(_data.toJson()));
            }),
            /*_data.index == null
                ? Container()
                : Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setWidth(50),
              child: Text(
                _data.index.toString(),
                style: mGrayTextStyle,
              ),
            ),*/
            HEmptyView(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _data.userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: commonTextStyle,
                  ),
                  VEmptyView(10),
                  Text(
                    "" //_data.artists
                    ,
                    style: smallGrayTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child:
                    //判断是否关注
                    /*MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: new Text('已关注'),
                onPressed: () {},
              )，
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: new Text('+ 关注'),
                onPressed: () {},
              )，
              */
                    _data.isfollowed
                        ? MaterialButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: new Text('已关注'),
                            onPressed: () {
                              showModalBottomSheet<Playlist>(
                                  context: context,
                                  builder: (context) {
                                    return UserFollowedMenuWidget(_data);
                                  },
                                  backgroundColor: Colors.transparent);
                            },
                          )
                        : MaterialButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: new Text('+ 关注'),
                            onPressed: () {NetUtils.follow(context, params: {
                              "fromUserId": _user.account.userid,
                              "toUserId": _data.userid
                            }).then((v){
                              if(v.code == 200) Navigator.pop(context, {_user.account.isfollowed=true,_user.account.follow++});
                              else Utils.showToast('关注失败，请重试');
                            });
                            },
                    )),
            /*Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet<Playlist>(
                      context: context,
                      builder: (context) {
                        return SongMenuWidget();
                      },
                      backgroundColor: Colors.transparent);
                  /* .then((v) {
                  if (v != null) {
                    // 1 为删除
                    if(v.type == 1) {
                      Utils.showToast('删除成功');
                      _playListModel.delPlayList(curPlayList);
                    }
                  }
                });*/
                },
                color: Colors.grey,
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
