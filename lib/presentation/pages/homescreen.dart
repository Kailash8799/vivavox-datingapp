import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivavox/presentation/pages/homesubscreen/homesubscreen.dart';
import 'package:vivavox/presentation/pages/homesubscreen/likessubscreen.dart';
import 'package:vivavox/presentation/pages/homesubscreen/messagessubscreen.dart';
import 'package:vivavox/presentation/pages/homesubscreen/profilesubscreen.dart';
import 'package:vivavox/presentation/pages/loginscreen.dart';
import 'package:vivavox/presentation/widgets/animation/pagetransaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _pageController = PageController();
  void changeIndex(ind) {
    setState(() {
      _index = ind;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> _pages = const <Widget>[
    HomesubScreen(),
    LikessubScreen(),
    MessagesubScreen(),
    ProfilesubScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Vivavox",
          style: TextStyle(color: Color(0xFFFE3C72), fontFamily: "Ubuntu"),
        ),
        leading: const Icon(
          CupertinoIcons.star_fill,
          color: Color(0xFFFE3C72),
        ),
        // automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: _index == 0
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).push(NoAnimationTransition(
                          builder: (context) => const LoginScreen()));
                    },
                    icon: const Icon(
                      CupertinoIcons.bell_solid,
                      color: Color(0xFFFE3C72),
                    ),
                  )
                : const Text(""),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
            // _pageController.animateToPage(
            //   value,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.linear,
            // );
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            tooltip: "Home",
            icon: Icon(
              CupertinoIcons.star,
              color: Color.fromRGBO(112, 111, 111, 1),
            ),
            activeIcon: Icon(
              CupertinoIcons.star_fill,
              color: Color(0xFFFE3C72),
            ),
          ),
          BottomNavigationBarItem(
            label: "Likes",
            tooltip: "Likes you",
            icon: Icon(
              CupertinoIcons.heart,
              size: 30,
              color: Color.fromRGBO(112, 111, 111, 1),
            ),
            activeIcon: Icon(
              CupertinoIcons.heart_fill,
              size: 30,
              color: Color(0xFFFE3C72),
            ),
          ),
          BottomNavigationBarItem(
            label: "Messages",
            tooltip: "Messages",
            icon: Icon(
              CupertinoIcons.chat_bubble,
              size: 30,
              color: Color.fromRGBO(112, 111, 111, 1),
            ),
            activeIcon: Icon(
              CupertinoIcons.chat_bubble_fill,
              size: 30,
              color: Color(0xFFFE3C72),
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            tooltip: "Profile",
            icon: Icon(
              CupertinoIcons.person,
              size: 28,
              color: Color.fromRGBO(112, 111, 111, 1),
            ),
            activeIcon: Icon(
              CupertinoIcons.person_solid,
              size: 28,
              color: Color(0xFFFE3C72),
            ),
          ),
        ],
      ),
      // body: PageView(
      //   physics: const NeverScrollableScrollPhysics(),
      //   controller: _pageController,
      //   onPageChanged: changeIndex,
      //   children: _pages,
      // ),

      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
    );
  }
}
