class AlbumData {
  int _total;
  List<Albums> _albums;
  int _code;

  AlbumData({int total, List<Albums> albums, int code}) {
    this._total = total;
    this._albums = albums;
    this._code = code;
  }

  int get total => _total;
  set total(int total) => _total = total;
  List<Albums> get albums => _albums;
  set albums(List<Albums> albums) => _albums = albums;
  int get code => _code;
  set code(int code) => _code = code;

  AlbumData.fromJson(Map<String, dynamic> json) {
    _total = json['total'];
    if (json['data'] != null) {
      _albums = new List<Albums>();
      json['data'].forEach((v) {
        _albums.add(new Albums.fromJson(v));
      });
    }
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this._total;
    if (this._albums != null) {
      data['data'] = this._albums.map((v) => v.toJson()).toList();
    }
    data['code'] = this._code;
    return data;
  }
}

class Albums {

  Artist _artist;
  int _publishTime;
  String _picUrl;
  String _name;
  String _id;

  Albums(
      {
        Artist artist,
        int publishTime,
        String picUrl,
        String name,
        String id,
      }) {
    this._artist = artist;
    this._publishTime = publishTime;
    this._picUrl = picUrl;
    this._name = name;
    this._id = id;

  }



  Artist get artist => _artist;
  set artist(Artist artist) => _artist = artist;
  int get publishTime => _publishTime;
  set publishTime(int publishTime) => _publishTime = publishTime;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  String get name => _name;
  set name(String name) => _name = name;
  String get id => _id;
  set id(String id) => _id = id;

  Albums.fromJson(Map<String, dynamic> json) {
    _artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    _publishTime = json['publishTime'];
    _picUrl = json['picUrl'];
    _name = json['name'];
    _id = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._artist != null) {
      data['artist'] = this._artist.toJson();
    }
    data['publishTime'] = this._publishTime;
    data['picUrl'] = this._picUrl;
    data['name'] = this._name;
    data['id'] = this._id;
    return data;
  }
}


class Artist {


  String _picUrl;
  String _name;
  String _id;
  Artist(
      {
        String picUrl,
        String name,
        String id,
       }) {

    this._picUrl = picUrl;
    this._name = name;
    this._id = id;

  }

  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  String get name => _name;
  set name(String name) => _name = name;
  String get id => _id;
  set id(String id) => _id = id;

  Artist.fromJson(Map<String, dynamic> json) {

    _picUrl = json['picUrl'];
    _name = json['name'];
    _id = json['id'];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['picUrl'] = this._picUrl;
    data['name'] = this._name;
    data['id'] = this._id;
    return data;
  }
}
