import 'package:flutter/material.dart';

class Fullsizebutton extends StatelessWidget {
  const Fullsizebutton({super.key, title, onPress})
      : _title = title,
        _onPress = onPress;
  final String _title;
  final Function() _onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _onPress, child: Text(_title));
  }
}
