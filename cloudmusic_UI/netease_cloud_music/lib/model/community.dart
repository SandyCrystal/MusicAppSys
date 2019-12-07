
import 'com_dynamic.dart';

class CommunityData {
  num dynamic_id;
  User user;
  String content;
  String create_time;
  String pic_url;
  int like_count;
  bool isliked;
  CommunityData({
    this.dynamic_id,
    this.user,
    this.content,
    this.create_time,
    this.pic_url,
    this.like_count,
    this.isliked
  });
}