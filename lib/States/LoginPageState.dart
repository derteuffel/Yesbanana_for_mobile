import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/Bibliothequepage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/Pages/Homepage.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';
import 'package:mr_botton_navigation/Pages/LoginPage.dart';
import 'package:mr_botton_navigation/Pages/SignUpPage.dart';
import 'package:mr_botton_navigation/Useful.dart';

class LoginPageState extends State<LoginPage> {
  final _connexionUrl = Const.SERVER_URL_CONNECTION;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  String text = "";
  bool _connecting = false;
  LoginPageState(this.text) : super();

  @override
  void initState() {
    super.initState();
  }

  void stop() {
    setState(() {
      _connecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
            color: Colors.grey,
            colorBlendMode: BlendMode.darken,
          ),
          Center(
              child: _connecting
                  ? CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white))
                  : null),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: text == null
                          ? null
                          : Text(text, style: TextStyle(color: Colors.red)),
                    ),
                    new Text(
                      "YesBanana",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 32.0)),
                    new Form(
                      child: new Theme(
                        data: new ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch: Colors.cyan,
                          cursorColor: Colors.cyan,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              )),
                        ),
                        child: new Column(
                          children: <Widget>[
                            new TextFormField(
                              controller: _loginController,
                              decoration: new InputDecoration(
                                labelText: "Entrer votre login",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            new TextFormField(
                              controller: _passwordController,
                              decoration: new InputDecoration(
                                  labelText: "Entrer votre mot de passe"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),
                            new MaterialButton(
                              color: Colors.cyan,
                              textColor: Colors.white,
                              height: 45.0,
                              minWidth: 60.0,
                              onPressed: () {
                                Future.delayed(const Duration(seconds: 10))
                                    .then((_) {
                                  stop();
                                });
                                setState(() {
                                  _connecting = true;
                                  print("it's true");
                                });
                                print(_loginController.text);
                                Map credentials = {
                                  "login": _loginController.text,
                                  "password": _passwordController.text
                                };
                                HttpRequest.fetchJson(
                                        _connexionUrl, credentials)
                                    .then((response) {
                                  setState(() {
                                    _connecting = false;
                                  });
                                  Map body = json.decode(response.body);

                                  print(body);
                                  if (body["status"] == "true") {
                                    print("everything is ok");
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                new Homepage()));
                                  } else {
                                    Useful.printMessage(
                                        "Login ou mot de passe incorrect.");
                                  }
                                }).catchError((error) {
                                  setState(() {
                                    _connecting = false;
                                    print("It's false");
                                  });
                                  Useful.printMessage(
                                      "Problème de connectivité. veuillez Réessayer.");
                                  return print("error");
                                });
                              },
                              child: new Text("Se connecter",
                                  style: new TextStyle(
                                    color: Colors.white,
                                  )),
                              splashColor: Colors.red,
                            ),
                            new Padding(padding: EdgeInsets.only(top: 30.0)),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: const Text(
                                      "pas encore sur Yesbanana?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  InkWell(
                                      child: const Text(
                                        " S'inscrire",
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpPage(context),
                                          ))),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
