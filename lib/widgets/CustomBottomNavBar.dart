import 'package:app_phasamue/screens/camera.dart';
import 'package:app_phasamue/screens/capimg.dart';
import 'package:app_phasamue/screens/category.dart';
import 'package:app_phasamue/screens/dictionary.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:app_phasamue/screens/stream_camera.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MenuState {home, favourite, search}
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Colors.black;
    return Container(
      //height: 70,
      //padding: EdgeInsets.symmetric(vertical: 14),
      padding: EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            /*offset: Offset(8, 10),
            blurRadius: 20,*/
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
        /*borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),*/
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                      color: MenuState.home == selectedMenu
                          ? Colors.pink
                          : inActiveIconColor,
                      //semanticsLabel: 'หน้าหลัก',
                    ),
                    onPressed: () =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            )
                        )
                  ),
                  Text('หน้าหลัก',style: TextStyle(color: MenuState.home == selectedMenu
                      ? Colors.pink
                      : inActiveIconColor,),)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/camera.svg",
                      color: MenuState.search == selectedMenu
                          ? Colors.pink
                          : inActiveIconColor,
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (_) => Category()));
                    }
                  ),
                  Text('กล้อง',style: TextStyle(color: MenuState.search == selectedMenu
                      ? Colors.pink
                      : inActiveIconColor,),)
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/book-alt.svg",
                      color: MenuState.favourite == selectedMenu
                          ? Colors.pink
                          : inActiveIconColor,
                    ),
                    onPressed: () =>
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dictionary(),
                            )
                        )
                  ),
                  Text('พจนานุกรม',style: TextStyle(color: MenuState.favourite == selectedMenu
                      ? Colors.pink
                      : inActiveIconColor,),)
                ],
              ),
            ],
          )),
    );
  }
}