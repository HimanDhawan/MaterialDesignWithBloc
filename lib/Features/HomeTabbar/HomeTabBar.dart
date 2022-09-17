import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttersample/Features/Movie/MovieScreen.dart';

import '../MyCreatedList/ui/MyCreatedList.dart';

class HomeTabBar extends StatefulWidget {
  final String sessionID;

  const HomeTabBar({Key? key, required this.sessionID}) : super(key: key);
  static List<Widget> list = [MovieScreen(), MyCreatedList()];
  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Movies"),
      ),
      body: HomeTabBar.list.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_outlined), label: "Movies"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "My List")
          ]),
    );
  }
}
