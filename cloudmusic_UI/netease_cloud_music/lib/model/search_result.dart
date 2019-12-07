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

class SearchMultipleData {
  Result result;
  int code;

  SearchMultipleData({
    this.result,
    this.code,
  });

  factory SearchMultipleData.fromJson(jsonRes) => jsonRes == null
      ? null
      : SearchMultipleData(
    result: Result.fromJson(jsonRes['result']),
    code: convertValueByType(jsonRes['code'], int,
        stack: "SearchMultipleData-code"),
  );

  Map<String, dynamic> toJson() => {
    'result': result,
    'code': code,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Result {
  Song song;
  int code;
  PlayList playList;
  Artist artist;
  Album album;
  SimQuery sim_query;
  User user;
  List<Songs> songs;
  int songCount;

  Result({
    this.song,
    this.code,
    this.playList,
    this.artist,
    this.album,
    this.sim_query,
    this.user,
    this.songCount,
    this.songs
  });

  factory Result.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> rec_query = jsonRes['rec_query'] is List ? [] : null;
    if (rec_query != null) {
      for (var item in jsonRes['rec_query']) {
        if (item != null) {
          rec_query.add(item);
        }
      }
    }

    List<Songs> songs = jsonRes['songs'] is List ? [] : null;
    if (songs != null) {
      for (var item in jsonRes['songs']) {
        if (item != null) {
          songs.add(Songs.fromJson(item));
        }
      }
    }

    List<String> order = jsonRes['order'] is List ? [] : null;
    if (order != null) {
      for (var item in jsonRes['order']) {
        if (item != null) {
          order.add(item);
        }
      }
    }
    return Result(
      song: Song.fromJson(jsonRes['song']),
      code: convertValueByType(jsonRes['code'], int, stack: "Result-code"),
      songCount: convertValueByType(jsonRes['songCount'], int, stack: "Result-songCount"),
      playList: PlayList.fromJson(jsonRes['playList']),
      artist: Artist.fromJson(jsonRes['artist']),
      album: Album.fromJson(jsonRes['album']),
      sim_query: SimQuery.fromJson(jsonRes['sim_query']),

      user: User.fromJson(jsonRes['user']),
      songs: songs,
    );
  }

  Map<String, dynamic> toJson() => {
    'song': song,
    'code': code,

    'playList': playList,
    'artist': artist,
    'album': album,
    'sim_query': sim_query,
    'user': user,

    'songs': songs,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Song {
  String moreText;
  List<Songs> songs;
  bool more;
  List<int> resourceIds;

  Song({
    this.moreText,
    this.songs,
    this.more,
    this.resourceIds,
  });

  factory Song.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Songs> songs = jsonRes['songs'] is List ? [] : null;
    if (songs != null) {
      for (var item in jsonRes['songs']) {
        if (item != null) {
          songs.add(Songs.fromJson(item));
        }
      }
    }

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          resourceIds.add(item);
        }
      }
    }
    return Song(
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Song-moreText"),
      songs: songs,
      more: convertValueByType(jsonRes['more'], bool, stack: "Song-more"),
      resourceIds: resourceIds,
    );
  }

  Map<String, dynamic> toJson() => {
    'moreText': moreText,
    'songs': songs,
    'more': more,
    'resourceIds': resourceIds,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Songs {
  String name;
  int id;
  List<Artists> artists;
  Album album;
  List<Ar> ar;
  int mv;
  int rtype;

  Songs({
    this.name,
    this.id,
    this.ar,
    this.artists,
    this.album,
    this.mv,
    this.rtype,
  });

  factory Songs.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Ar> ar = jsonRes['ar'] is List ? [] : null;
    if (ar != null) {
      for (var item in jsonRes['ar']) {
        if (item != null) {
          ar.add(Ar.fromJson(item));
        }
      }
    }

    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          artists.add(Artists.fromJson(item));
        }
      }
    }

    List<Object> alia = jsonRes['alia'] is List ? [] : null;
    if (alia != null) {
      for (var item in jsonRes['alia']) {
        if (item != null) {
          alia.add(item);
        }
      }
    }

    List<Object> rtUrls = jsonRes['rtUrls'] is List ? [] : null;
    if (rtUrls != null) {
      for (var item in jsonRes['rtUrls']) {
        if (item != null) {
          rtUrls.add(item);
        }
      }
    }

    List<Object> officialTags = jsonRes['officialTags'] is List ? [] : null;
    if (officialTags != null) {
      for (var item in jsonRes['officialTags']) {
        if (item != null) {
          officialTags.add(item);
        }
      }
    }
    return Songs(
      name: convertValueByType(jsonRes['name'], String, stack: "Songs-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Songs-id"),

      ar: ar,
      artists: artists,

      album: Album.fromJson(jsonRes['album']),


      mv: convertValueByType(jsonRes['mv'], int, stack: "Songs-mv"),
      rtype: convertValueByType(jsonRes['rtype'], int, stack: "Songs-rtype"),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'artists': artists,
    'ar': ar,
    'album': album,
    'mv': mv,
    'rtype': rtype,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Ar {
  int id;
  String name;


  Ar({
    this.id,
    this.name,
  });

  factory Ar.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> tns = jsonRes['tns'] is List ? [] : null;
    if (tns != null) {
      for (var item in jsonRes['tns']) {
        if (item != null) {
          tns.add(item);
        }
      }
    }

    List<String> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }

    List<String> alia = jsonRes['alia'] is List ? [] : null;
    if (alia != null) {
      for (var item in jsonRes['alia']) {
        if (item != null) {
          alia.add(item);
        }
      }
    }
    return Ar(
      id: convertValueByType(jsonRes['id'], int, stack: "Ar-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Ar-name"),

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Al {
  int id;
  String name;
  String picUrl;

  Al({
    this.id,
    this.name,
    this.picUrl,
  });

  factory Al.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> tns = jsonRes['tns'] is List ? [] : null;
    if (tns != null) {
      for (var item in jsonRes['tns']) {
        if (item != null) {
          tns.add(item);
        }
      }
    }
    return Al(
      id: convertValueByType(jsonRes['id'], int, stack: "Al-id"),
      name: convertValueByType(jsonRes['name'], String, stack: "Al-name"),
      picUrl: convertValueByType(jsonRes['picUrl'], String, stack: "Al-picUrl"),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'picUrl': picUrl,

  };

  @override
  String toString() {
    return json.encode(this);
  }
}
class PlayList {
  String moreText;
  bool more;
  List<PlayLists> playLists;

  PlayList({
    this.moreText,
    this.more,
    this.playLists,
  });

  factory PlayList.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<PlayLists> playLists = jsonRes['playLists'] is List ? [] : null;
    if (playLists != null) {
      for (var item in jsonRes['playLists']) {
        if (item != null) {
          playLists.add(PlayLists.fromJson(item));
        }
      }
    }

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          resourceIds.add(item);
        }
      }
    }
    return PlayList(
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "PlayList-moreText"),
      more: convertValueByType(jsonRes['more'], bool, stack: "PlayList-more"),
      playLists: playLists,
    );
  }

  Map<String, dynamic> toJson() => {
    'moreText': moreText,
    'more': more,
    'playLists': playLists,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class PlayLists {
  int id;
  String name;
  String coverImgUrl;
  Creator creator;
  int trackCount;
  int userId;
  int playCount;
  int bookCount;
  Track track;

  PlayLists({
    this.id,
    this.name,
    this.coverImgUrl,
    this.creator,
    this.trackCount,
    this.userId,
    this.playCount,
    this.track,
  });

  factory PlayLists.fromJson(jsonRes) => jsonRes == null
      ? null
      : PlayLists(
    id: convertValueByType(jsonRes['id'], int, stack: "PlayLists-id"),
    name: convertValueByType(jsonRes['name'], String,
        stack: "PlayLists-name"),
    coverImgUrl: convertValueByType(jsonRes['coverImgUrl'], String,
        stack: "PlayLists-coverImgUrl"),
    creator: Creator.fromJson(jsonRes['creator']),
    trackCount: convertValueByType(jsonRes['trackCount'], int,
        stack: "PlayLists-trackCount"),
    userId: convertValueByType(jsonRes['userId'], int,
        stack: "PlayLists-userId"),
    playCount: convertValueByType(jsonRes['playCount'], int,
        stack: "PlayLists-playCount"),
    track: Track.fromJson(jsonRes['track']),

  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'coverImgUrl': coverImgUrl,
    'creator': creator,
    'trackCount': trackCount,
    'userId': userId,
    'playCount': playCount,
    'bookCount': bookCount,
    'track': track,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Creator {
  String nickname;
  int userId;

  Creator({
    this.nickname,
    this.userId,
  });

  factory Creator.fromJson(jsonRes) => jsonRes == null
      ? null
      : Creator(
    nickname: convertValueByType(jsonRes['nickname'], String,
        stack: "Creator-nickname"),
    userId: convertValueByType(jsonRes['userId'], int,
        stack: "Creator-userId"),
  );

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'userId': userId,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Track {
  String name;
  int id;
  List<Artists> artists;
  Album album;
  Track({
    this.name,
    this.id,
    this.artists,
    this.album,
  });

  factory Track.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }

    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          artists.add(Artists.fromJson(item));
        }
      }
    }

    List<Object> rtUrls = jsonRes['rtUrls'] is List ? [] : null;
    if (rtUrls != null) {
      for (var item in jsonRes['rtUrls']) {
        if (item != null) {
          rtUrls.add(item);
        }
      }
    }
    return Track(
      name: convertValueByType(jsonRes['name'], String, stack: "Track-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Track-id"),
      artists: artists,
      album: Album.fromJson(jsonRes['album']),

    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,

    'artists': artists,
    'album': album,

  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Artists {
  String name;
  int id;
  String picUrl;
  int accountId;

  Artists({
    this.name,
    this.id,

    this.picUrl,
    this.accountId,
  });

  factory Artists.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }
    return Artists(
      name: convertValueByType(jsonRes['name'], String, stack: "Artists-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artists-id"),
      picUrl: convertValueByType(jsonRes['picUrl'], String,
          stack: "Artists-picUrl"),

      accountId: convertValueByType(jsonRes['accountId'], int,
          stack: "Artists-accountId"),


    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'picUrl': picUrl,
    'accountId': accountId,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
class Album {
  String name;
  String moreText;
  int id;
  String picUrl;
  List<Artists> artists;
  List<Albums> albums;

  Album({
    this.name,
    this.moreText,
    this.id,
    this.picUrl,
    this.artists,
    this.albums
  });

  factory Album.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> songs = jsonRes['songs'] is List ? [] : null;
    if (songs != null) {
      for (var item in jsonRes['songs']) {
        if (item != null) {
          songs.add(item);
        }
      }
    }
    List<Albums> albums = jsonRes['albums'] is List ? []: null;
    if(albums!=null) {
      for (var item in jsonRes['albums']) { if (item != null) { albums.add(Albums.fromJson(item));  }
      }
    }
    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }

    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          artists.add(Artists.fromJson(item));
        }
      }
    }
    return Album(
      name: convertValueByType(jsonRes['name'], String, stack: "Album-name"),
      moreText: convertValueByType(jsonRes['moreText'], String, stack: "Album-moreText"),
      id: convertValueByType(jsonRes['id'], int, stack: "Album-id"),
      picUrl:
      convertValueByType(jsonRes['picUrl'], String, stack: "Album-picUrl"),
      albums: albums,
      artists: artists,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'moreText': moreText,
    'id': id,
    'picUrl': picUrl,
    'artists': artists,
    'albums': albums,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
class Artist {
  String name;
  int id;
  String moreText;
  List<Artists> artists;
  Artist(
      {this.name,
        this.id,
        this.moreText,
        this.artists});

  factory Artist.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }
    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          artists.add(Artists.fromJson(item));
        }
      }
    }
    return Artist(
      name: convertValueByType(jsonRes['name'], String, stack: "Artist-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Artist-id"),

      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "Artist-moreText"),

      artists: artists,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'artists': artists,
    'moreText': moreText,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
class Albums {
  String name;
  int id;
  String blurPicUrl;
  int publishTime;
  Artist artist;
  List<Artists> artists;

  Albums({
    this.name,
    this.id,
    this.blurPicUrl,
    this.publishTime,
    this.artist,
    this.artists,
  });

  factory Albums.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Object> alias = jsonRes['alias'] is List ? [] : null;
    if (alias != null) {
      for (var item in jsonRes['alias']) {
        if (item != null) {
          alias.add(item);
        }
      }
    }

    List<Artists> artists = jsonRes['artists'] is List ? [] : null;
    if (artists != null) {
      for (var item in jsonRes['artists']) {
        if (item != null) {
          artists.add(Artists.fromJson(item));
        }
      }
    }
    return Albums(
      name: convertValueByType(jsonRes['name'], String, stack: "Albums-name"),
      id: convertValueByType(jsonRes['id'], int, stack: "Albums-id"),

      blurPicUrl: convertValueByType(jsonRes['blurPicUrl'], String,
          stack: "Albums-blurPicUrl"),

      publishTime: convertValueByType(jsonRes['publishTime'], int,
          stack: "Albums-publishTime"),

      artist: Artist.fromJson(jsonRes['artist']),

      artists: artists,

    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'blurPicUrl': blurPicUrl,
    'publishTime': publishTime,
    'artist': artist,
    'artists': artists,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class SimQuery {
  List<SimQuerys> sim_querys;
  bool more;

  SimQuery({
    this.sim_querys,
    this.more,
  });

  factory SimQuery.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<SimQuerys> sim_querys = jsonRes['sim_querys'] is List ? [] : null;
    if (sim_querys != null) {
      for (var item in jsonRes['sim_querys']) {
        if (item != null) {
          sim_querys.add(SimQuerys.fromJson(item));
        }
      }
    }
    return SimQuery(
      sim_querys: sim_querys,
      more: convertValueByType(jsonRes['more'], bool, stack: "SimQuery-more"),
    );
  }

  Map<String, dynamic> toJson() => {
    'sim_querys': sim_querys,
    'more': more,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class SimQuerys {
  String keyword;

  SimQuerys({
    this.keyword,
  });

  factory SimQuerys.fromJson(jsonRes) => jsonRes == null
      ? null
      : SimQuerys(
    keyword: convertValueByType(jsonRes['keyword'], String,
        stack: "SimQuerys-keyword"),

  );

  Map<String, dynamic> toJson() => {
    'keyword': keyword,

  };

  @override
  String toString() {
    return json.encode(this);
  }
}



class User {
  String moreText;
  List<Users> users;

  User({
    this.moreText,
    this.users,

  });

  factory User.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Users> users = jsonRes['users'] is List ? [] : null;
    if (users != null) {
      for (var item in jsonRes['users']) {
        if (item != null) {
          users.add(Users.fromJson(item));
        }
      }
    }

    List<int> resourceIds = jsonRes['resourceIds'] is List ? [] : null;
    if (resourceIds != null) {
      for (var item in jsonRes['resourceIds']) {
        if (item != null) {
          resourceIds.add(item);
        }
      }
    }
    return User(
      moreText: convertValueByType(jsonRes['moreText'], String,
          stack: "User-moreText"),
      users: users,
    );
  }

  Map<String, dynamic> toJson() => {
    'moreText': moreText,
    'users': users,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Users {
  String avatarUrl;
  String nickname;
  String description;

  Users({

    this.avatarUrl,

    this.nickname,

    this.description,
  });

  factory Users.fromJson(jsonRes) => jsonRes == null
      ? null
      : Users(
    avatarUrl: convertValueByType(jsonRes['avatarUrl'], String,
        stack: "Users-avatarUrl"),
    nickname: convertValueByType(jsonRes['nickname'], String,
        stack: "Users-nickname"),
    description: convertValueByType(jsonRes['description'], String,
        stack: "Users-description"),

  );

  Map<String, dynamic> toJson() => {
    'avatarUrl': avatarUrl,
    'nickname': nickname,
    'description': description,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}
