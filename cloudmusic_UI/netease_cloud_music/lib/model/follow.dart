import 'dart:convert';

import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
    if (type == String) {
      return "";
    } else if (type == int) {
      return 0;
    } else if (type == double) {
      return 0.0;
    } else if (type == bool) {
      return false;
    }
    return null;
  }

  if (value.runtimeType == type) {
    return value;
  }
  var valueS = value.toString();
  if (type == String) {
    return valueS;
  } else if (type == int) {
    return int.tryParse(valueS);
  } else if (type == double) {
    return double.tryParse(valueS);
  } else if (type == bool) {
    valueS = valueS.toLowerCase();
    var intValue = int.tryParse(valueS);
    if (intValue != null) {
      return intValue == 1;
    }
    return valueS == "true";
  }
}

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint("$e");
    debugPrint("$stack");
  }
}
class FollowData{
  int code;
  List<User> users;
  int total;
  FollowData({
    this.code,
    this.users,
    this.total,
  });
  factory FollowData.fromJson(jsonRes) {
    if (jsonRes == null) return null;


    List<User> users = jsonRes['data'] is List ? [] : null;
    if (users != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            users.add(User.fromJson(item));
          });
        }
      }
    }
    return FollowData(
      code: convertValueByType(jsonRes['code'], int,
          stack: "SongCommentData-code"),
      users: users,
      total: convertValueByType(jsonRes['total'], int,
          stack: "SongCommentData-total"),
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'users': users,
    'total': total,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
class User{
  String userid;
  String userName;
  String introduction;
  int createTime;
  String avatarUrl;
  int userType;
  int follow;
  int fans;
  bool isfollowed;
  User({
    this.userid,
    this.userName,
    this.introduction,
    this.avatarUrl,
    this.createTime,
    this.userType,
    this.follow,
    this.fans,
    this.isfollowed
  });
  factory User.fromJson(jsonRes) => jsonRes == null
      ? null
      : User(
    userName: convertValueByType(jsonRes['user_name'], String,
        stack: "User-name"),
    userid:
    convertValueByType(jsonRes['user_id'], String, stack: "User-userid"),
    avatarUrl: convertValueByType(jsonRes['avatar_url'], String,
        stack: "User-avatarurl"),
    follow: convertValueByType(jsonRes['follow'], int,
        stack: "User-follow"),
    fans: convertValueByType(jsonRes['fans'], int,
        stack: "User-fans"),
    isfollowed: convertValueByType(jsonRes['is_followed'], bool,
        stack: "User-isfollowed"),

  );


  Map<String, dynamic> toJson() => {
    'user_name': userName,
    'user_id': userid,
    'avatar_url': avatarUrl,
    'follow':follow,
    'fans':fans,
    "is_followed":isfollowed
  };
}