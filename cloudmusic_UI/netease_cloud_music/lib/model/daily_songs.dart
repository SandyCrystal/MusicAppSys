class DailySongsData {
  num _code;
  List<Recommend> _recommend;

  DailySongsData({num code, List<Recommend> recommend}) {
    this._code = code;
    this._recommend = recommend;
  }

  num get code => _code;
  set code(num code) => _code = code;
  List<Recommend> get recommend => _recommend;
  set recommend(List<Recommend> recommend) => _recommend = recommend;

  DailySongsData.fromJson(Map<String, dynamic> json) {
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
  String _name;
  String _id;
  String _artists;
  Album _album;
  num _mvid;
  bool _iscollected;
  Recommend({
    String name,
    String id,
    String artists,
    Album album,
    bool iscollected,
  }) {
    this._name = name;
    this._id = id;
    this._artists = artists;
    this._album = album;
    this._mvid = 0;
    this._iscollected = iscollected;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get id => _id;
  set id(String id) => _id = id;
  String get artists => _artists;
  set artists(String artists) => _artists = artists;
  Album get album => _album;
  set album(Album album) => _album = album;
  num get mvid => _mvid;
  set mvid(num mvid) => _mvid = mvid;
  bool get iscollected => _iscollected;
  set iscollected(bool iscollected) => _iscollected = iscollected;

  Recommend.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];

    if (json['artists'] != null) {
      _artists = json['artists'];
    } else {
      _artists = "";
    }
    _album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    _iscollected = json['iscollected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    if (this._artists != null) {
      data['artists'] = this._artists;
    }
    if (this._album != null) {
      data['album'] = this._album.toJson();
    }
    data['iscollected'] = this._iscollected;
  }
}

class Album {
  String _name;
  String _id;
  String _picUrl;

  Album({
    String name,
    String id,
    String picUrl,
  }) {
    this._name = name;
    this._id = id;
    this._picUrl = picUrl;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get id => _id;
  set id(String id) => _id = id;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;

  Album.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    data['picUrl'] = this._picUrl;
    return data;
  }
}
