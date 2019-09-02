import 'package:flutter/cupertino.dart';
import 'package:mr_botton_navigation/States/LoginPageState.dart';

class LoginPage extends StatefulWidget{
  String text ="";

  final BuildContext context;
  LoginPage({Key key , this.text,this.context}) : super(key: key);
  @override
  createState() => LoginPageState(text);
}