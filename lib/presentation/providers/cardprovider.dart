import 'dart:math';

import 'package:flutter/material.dart';

enum CardStatus { like, dislike, superlike }

class CardProvider extends ChangeNotifier {
  List<String> _assetImages = [];
  bool _isDragging = false;
  bool _isLike = false;
  bool _isdisLike = false;
  bool _issuperLike = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  List<String> get assetImages => _assetImages;
  bool get isDragging => _isDragging;
  bool get isLike => _isLike;
  bool get isDisLike => _isdisLike;
  bool get isSuperLike => _issuperLike;
  Offset get position => _position;
  double get angle => _angle;
  CardProvider() {
    initialize();
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
    _nextImage();
    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextImage();
    notifyListeners();
  }

  void superlike() {
    _angle = 0;
    _position -= Offset(0, 2 * _screenSize.height);
    _nextImage();
    notifyListeners();
  }

  Future _nextImage() async {
    if (_assetImages.length == 10) _loadMoreProfile();
    await Future.delayed(const Duration(milliseconds: 200));
    _assetImages.removeLast();
    resetPosition();
  }

  void initialize() {
    userimages();
  }

  void _loadMoreProfile() {
    _assetImages.insertAll(0, [
      'https://images.unsplash.com/photo-1631947430066-48c30d57b943?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fGJlYXV0aWZ1bCUyMGdpcmx8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1631204286910-cdf207d2e75b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1631204286856-a77f37bdce63?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTh8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1582639590011-f5a8416d1101?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1568819317551-31051b37f69f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1581588636584-5c447d2c9d97?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1594590438588-aadc19454cb0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1516726817505-f5ed825624d8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1544963151-fb47c1a06478?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/flagged/photo-1555992938-f45411cc33fd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1630568321790-65edcc51b544?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhvdCUyMGdpcmxzfGVufDB8fDB8fHww'
    ]);
    notifyListeners();
  }

  void userimages() async {
    _assetImages = <String>[
      'https://images.unsplash.com/photo-1631947430066-48c30d57b943?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjR8fGJlYXV0aWZ1bCUyMGdpcmx8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1631204286910-cdf207d2e75b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1631204286856-a77f37bdce63?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NTh8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1582639590011-f5a8416d1101?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1568819317551-31051b37f69f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1581588636584-5c447d2c9d97?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1594590438588-aadc19454cb0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8aG90JTIwYmlraW5pfGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1516726817505-f5ed825624d8?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1544963151-fb47c1a06478?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/flagged/photo-1555992938-f45411cc33fd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGhvdCUyMGJpa2luaXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1630568321790-65edcc51b544?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGhvdCUyMGdpcmxzfGVufDB8fDB8fHww'
    ].toList();
    notifyListeners();
  }
}
