import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  void changeIndex(ind) {
    setState(() {
      _index = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: changeIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "df",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "d",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "d",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "d",
          ),
        ],
      ),
    );
  }
}
