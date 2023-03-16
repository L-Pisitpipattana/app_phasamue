import 'package:app_phasamue/screens/camera.dart';
import 'package:app_phasamue/screens/dictionary.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  late final List<CameraDescription> cameras;
  int _selectedPageIndex = 0;

  void _selectedTabIndex(int index)
  {
    setState(() {
      _selectedPageIndex =index;
    });
  }

  final List<Widget> _pages = [
    Home(),
    //Camera(cameras: cameras),
    Dictionary(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTabIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 30.0,
        elevation: 15,
        selectedIconTheme: IconThemeData(size: 28.0),
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 16.0,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Settings",
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),*/
        ]
      ),
    );
  }
}
