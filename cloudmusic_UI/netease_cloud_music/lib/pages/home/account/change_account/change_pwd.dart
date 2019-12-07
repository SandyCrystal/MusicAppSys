import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/model/user.dart';
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
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:netease_cloud_music/widgets/widget_banner.dart';
import 'package:netease_cloud_music/widgets/widget_future_builder.dart';
import 'package:netease_cloud_music/widgets/widget_play_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


User _user = User.fromJson(json.decode(Application.sp.getString('user')));
class Change_PwdPage extends StatefulWidget{
  @override
  _Change_PwdPageState createState() => _Change_PwdPageState();
}

class _Change_PwdPageState extends State<Change_PwdPage> with AutomaticKeepAliveClientMixin{
  final TextEditingController _pwdOld = TextEditingController();
  final TextEditingController _pwdNew = TextEditingController();
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("更改密码"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VEmptyView(30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            // 表单输入框，参数同 TextField 基本类似
            child: TextFormField(
              controller: _pwdOld,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 24.0, color: Colors.grey),
                  labelText: '请输入旧密码',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.grey)),
              // 有效条件(为空不通过，返回提示语，通过返回 null)
              validator: (value) => value.trim().isEmpty ? '旧密码不能为空' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              obscureText: true,
              controller: _pwdNew,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 24.0, color: Colors.grey),
                  labelText: '请输入新密码',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.grey)),
              validator: (value) => value.trim().length < 6 ? '密码长度不能小于6位' : null,
            ),
          ),
          VEmptyView(120),
          Consumer<UserModel>(
            builder: (BuildContext context, UserModel value, Widget child) {
              return CommonButton(
                callback: () {
                  String oldpwd = _pwdOld.text;
                  String newpwd = _pwdNew.text;
                  if (oldpwd.isEmpty || newpwd.isEmpty) {
                    Utils.showToast('请输入旧密码或者新密码');
                    return;
                  }
                  if(isEqual(oldpwd,newpwd)){
                    Utils.showToast('新旧密码相同，请重新输入新密码');
                    return;
                  }
                  if(newpwd.length < 6){
                    Utils.showToast('密码长度小于6位');
                    return;
                  }
                  ///changepwd未实现
                  ///
                  ///
                  ///
                  ///
                  value.changepwd(context, _user.account.userName, oldpwd, newpwd);
                },
                content: '修改密码',
                width: double.infinity,
              );
            },
          )
        ],
      ),
    );
  }

  isEqual(String text1,String text2){
    return text1==text2;
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}