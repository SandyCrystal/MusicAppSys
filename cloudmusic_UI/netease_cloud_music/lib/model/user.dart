class User {
  int _code;
  String _msg;
  Account _account;

  User({int code, String msg, Account account}) {
    this._code = code;
    this._msg = msg;
    this._account = account;
  }

  int get code => _code;

  set code(int code) => _code = code;

  String get msg => _msg;

  set msg(String value) {
    _msg = value;
  }

  Account get account => _account;

  set account(Account account) => _account = account;

  User.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _msg = json['message'];
    _account = json['data'] != null ? new Account.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    if (this._account != null) {
      data['data'] = this._account.toJson();
    }

    return data;
  }
}

class Account {
  String _userid;
  String _userName;
  String _introduction;
  int _createTime;
  String _avatarUrl;
  int _userType;
  int _follow;
  int _fans;
  bool _isfollowed;
  int _dynamicSize;
  Account({
    String userid,
    String userName,
    int userType,
    String introduction,
    String avatarUrl,
    int createTime,
    String picUrl,
    int follow,
    int fans,
    bool isfollowed,
    int dynamicSize
  }) {
    this._fans=fans;
    this._follow=follow;
    this._userid = userid;
    this._userName = userName;
    this._userType = userType;
    this._createTime = createTime;
    this._avatarUrl = avatarUrl;
    this._introduction = introduction;
    this._isfollowed=isfollowed;
    this._dynamicSize=dynamicSize;
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

  int get createTime => _createTime;

  set createTime(int createTime) => _createTime = createTime;
  int get follow => _follow;

  set follow(int follow) => _follow = follow;

  int get fans => _fans;

  set fans(int fans) => _fans = fans;
  bool get isfollowed => _isfollowed;

  set isfollowed(bool isfollowed) => _isfollowed = isfollowed;
  int get dynamicSize => _dynamicSize;

  set dynamicSize(int dynamicSize) => _dynamicSize = dynamicSize;
  Account.fromJson(Map<String, dynamic> json) {
    _userid = json['user_id'];
    _userName = json['user_name'];
    _userType = json['user_type'];
    _avatarUrl = json['avatar_url'];
    _introduction = json['introduction'];
    _createTime = json['create_time'];
    _follow= json['follow'];
    _fans = json['fans'];
    _isfollowed=json['isfollowed'];
    _dynamicSize=json['dynamic_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this._userid;
    data['user_name'] = this._userName;
    data['user_type'] = this._userType;
    data['avatar_url'] = this.avatarUrl;
    data['introduction'] = this._introduction;
    data['create_time'] = this._createTime;
    data['follow'] = this._follow;
    data['fans'] = this._fans;
    data['isfollowed']=this._isfollowed;
    data['dynamic_size']=this._dynamicSize;
    return data;
  }
}
