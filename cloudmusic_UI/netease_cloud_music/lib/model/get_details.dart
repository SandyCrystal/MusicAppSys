class GetData {
  num _code;
  String _data;

  GetData({num code, String data}) {
    this._code = code;
    this._data = data;
  }

  num get code => _code;

  set code(num code) => _code = code;

  String get data => _data;

  set data(String data) => _data = data;

  GetData.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['data'] = this._data;
    return data;
  }
}