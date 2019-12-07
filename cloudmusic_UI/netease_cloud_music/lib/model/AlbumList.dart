class AlbumListData {
  num _code;
  AlbumList _albumList;

  AlbumListData({num code, Null relatedVideos, AlbumList playlist}) {
    this._code = code;
    this._albumList = albumList;
  }

  num get code => _code;
  set code(num code) => _code = code;
  AlbumList get albumList => _albumList;
  set albumList(AlbumList albumList) => _albumList = albumList;

  AlbumListData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _albumList =
        json['data'] != null ? new AlbumList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._albumList != null) {
      data['data'] = this._albumList.toJson();
    }
    return data;
  }
}

class AlbumList {
  String _id;
  String _name;
  Artist _artist;
  String _picurl;
  List<Tracks> _tracks;
  AlbumList({
    String id,
    String name,
    Artist artist,
    String picurl,
    List<Tracks> tracks,
  }) {
    this._id = id;
    this._name = name;
    this._artist = artist;
    this._picurl = picurl;
    this._tracks = tracks;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Artist get artist => _artist;
  set artist(Artist artist) => _artist = artist;
  String get picurl => _picurl;
  set picurl(String picurl) => _picurl = picurl;
  List<Tracks> get tracks => _tracks;
  set tracks(List<Tracks> tracks) => _tracks = tracks;
  AlbumList.fromJson(Map<String, dynamic> json) {
    _artist =
        json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    if (json['songs'] != null) {
      _tracks = new List<Tracks>();
      json['songs'].forEach((v) {
        _tracks.add(new Tracks.fromJson(v));
      });
    }
    _picurl = json['picUrl'];
    _name = json['name'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._artist != null) {
      data['artist'] = this._artist.toJson();
    }
    if (this._tracks != null) {
      data['songs'] = this._tracks.map((v) => v.toJson()).toList();
    }
    data['picUrl'] = this._picurl;
    data['name'] = this._name;
    data['id'] = this._id;
    return data;
  }
}

class Tracks {
  String _name;
  String _id;
  String _artist;
  Al _album;
  bool _iscollected;
  Tracks({
    String name,
    String id,
    String artist,
    bool iscollected,
    Al album,
  }) {
    this._id = id;
    this._name = name;
    this._artist = artist;
    this._album = album;
    this._iscollected = iscollected;
  }
  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get artist => _artist;
  set artist(String artist) => _artist = artist;
  Al get album => _album;
  set album(Al album) => _album = album;
  bool get iscollected => _iscollected;

  set iscollected(bool iscollected) => _iscollected = iscollected;
  Tracks.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _artist = json['artist'];
    _album = Al.fromJson(json['album']);
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

class Al {
  String _id;
  String _name;
  String _picUrl;

  Al({String id, String name, String picUrl}) {
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

  Al.fromJson(Map<String, dynamic> json) {
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

class Artist {
  String _artistId;
  String _artistName;

  String _avatarUrl;
  Artist({String artistId, String artistName, String avatarUrl}) {
    this._artistId = artistId;
    this._artistName = artistName;
    this._avatarUrl = avatarUrl;
  }

  String get artistId => _artistId;

  set artistId(String artistId) => _artistId = artistId;

  String get artistName => _artistName;

  set artistName(String artistName) => _artistName = artistName;

  String get avatarUrl => _avatarUrl;

  set avatarUrl(String avatarUrl) => _avatarUrl = avatarUrl;

  Artist.fromJson(Map<String, dynamic> json) {
    _artistId = json['artist_id'];
    _artistName = json['artist_name'];
    _avatarUrl = json['artist_pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist_id'] = this._artistId;
    data['artist_name'] = this._artistName;
    data['artist_pic_url'] = this.avatarUrl;
    return data;
  }
}
