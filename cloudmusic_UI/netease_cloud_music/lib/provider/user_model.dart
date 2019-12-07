import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netease_cloud_music/application.dart';
import 'package:netease_cloud_music/application.dart' as prefix0;
import 'package:netease_cloud_music/model/user.dart';
import 'package:netease_cloud_music/utils/navigator_util.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netease_cloud_music/utils/utils.dart';

class UserModel with ChangeNotifier {
  User _user;

  User get user => _user;

  /// 初始化 User
  void initUser() {
    if (Application.sp.containsKey('user')) {
      String s = Application.sp.getString('user');
      _user = User.fromJson(json.decode(s));
    }
  }

  /// 登录
  void login(BuildContext context, String phone, String pwd) async {

    User user = await NetUtils.login(context, phone, pwd);
    if (user.code > 299) {
      Utils.showToast(user.msg ?? '登录失败，请检查账号密码');
      return;
    }
    Utils.showToast(user.msg ?? '登录成功');
    _saveUserInfo(user);
    NavigatorUtil.goHomePage(context);
  }

  ///注册
  void register(BuildContext context, String username, String pwd1,String pwd2) async {

    User user = await NetUtils.register(context,username,pwd1,pwd2);
    if (user.code > 299) {
      Utils.showToast(user.msg ?? '登录失败，请检查账号密码');
      return;
    }
    Utils.showToast(user.msg ?? '注册成功');
    _saveUserInfo(user);
    NavigatorUtil.goHomePage(context);
  }
  ///修改密码
  void changepwd(BuildContext context, String username, String pwdOld,String pwdNew) async {

    User user = await NetUtils.register(context,username,pwdOld,pwdNew);
    /*if (user.code > 299) {
      Utils.showToast(user.msg ?? '登录失败，请检查账号密码');
      return;
    }
    Utils.showToast(user.msg ?? '注册成功');*/
    Navigator.pop(context);
   // NavigatorUtil.goHomePage(context);
  }

  /// 保存用户信息到 sp
  _saveUserInfo(User user) {
    _user = user;
    print("user："+user.account.toJson().toString());
    Application.sp.remove('user');
    Application.sp.setString('user', json.encode(user.toJson()));
    Application.sp.getString('user');
  }
}
