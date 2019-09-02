import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/Homepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mr_botton_navigation/Pages/LoginPage.dart';



class MyBottomNavBar extends StatelessWidget {
  MyBottomNavBar({this.index, this.callback});

  final int index;
  final Function(int) callback;

  @override
  Widget build(BuildContext context) {
    /// BottomNavigationBar is automatically set to type 'fixed'
    /// when there are three of less items
    return CurvedNavigationBar(
      //currentIndex: index,
      onTap: callback,
      index: index,
      items: <Widget>[
        Icon(
          Icons.book,
          size: 30,
          color: Colors.cyan,
        ),
        Icon(
          Icons.layers,
          size: 30,
          color: Colors.cyan,
        ),
        Icon(
          Icons.face,
          size: 30,
          color: Colors.cyan,
        ),
        Icon(
          Icons.school,
          size: 30,
          color: Colors.cyan,
        ),
      ],
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Bottom Navigation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: LoginPage(context: context,));
  }
}

void main() => runApp(MyApp());
