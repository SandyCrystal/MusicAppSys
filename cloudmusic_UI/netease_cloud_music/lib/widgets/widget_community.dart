import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/widgets/common_text_style.dart';
import 'package:netease_cloud_music/utils/number_utils.dart';
import 'package:netease_cloud_music/widgets/h_empty_view.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netease_cloud_music/widgets/widget_play_list_cover.dart';

class PlayCommunity extends StatelessWidget{
   final String userpicUrl;//用户头像
   final String username;//用户名称
   final String text;//评论信息
   final String time;//时间
   final String picUrl;//图片信息
   final int count;//点赞数
   //final int _count;//评论数
 // final String text;
  //final String subText;
  //final num playCount;
 // final int maxLines;
 // final VoidCallback onTap;
  //final int index;

  PlayCommunity({
    this.userpicUrl,
    this.username,//用户名称
    this.text,//评论信息
    this.picUrl,//图片信息
    this.count,//点赞数
    this.time,
   // @required this.text,
  //  this.playCount,
   // this.subText,
   // this.onTap,
   // this.maxLines = -1,
   // this.index,
  });
  Widget _buildbutton(){
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.chat,
            size: ScreenUtil().setWidth(30),
            color: Colors.black45,
          ),
          onPressed: (){},
        ),
        HEmptyView(10),
        Text('0'),
        HEmptyView(100),
        IconButton(
          icon: Icon(
            Icons.thumb_up,
            size: ScreenUtil().setWidth(30),
            color: Colors.black45,
          ),
          onPressed: (){},
        ),
        HEmptyView(10),
        Text('0'),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          alignment: Alignment.centerLeft,
         // width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child:new Image.asset(userpicUrl,width: 50,height: 50,),
              ),
              HEmptyView(10),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          Text(
                            username,style: TextStyle(fontSize: 10,color: Colors.lightBlueAccent),
                          ),
                          Text(
                            time,style: TextStyle(fontSize: 8,color: Colors.black54
                          ),
                          ),
                      VEmptyView(10),
                       text==null?
                       Container():
                       Text(text,
                        // maxLines: 2,
                         softWrap: true,
                      ),
                      picUrl==null ?
                      Container():
                      Image.asset(picUrl,width: 250,height: 250,),
                      _buildbutton(),
                    ],
                  ),
            ],
          ),
        ),
    );
  }
}