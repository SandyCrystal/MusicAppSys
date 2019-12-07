import 'package:flutter/foundation.dart';

class RecommendData {
  int _code;
  List<Recommend> _recommend;
  RecommendData({int code, List<Recommend> recommend}) {
    this._code = code;
    this._recommend = recommend;
  }

  int get code => _code;
  set code(int code) => _code = code;

  List<Recommend> get recommend => _recommend;
  set recommend(List<Recommend> recommend) => _recommend = recommend;

  RecommendData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    if (json['data'] != null) {
      _recommend = new List<Recommend>();
      json['data'].forEach((v) {
        _recommend.add(new Recommend.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._recommend != null) {
      data['data'] = this._recommend.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recommend {
  String _id;
  String _name;
  String _picUrl;
  int _playcount;
  int _createTime;
  Creator _creator;
  int _type;
  bool _iscollected;
  Recommend(
      {String id,
      String name,
      String picUrl,
      int playcount,
      int createTime,
      Creator creator,
      int type,
      bool iscollected}) {
    this._id = id;
    this._name = name;
    this._picUrl = picUrl;
    this._playcount = playcount;
    this._createTime = createTime;
    this._creator = creator;
    this._type = 1;
    this._iscollected = iscollected;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;

  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  int get playcount => _playcount;
  set playcount(int playcount) => _playcount = playcount;
  int get createTime => _createTime;
  set createTime(int createTime) => _createTime = createTime;
  Creator get creator => _creator;
  set creator(Creator creator) => _creator = creator;
  int get type => _type;
  set type(int type) => _type = type;
  bool get iscollected => _iscollected;
  set iscollected(bool iscollected) => _iscollected = iscollected;
  Recommend.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _picUrl = json['picUrl'];
    _playcount = json['playCount'];
    _createTime = json['createTime'];
    _creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    _iscollected = json['iscollected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['picUrl'] = this._picUrl;
    data['playCount'] = this._playcount;
    data['createTime'] = this._createTime;
    if (this._creator != null) {
      data['creator'] = this._creator.toJson();
    }
    data['iscollected'] = this._iscollected;
    return data;
  }
}

class Creator {
  String _userid;
  String _userName;
  String _introduction;
  String _avatarUrl;
  int _userType;
  int _follow;
  int _fans;
  bool _isfollowed;
  Creator(
      {String userid,
      String userName,
      int userType,
      String introduction,
      String avatarUrl,
//    DateTime createTime,
      String picUrl,
      int follow,
      int fans,
      bool isfollowed}) {
    this._userid = userid;
    this._userName = userName;
    this._userType = userType;
//    this._createTime = createTime;
    this._avatarUrl = avatarUrl;
    this._introduction = introduction;
    this._fans = fans;
    this._follow = follow;
    this._isfollowed = isfollowed;
  }

  String get userid => _userid;

  set userid(String userid) => _userid = userid;

  String get userName => _userName;

  set userName(String userName) => _userName = userName;

  int get userType => _userType;

  set userType(int userType) => _userType = userType;

  String get avatarUrl => _avatarUrl;

  set avatarUrl(String avatarUrl) => _avatarUrl = avatarUrl;

  String get introduction => _introduction;

  set introduction(String introduction) => _introduction = introduction;
  int get follow => _follow;

  set follow(int follow) => _follow = follow;

  int get fans => _fans;

  set fans(int fans) => _fans = fans;
  bool get isfollowed => _isfollowed;

//  DateTime get createTime => _createTime;
//
//  set createTime(DateTime createTime) => _createTime = createTime;

  Creator.fromJson(Map<String, dynamic> json) {
    _userid = json['user_id'];
    _userName = json['user_name'];
    _userType = json['user_type'];
    _avatarUrl = json['avatar_url'];
    _introduction = json['introduction'];
//    _createTime = json['createTime'];
    _follow = json['follow'];
    _fans = json['fans'];
    _isfollowed = json['isfollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userid;
    data['user_name'] = this._userName;
    data['user_type'] = this._userType;
    data['avatar_url'] = this.avatarUrl;
    data['introduction'] = this._introduction;
    data['follow'] = this._follow;
    data['fans'] = this._fans;
    data['isfollowed'] = this._isfollowed;
    return data;
  }
}
