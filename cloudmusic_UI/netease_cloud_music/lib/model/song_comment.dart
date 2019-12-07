import 'dart:convert' show json;
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

class SongCommentData {
  int code;
  List<Comments> comments;
  Comments comment;
  int total;
  bool more;

  SongCommentData({
    this.code,
    this.comments,
    this.total,
    this.more,
    this.comment,
  });

  factory SongCommentData.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Comments> comments = jsonRes['comments'] is List ? [] : null;
    if (comments != null) {
      for (var item in jsonRes['comments']) {
        if (item != null) {
          tryCatch(() {
            comments.add(Comments.fromJson(item));
          });
        }
      }
    }
    List<Comments> hotComments = jsonRes['hotComments'] is List ? [] : null;
    if (hotComments != null) {
      for (var item in jsonRes['hotComments']) {
        if (item != null) {
          tryCatch(() {
            hotComments.add(Comments.fromJson(item));
          });
        }
      }
    }
    return SongCommentData(
      code: convertValueByType(jsonRes['code'], int,
          stack: "SongCommentData-code"),
      comments: comments,
      total: convertValueByType(jsonRes['total'], int,
          stack: "SongCommentData-total"),
      more: convertValueByType(jsonRes['more'], bool,
          stack: "SongCommentData-more"),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'comments': comments,
        'total': total,
        'more': more,
        'comment': comment,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Comment2 {
  User user;
  String commentId;
  String content;
  int time;
  int likedCount;
  bool isTitle;
  String title;

  Comment2({
    this.user,
    this.commentId,
    this.content,
    this.time,
    this.likedCount,
    this.isTitle = false,
    this.title = '评论',
  });

  factory Comment2.fromJson(jsonRes) {
    jsonRes = jsonRes['data'];
    if (jsonRes == null) return null;

    return Comment2(
      user: User.fromJson(jsonRes['user']),
      commentId: convertValueByType(jsonRes['commentId'], String,
          stack: "Comments-commentId"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "Comments-content"),
      time: convertValueByType(jsonRes['time'], int, stack: "Comments-time"),
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "Comments-likedCount"),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'commentId': commentId,
        'content': content,
        'time': time,
        'likedCount': likedCount,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Comments {
  User user;
  String commentId;
  String content;
  int time;
  int likedCount;
  bool isTitle;
  String title;
  bool isliked;
  Comments({
    this.user,
    this.commentId,
    this.content,
    this.time,
    this.likedCount,
    this.isTitle = false,
    this.title = '评论',
    this.isliked,
  });

  factory Comments.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    return Comments(
      user: User.fromJson(jsonRes['user']),
      commentId: convertValueByType(jsonRes['commentId'], String,
          stack: "Comments-commentId"),
      content: convertValueByType(jsonRes['content'], String,
          stack: "Comments-content"),
      time: convertValueByType(jsonRes['time'], int, stack: "Comments-time"),
      likedCount: convertValueByType(jsonRes['likedCount'], int,
          stack: "Comments-likedCount"),
      isliked: convertValueByType(jsonRes['is_liked'], bool,
          stack: "Comments-isliked"),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'commentId': commentId,
        'content': content,
        'time': time,
        'likedCount': likedCount,
        'isliked': isliked,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class User {
  String userId;
  String nickname;
  String avatarUrl;
  int follow;
  int fans;
  bool isfollowed;
  User({
    this.follow,
    this.fans,
    this.isfollowed,
    this.nickname,
    this.userId,
    this.avatarUrl,
  });

  factory User.fromJson(jsonRes) => jsonRes == null
      ? null
      : User(
          nickname: convertValueByType(jsonRes['userName'], String,
              stack: "User-nickname"),
          userId: convertValueByType(jsonRes['userId'], String,
              stack: "User-userId"),
          avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
              stack: "User-avatarUrl"),
          follow:
              convertValueByType(jsonRes['follow'], int, stack: "User-follow"),
          fans: convertValueByType(jsonRes['fans'], int, stack: "User-fans"),
          isfollowed: convertValueByType(jsonRes['isfollowed'], bool,
              stack: "User-isfollowed"),
        );

  Map<String, dynamic> toJson() => {
        'userName': nickname,
        'userId': userId,
        'avatarUrl': avatarUrl,
        'follow': follow,
        'fans': fans,
        "isfollowed": isfollowed
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
