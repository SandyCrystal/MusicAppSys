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

class ComDynamic {
  int code;
  List<ComDynamics> comdynamics;
  int total;

  ComDynamic({
    this.code,
    this.comdynamics,
    this.total,
  });

  factory ComDynamic.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<ComDynamics> comdynamics = jsonRes['data'] is List ? [] : null;
    if (comdynamics != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          tryCatch(() {
            comdynamics.add(ComDynamics.fromJson(item));
          });
        }
      }
    }
    return ComDynamic(
      code: convertValueByType(jsonRes['code'], int,
          stack: "SongCommentData-code"),
      comdynamics: comdynamics,
      total: convertValueByType(jsonRes['total'], int,
          stack: "SongCommentData-total"),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'comments': comdynamics,
        'total': total,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ComDynamics {
  int dynamicId;
  User user;
  String content;
  String picUrl;
  String createTime;
  int likeCount;
  bool isliked;
  ComDynamics({
    this.dynamicId,
    this.user,
    this.content,
    this.picUrl,
    this.createTime,
    this.likeCount,
    this.isliked,
  });
  factory ComDynamics.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    return ComDynamics(
      user: User.fromJson(jsonRes['user']),
      dynamicId: convertValueByType(jsonRes['dynamic_id'], int,
          stack: "ComDynamics-dynamicId"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "ComDynamics-content"),
      picUrl: convertValueByType(jsonRes['pic_url'], String,
          stack: "ComDynamics-picUrl"),
      createTime: convertValueByType(jsonRes['create_time'], String,
          stack: "ComDynamics-createTime"),
      likeCount: convertValueByType(jsonRes['like_count'], int,
          stack: "ComDynamics-likeCount"),
      isliked: convertValueByType(jsonRes['is_liked'], bool,
          stack: "ComDynamics-isliked"),
    );
  }
}

class User {
  String userId;
  String nickname;
  String avatarUrl;
  int follow;
  int fans;
  bool isfollowed;
  User(
      {this.nickname,
      this.userId,
      this.avatarUrl,
      this.follow,
      this.fans,
      this.isfollowed});

  factory User.fromJson(jsonRes) => jsonRes == null
      ? null
      : User(
          nickname: convertValueByType(jsonRes['user_name'], String,
              stack: "User-name"),
          userId: convertValueByType(jsonRes['user_id'], String,
              stack: "User-userid"),
          avatarUrl: convertValueByType(jsonRes['avatar_url'], String,
              stack: "User-avatarurl"),
          follow:
              convertValueByType(jsonRes['follow'], int, stack: "User-follow"),
          fans: convertValueByType(jsonRes['fans'], int, stack: "User-fans"),
          isfollowed: convertValueByType(jsonRes['isfollowed'], bool,
              stack: "User-isfollowed"),
        );

  Map<String, dynamic> toJson() => {
        'user_name': nickname,
        'user_id': userId,
        'avatar_url': avatarUrl,
        'follow': follow,
        'fans': fans,
        "isfollowed": isfollowed
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
