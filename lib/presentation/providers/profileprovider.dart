import 'package:flutter/material.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class ProfileProvider extends ChangeNotifier {
  Profileinfo? _profileinfo;
  Profileinfo? get profile => _profileinfo;
  void addProfile({required Profileinfo profileinfo}) {
    _profileinfo = profileinfo;
    notifyListeners();
  }
}
