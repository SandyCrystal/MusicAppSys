import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netease_cloud_music/model/comment_head.dart';
import 'package:netease_cloud_music/model/song_comment.dart';
import 'package:netease_cloud_music/pages/comment/comment_type.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:netease_cloud_music/utils/number_utils.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/rounded_net_image.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:netease_cloud_music/widgets/widget_load_footer.dart';
import 'package:netease_cloud_music/widgets/widget_ovar_img.dart';
import 'package:netease_cloud_music/application.dart';

import 'CommunityInputWidget.dart';
class CommunityMessagePage extends StatefulWidget {
 // final CommunityHead communityHead;

  //CommunityMessagePage(this.communityHead);
  @override
  _CommunityMessagePageState createState() => _CommunityMessagePageState();
}
class _CommunityMessagePageState extends State<CommunityMessagePage> {
  Map<String, dynamic> params;
  List<Comments> commentData = [];
  EasyRefreshController _controller;
  FocusNode _blankNode = FocusNode();
  String userId = json.decode(Application.sp.getString('user'))['data']['userId'];
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    /*WidgetsBinding.instance.addPostFrameCallback((d) {
     params = {'id': widget.communityHead.id};
    _request();
    });*/
  }
  /*void _request() async {
    var r = await NetUtils.getCommunityData(context, params: params);
    setState(() {
      if (commentData.where((d) => d.title == "最新评论").isEmpty) {
        commentData.add(Comments(isTitle: true, title: "最新评论"));
      }
      commentData.addAll(r.comments);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          //title: Text('评论(${widget.communityHead.count})'),
        ),
        body: Stack(
          children: <Widget>[
            Listener(
              onPointerDown: (d){
                FocusScope.of(context).requestFocus(_blankNode);
              },
              child: EasyRefresh(
                footer: LoadFooter(),
                controller: _controller,
                onLoad: () async {
                  params['offset'] == null
                      ? params['offset'] = 2
                      : params['offset']++;
                 // _request();
                  //_controller.finishLoad(
                    //  noMore: commentData.length >= widget.communityHead.count);
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildHead(),
                      Container(
                        height: ScreenUtil().setWidth(20),
                        color: Color(0xfff5f5f5),
                      ),
                     /* ListView.separated(
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                              bottom: ScreenUtil().setWidth(50)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildCommentItem(commentData[index]);
                          },
                          separatorBuilder: (context, index) {
                            if (commentData[index].isTitle)
                              return Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(30)),
                              );
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: ScreenUtil().setWidth(30)),
                              height: ScreenUtil().setWidth(1.5),
                              color: Color(0xfff5f5f5),
                            );
                          },
                          itemCount: commentData.length),*/
                    ],
                  ),
                ),
              ),
            ),
            Align(
              child: CommunityInputWidget((content){
                // 提交评论
                NetUtils.sendComment(context, params:  {
                 // 'user_id': userId,
                 // 'song_id': widget.communityHead.id,
                 // 'content': content
                }).then((r){
                  Utils.showToast('评论成功！');
                  setState(() {
                   // Comments a=new Comments(user: r.user,commentId: r.commentId,content: r.content,time: r.time,likedCount: r.likedCount,isTitle: false,title: '');
                  //  commentData.insert(commentData.map((c) => c.title).toList().indexOf('最新评论')+1,a );
                  });
                });
              }),
              alignment: Alignment.bottomCenter,
            )
          ],
        ));
  }

  /*Widget buildCommentItem(Comments data) {
    if (data.isTitle)
      return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
        child: Text(
          data.title,
          style: bold17TextStyle,
        ),
      );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        OverImgWidget(data.user.avatarUrl, 70),
        HEmptyView(10),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    data.user.nickname,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setWidth(5)),
                    child: Text(
                      '${NumberUtils.amountConversion(data.likedCount)}',
                      style: common14GrayTextStyle,
                    ),
                  ),
                  HEmptyView(5),
                  Image.asset(
                    'images/icon_parise.png',
                    width: ScreenUtil().setWidth(35),
                    height: ScreenUtil().setWidth(35),
                  )
                ],
              ),
              VEmptyView(5),
              Text(
                DateUtil.getDateStrByMs(data.time,
                    format: DateFormat.YEAR_MONTH_DAY),
                style: smallGrayTextStyle,
              ),
              VEmptyView(20),
              Text(
                data.content,
                style:
                TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
              )
            ],
          ),
        ),
      ],
    );
  }*/

  Widget buildHead() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.centerLeft,
        // width: 300,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipOval(
              child:new Image.asset('images/icon_logo.png',width: 50,height: 50,),
            ),
            HEmptyView(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '网易云音乐',style: TextStyle(fontSize: 10,color: Colors.lightBlueAccent),
                ),
                Text(
                  'time',style: TextStyle(fontSize: 8,color: Colors.black54
                ),
                ),
                VEmptyView(10),
                Text('内容',
                  // maxLines: 2,
                  softWrap: true,
                ),

                Image.asset('images/icon_logo.png',width: 250,height: 250,),
               // _buildbutton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
