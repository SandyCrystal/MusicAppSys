import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/attention.dart';
import 'package:netease_cloud_music/pages/home/community/commnuity_item/dynamic.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application.dart';

class Create_CommunityPage extends StatefulWidget{
  final String userId;
  final String uid=json.decode(Application.sp.getString('user'))["data"]["user_id"];
  Create_CommunityPage(this.userId);
  @override
  _Create_CommunityPageState createState() => _Create_CommunityPageState();
}

class _Create_CommunityPageState extends State<Create_CommunityPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TextEditingController _conter = TextEditingController();
  var _imgPath;

  @override
  void initState() {

    super.initState();
  }
  Widget buildMenu(){
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),),
        Row(
          children: <Widget>[
            MaterialButton(
              child: new Text('所在位置',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),),
              onPressed: () {},
            ),
            new Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  HEmptyView(10),
                ],
              ),
            ),
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
        Container(width: double.infinity, height: 1.0, color: Color(0xFFF3F3F3),),
        Row(
          children: <Widget>[
            MaterialButton(
              child: new Text('谁可以看',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),),
              onPressed: () {},
            ),
            new Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  HEmptyView(10),
                ],
              ),
            ),
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
        Container(width: double.infinity, height: 8.0, color: Color(0xFFF3F3F3),),
      ],);

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
          ),
          preferredSize: Size.zero,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
         // bottom: false,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    child: new Text('取消',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),),
                    onPressed: () {Navigator.pop(context);},
                  ),
                  new Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        HEmptyView(10),
                      ],
                    ),
                  ),
                  MaterialButton (
                    child: new Text('发送',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),),
                    onPressed: () {
                      String conter = _conter.text;
                      conter == null ?
                          Utils.showToast('输入内容不能为空'):
                          {
                            NetUtils.sendDynamic(context, params: {"userId":widget.uid,"content":conter,"picUrl":_imgPath})
                                .then((m)=>(Utils.showToast('发送成功')))
                                .catchError((err)=>(Utils.showToast('发送失败'))),
                            Navigator.pop(context)};
                    },
                  )
                ],
              ),
              Container(
                color: Color(0xfff5f5f5),
                height: ScreenUtil().setWidth(40),
              ),
              VEmptyView(20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                // 表单输入框，参数同 TextField 基本类似
                child: TextFormField(
                  controller: _conter,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                      labelText: '随便聊一聊',
                      labelStyle: TextStyle(color: Colors.grey),
                      helperStyle: TextStyle(color: Colors.grey)),
                ),
              ),
                    _ImageView(_imgPath),
                    RaisedButton(
                      onPressed: _takePhoto,
                      child: Text("拍照"),
                    ),
                    RaisedButton(
                      onPressed: _openGallery,
                      child: Text("选择照片"),
                    ),


              /*VEmptyView(100),
              IconButton(icon: Icon(
                  Icons.border_inner
              ),
                  iconSize: 50,
                  onPressed: (){
                    ImagePickerWidget();
                  }),*/
              //VEmptyView(100),
              //buildMenu(),
            ],


            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        )
    );
  }
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text("请选择图片或拍照"),
      );
    } else {
      return Image.file(
        imgPath,
        height: 250,
        width: 250,
      );
    }
  }


  /*拍照*/
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imgPath = image;
    });
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }
}