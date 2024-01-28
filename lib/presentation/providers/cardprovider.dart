import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

enum CardStatus { like, dislike, superlike }

class CardProvider extends ChangeNotifier {
  final List<Profileinfo> _profileDetails = [];
  String _email = "";
  int _profilefetchcount = 0;
  bool _profilefetching = false;
  bool _isDragging = false;
  bool _isLike = false;
  bool _isdisLike = false;
  bool _issuperLike = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  List<Profileinfo> get profileDetails => _profileDetails;
  bool get isDragging => _isDragging;
  bool get isProfilefetching => _profilefetching;
  bool get isLike => _isLike;
  bool get isDisLike => _isdisLike;
  bool get isSuperLike => _issuperLike;
  Offset get position => _position;
  double get angle => _angle;
  String get email => _email;
  // CardProvider() {
  //   initialize();
  // }

  void setMail({required String email}) {
    _email = email;
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;
    const delta = 20;
    if (x >= delta) {
      _isLike = true;
      _issuperLike = false;
      _isdisLike = false;
    } else if (x <= -delta) {
      _isdisLike = true;
      _isLike = false;
      _issuperLike = false;
    } else if (y <= -delta / 2 && forceSuperLike) {
      _issuperLike = true;
      _isLike = false;
      _isdisLike = false;
    } else {
      _issuperLike = false;
      _isLike = false;
      _isdisLike = false;
    }
    notifyListeners();
  }

  void endPosition() async {
    _isDragging = false;
    _isLike = false;
    _isdisLike = false;
    _issuperLike = false;
    notifyListeners();
    final status = getStatus();
    if (status != null) {
      debugPrint(status.toString());
      // final check = status.toString().split('.').last.toUpperCase();
      // Fluttertoast.cancel();
      // Fluttertoast.showToast(
      //   msg: check,
      //   fontSize: 36,
      // );
      try {} catch (e) {
        debugPrint('Eror while creating record:$e');
      }
    }
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superlike:
        superlike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  double getStatusOpacity() {
    const detla = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / detla;
    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;
    if (force) {
      const delta = 20;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= (-1.4 * delta) && forceSuperLike) {
        return CardStatus.superlike;
      }
    } else {
      const delta = 100;
      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.dislike;
      } else if (y <= (-1.4 * delta) && forceSuperLike) {
        return CardStatus.superlike;
      }
    }
    return null;
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextProfile();
    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextProfile();
    notifyListeners();
  }

  void superlike() {
    _angle = 0;
    _position -= Offset(0, 2 * _screenSize.height);
    _nextProfile();
    notifyListeners();
  }

  Future _nextProfile() async {
    if (_profileDetails.length == 1) _loadMoreProfile();
    await Future.delayed(const Duration(milliseconds: 200));
    if (_profileDetails.isNotEmpty) _profileDetails.removeLast();
    resetPosition();
  }

  void initialize() {
    _loadMoreProfile();
  }

  void _loadMoreProfile() async {
    try {
      if (!_profilefetching) {
        _profilefetching = true;
        notifyListeners();
        Map<String, dynamic> res =
            await AuthUser().getAllProfile(email: _email);
        if (res["success"]) {
          List<dynamic> dynamicProfileList = res["profile"];
          List<Profileinfo> profileList = dynamicProfileList
              .map((x) => Profileinfo.fromJson(x))
              .toList()
              .cast<Profileinfo>();
          _profileDetails.insertAll(0, profileList);
          _profilefetchcount++;
          _profilefetching = false;
          notifyListeners();
        }
      }
    } catch (e) {
      _profilefetching = false;
      notifyListeners();
    }
  }

  void resetProfiles() async {
    _profileDetails.removeRange(0, _profileDetails.length);
  }
}
