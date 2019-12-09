class Deleted {
  num _code;
  String _type;

  PlayListData({num code, String type}) {
    this._code = code;
    this._type = type;
  }

  num get code => _code;
  set code(num code) => _code = code;
  String get type => _type;
  set type(String type) => _type = type;

  Deleted.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _type = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['data'] = this._type;
    return data;
  }
}
