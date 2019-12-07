import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/model/community.dart';
import 'package:netease_cloud_music/model/music.dart';
import 'package:netease_cloud_music/model/play_list.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_community_menu.dart';

import '../application.dart';
import 'h_empty_view.dart';
import 'widget_new_ima_menu.dart';

class WidgetCommnuity extends StatelessWidget {
  final CommunityData _data;
  final VoidCallback onTap;
  User _user = User.fromJson(json.decode(Application.sp.getString('user')));

  WidgetCommnuity(this._data, {this.onTap});

  int count = 1; //标记是否点过赞
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: Application.screenWidth,
        //height: ScreenUtil().setWidth(120),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            newImageMenuWidget(_data.user.avatarUrl, 50, onTap: () {
              NavigatorUtil.goOtherPerson(context, data: _data.user);
            }),
            HEmptyView(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _data.user.nickname //_data.user.account.userName
                  ,
                  style: TextStyle(fontSize: 10, color: Colors.lightBlueAccent),
                ),
                Text(
                  _data.create_time,
                  style: TextStyle(fontSize: 8, color: Colors.black54),
                ),
                VEmptyView(10),
                _data.content == null
                    ? Container()
                    : Text(
                        _data.content,
                        // maxLines: 2,
                        softWrap: true,
                      ),
                _data.pic_url == null
                    ? Container()
                    : Image.network(
                        _data.pic_url,
                        width: 250,
                        height: 250,
                      ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.chat,
                        size: ScreenUtil().setWidth(30),
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        NavigatorUtil.goCommunityMessagePage(context);
                      },
                    ),
                    HEmptyView(10),
                    Text(_data.like_count.toString()),
                    HEmptyView(100),
                    _data.isliked
                        ? IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              size: ScreenUtil().setWidth(30),
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              NetUtils.dislike(context, params: {
                                'user_id': _user.account.userid,
                                'targetid': _data.dynamic_id,
                                'type': 1
                              })
                                  .then((m) => (Utils.showToast(m.data)))
                                  .catchError((m) => Utils.showToast("请求错误"));
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              size: ScreenUtil().setWidth(30),
                              color: Colors.red,
                            ),
                            onPressed: () {
                              NetUtils.like(context, params: {
                                'user_id': _user.account.userid,
                                'targetid': _data.dynamic_id,
                                'type': 1
                              })
                                  .then((m) => (Utils.showToast(m.data)))
                                  .catchError((m) => Utils.showToast("请求错误"));
                            },
                          ),
                    HEmptyView(10),
                    Text(_data.like_count.toString()),
                    IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          size: ScreenUtil().setWidth(30),
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          showModalBottomSheet<Playlist>(
                              context: context,
                              builder: (context) {
                                return CommunityMenuWidget(_data);
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
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
