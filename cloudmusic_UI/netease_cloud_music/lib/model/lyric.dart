import 'dart:convert' show json;
import 'package:flutter/foundation.dart';


class Lyric{
  String lyric;
  Duration startTime;
  Duration endTime;
  double offset;

  Lyric(this.lyric, {this.startTime, this.endTime, this.offset});

  @override
  String toString() {
    return 'Lyric{lyric: $lyric, startTime: $startTime, endTime: $endTime}';
  }

}


dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
//    debugPrint("$stack : value is null");
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

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint("$e");
    debugPrint("$stack");
  }
}

class LyricData {
  String lrc;
  int code;

  LyricData({
    this.lrc,
    this.code,
  });

  factory LyricData.fromJson(jsonRes) => jsonRes == null
      ? null
      : LyricData(
    lrc: convertValueByType(jsonRes['lyric'], String, stack: "LyricData-lyric"),
    code:
    convertValueByType(jsonRes['code'], int, stack: "LyricData-code"),
  );

  Map<String, dynamic> toJson() => {
    'lyric': lrc,
    'code': code,
  };

  @override
  String toString() {
    return json.encode(this);
  }
}






