import 'package:flutter/foundation.dart';

class RecommendData {
  int _code;
  List<Recommend> _recommend;
  RecommendData(
      {int code,
        List<Recommend> recommend}) {
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
  int _id;
  String _name;
  String _copywriter;
  String _picUrl;
  int _playcount;
  int _createTime;
  Creator _creator;


  Recommend(
      {int id,
        String name,
        String copywriter,
        String picUrl,
        int playcount,
        int createTime,
        Creator creator
      }) {
    this._id = id;
    this._name = name;
    this._copywriter = copywriter;
    this._picUrl = picUrl;
    this._playcount = playcount;
    this._createTime = createTime;
    this._creator = creator;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get copywriter => _copywriter;
  set copywriter(String copywriter) => _copywriter = copywriter;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  int get playcount => _playcount;
  set playcount(int playcount) => _playcount = playcount;
  int get createTime => _createTime;
  set createTime(int createTime) => _createTime = createTime;
  Creator get creator => _creator;
  set creator(Creator creator) => _creator = creator;

  Recommend.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _copywriter = json['copywriter'];
    _picUrl = json['picUrl'];
    _playcount = json['playcount'];
    _createTime = json['createTime'];
    _creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['copywriter'] = this._copywriter;
    data['picUrl'] = this._picUrl;
    data['playcount'] = this._playcount;
    data['createTime'] = this._createTime;
    if (this._creator != null) {
      data['creator'] = this._creator.toJson();
    }
    return data;
  }
}

class Creator {


  int _userId;
  String _avatarUrl;
  String _nickname;
  String _description;

  Creator(
      {
        int userId,

        String avatarUrl,

        String nickname,

        String description}) {

    this._userId = userId;
    this._avatarUrl = avatarUrl;
    this._nickname = nickname;

    this._description = description;

  }



  int get userId => _userId;
  set userId(int userId) => _userId = userId;

  String get avatarUrl => _avatarUrl;
  set avatarUrl(String avatarUrl) => _avatarUrl = avatarUrl;
  String get nickname => _nickname;
  set nickname(String nickname) => _nickname = nickname;

  String get description => _description;
  set description(String description) => _description = description;


  Creator.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _avatarUrl = json['avatarUrl'];
    _nickname = json['nickname'];
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this._userId;

    data['avatarUrl'] = this._avatarUrl;

    data['nickname'] = this._nickname;
    data['description'] = this._description;
    return data;
  }
}
