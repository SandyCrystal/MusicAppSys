class MyPlayListData {
  num _code;
  List<Playlist> playlist;

  MyPlayListData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];

    if (json['data'] != null) {
      playlist = new List<Playlist>();
      json['data'].forEach((v) {
        playlist.add(new Playlist.fromJson(v));
      });
    } else
      playlist = null;

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['code'] = this._code;
      if (this.playlist != null) {
        data['data'] = this.playlist.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }
}

class PlayListData {
  num _code;
  Playlist _playlist;

  PlayListData({num code, Null relatedVideos, Playlist playlist}) {
    this._code = code;
    this._playlist = playlist;
  }

  num get code => _code;
  set code(num code) => _code = code;
  Playlist get playlist => _playlist;
  set playlist(Playlist playlist) => _playlist = playlist;

  PlayListData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _playlist =
        json['data'] != null ? new Playlist.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._playlist != null) {
      data['data'] = this._playlist.toJson();
    }
    return data;
  }
}

class Playlist {
  String _id;
  String _name;
  Creator _creator;
  String _picurl;
  num _playcount;
  num _subcount;
  num _sheetTags; /* sheet中的type标签*/
  num type; /*用于删除标签的type*/
  List<Tracks> _tracks;
  num _trackCount;
  bool _iscollected;
  Playlist({
    String id,
    String name,
    Creator creator,
    String picurl,
    num playcount,
    num subcount,
    num sheetTags,
    /* sheet中的type标签*/
    List<Tracks> tracks,
    num trackCount,
    bool iscollected,
  }) {
    this._id = id;
    this._name = name;
    this._creator = creator;
    this._picurl = picurl;
    this._playcount = playcount;
    this._subcount = subcount;
    this._sheetTags = sheetTags;
    this._tracks = tracks;
    this._trackCount = trackCount;
    this._iscollected = iscollected;
  }
  num get trackCount => _trackCount;
  set trackCount(num trackCount) => _trackCount = trackCount;
  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  Creator get creator => _creator;
  set creator(Creator creator) => _creator = creator;
  String get picurl => _picurl;
  set picurl(String picurl) => _picurl = picurl;
  num get playcount => _playcount;
  set playcount(num playcount) => _playcount = playcount;
  num get sheetTags => _sheetTags;
  set sheetTags(num sheetTags) => _sheetTags = sheetTags;
  num get subcount => _subcount;
  set subcount(num subcount) => _subcount = subcount;
  List<Tracks> get tracks => _tracks;
  set tracks(List<Tracks> tracks) => _tracks = tracks;
  bool get iscollected => _iscollected;
  set iscollected(bool iscollected) => _iscollected = iscollected;
  Playlist.fromJson(Map<String, dynamic> json) {
    _creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['tracks'] != null) {
      _tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        _tracks.add(new Tracks.fromJson(v));
      });
    }
    _subcount = json['subCount'];
    _playcount = json['playCount'];
    _picurl = json['picUrl'];
    _trackCount = json['trackCount'];
    _name = json['name'];
    _id = json['id'];
    _iscollected = json['iscollected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._creator != null) {
      data['creator'] = this._creator.toJson();
    }
    if (this._tracks != null) {
      data['tracks'] = this._tracks.map((v) => v.toJson()).toList();
    }
    data['subCount'] = this._subcount;
    data['playCount'] = this._playcount;
    data['picUrl'] = this._picurl;
    data['tracksCount'] = this._trackCount;
    data['name'] = this._name;
    data['id'] = this._id;
    data['iscollected'] = this._iscollected;
    return data;
  }
}

class Tracks {
  String _name;
  String _id;
  String _artist;
  Al _album;
  bool _iscollected;
  Tracks({String name, String id, String artist, Al album, bool iscollected}) {
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
      int follow,
      int fans,
      bool isfollowed}) {
    this._userid = userid;
    this._userName = userName;
    this._userType = userType;
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

  set isfollowed(bool isfollowed) => _isfollowed = isfollowed;

  Creator.fromJson(Map<String, dynamic> json) {
    _userid = json['user_id'];
    _userName = json['user_name'];
    _userType = json['user_type'];
    _avatarUrl = json['avatar_url'];
    _introduction = json['introduction'];
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
