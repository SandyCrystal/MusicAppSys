import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
    debugPrint("$stack : value is null");
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
  debugPrint("$stack : ${value.runtimeType} is not $type type");
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

class HotSearchData {
  int code;
  List<Data> data;

  HotSearchData({
    this.code,
    this.data,
  });

  factory HotSearchData.fromJson(jsonRes) {
    if (jsonRes == null) return null;

    List<Data> data = jsonRes['data'] is List ? [] : null;
    if (data != null) {
      for (var item in jsonRes['data']) {
        if (item != null) {
          data.add(Data.fromJson(item));
        }
      }
    }
    return HotSearchData(
      code:
          convertValueByType(jsonRes['code'], int, stack: "HotSearchData-code"),
      data: data,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Data {
  String searchWord;
  int score;
  String content;
  String iconUrl;
  Data({
    this.searchWord,
    this.score,
    this.content,
    this.iconUrl,
  });

  factory Data.fromJson(jsonRes) => jsonRes == null
      ? null
      : Data(
          searchWord: convertValueByType(jsonRes['searchWord'], String,
              stack: "Data-searchWord"),
          score: convertValueByType(jsonRes['score'], int, stack: "Data-score"),
          content: convertValueByType(jsonRes['content'], String,
              stack: "Data-content"),
          iconUrl: convertValueByType(jsonRes['iconUrl'], String,
              stack: "Data-iconUrl"),
        );

  Map<String, dynamic> toJson() => {
        'searchWord': searchWord,
        'score': score,
        'content': content,

        'iconUrl': iconUrl,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
