import 'package:flutter/cupertino.dart';
import 'package:netease_cloud_music/model/user.dart';

class AccountModel with ChangeNotifier  {
  User _user;
  AccountModel(this._user);

}