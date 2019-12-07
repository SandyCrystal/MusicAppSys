class SearchSongs {
  num _code;
  List<Songs> songs;

  SearchSongs.fromJson(Map<String, dynamic> json) {
    _code = json['code'];

    if (json['data'] != null) {
      songs = new List<Songs>();
      json['data'].forEach((v) {
        songs.add(new Songs.fromJson(v));
      });
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['code'] = this._code;
      if (this.songs != null) {
        data['data'] = this.songs.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }
}

class Songs {
  String _name;
  String _id;
  String _artist;
  Album _album;
  bool _iscollected;

  Songs({String name, String id, String artist, Album album, bool iscollected});

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get artist => _artist;
  set artist(String artist) => _artist = artist;
  Album get album => _album;
  set album(Album album) => _album = album;
  bool get iscollected => _iscollected;
  set iscollected(bool iscollected) => _iscollected = iscollected;
  Songs.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _artist = json['artist'];
    _album = Album.fromJson(json['album']);
    _iscollected = json['iscollected'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['artist'] = this._artist;
    data['album'] = this._album;
    data['iscollected'] = this._iscollected;
    return data;
  }
}

class Album {
  String _id;
  String _name;
  String _picUrl;

  Album({String id, String name, String picUrl}) {
    this._id = id;
    this._name = name;
    this._picUrl = picUrl;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;

  Album.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['picUrl'] = this._picUrl;
    ;
    return data;
  }
}
