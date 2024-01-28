import 'package:flutter/material.dart';

class StatusProvider extends ChangeNotifier {
  bool _profileimageupdating = false;
  bool _imageaddingdeleting = false;
  bool get profileimageupdating => _profileimageupdating;
  bool get imageaddingdeleting => _imageaddingdeleting;

  void setProfileimageupdating({required bool status}) {
    _profileimageupdating = status;
    notifyListeners();
  }

  void setImageDeleting({required bool status}) {
    _imageaddingdeleting = status;
    notifyListeners();
  }
}
