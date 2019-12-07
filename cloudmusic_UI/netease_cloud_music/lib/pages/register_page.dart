import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/utils.dart';
import 'package:netease_cloud_music/widgets/common_button.dart';
import 'package:netease_cloud_music/widgets/v_empty_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with TickerProviderStateMixin {
   TextEditingController _userController = TextEditingController();
   TextEditingController _pwdController1 = TextEditingController();
   TextEditingController _pwdController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){NavigatorUtil.goLoginPage(context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(80),
            right: ScreenUtil().setWidth(80),
            top: ScreenUtil().setWidth(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/icon_logo.png',
                  width: ScreenUtil().setWidth(90),
                  height: ScreenUtil().setWidth(90),
                ),
              ),
              _buildRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegister(){
    return Theme(
      data: ThemeData(primaryColor: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
            child: Text(
              'Welcome Back!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 34,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(3)),
            child: Text(
              ' Music App',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          VEmptyView(50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            // 表单输入框，参数同 TextField 基本类似
            child: TextFormField(
              controller: _userController,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.phone_iphone, size: 24.0, color: Colors.grey),
                  labelText: '请输入用户名',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.grey)),
              // 有效条件(为空不通过，返回提示语，通过返回 null)
              validator: (value) => value.trim().isEmpty ? '用户名不能为空' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              obscureText: true,
              controller: _pwdController1,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 24.0, color: Colors.grey),
                  labelText: '请输入密码',
                  labelStyle: TextStyle(color: Colors.grey),
                  helperStyle: TextStyle(color: Colors.grey)),
              validator: (value) => value.trim().length < 6 ? '密码长度不能小于6位' : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: TextFormField(
              obscureText: true,
              controller: _pwdController2,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 24.0, color: Colors.grey),
                  labelText: '请重复密码',
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
                  String phone = _userController.text;
                  String pwd1 = _pwdController1.text;
                  String pwd2 = _pwdController2.text;
                  if (phone.isEmpty || pwd1.isEmpty || pwd2.isEmpty) {
                    Utils.showToast('请输入账号或者密码');
                    return;
                  }
                  if(pwd1.length < 6){
                    Utils.showToast('密码长度小于6位');
                    return;
                  }
                  if(pwd1!=pwd2){
                    Utils.showToast('两次密码输入不相符');
                    return;
                  }
                  value.register(
                    context,
                    phone,
                    pwd1,
                    pwd2,
                  );
                },
                content: '注册',
                width: double.infinity,
              );
            },
          )
        ],
      ),
    );
  }



  }


