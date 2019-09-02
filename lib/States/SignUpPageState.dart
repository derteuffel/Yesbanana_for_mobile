import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';
import 'package:mr_botton_navigation/Pages/LoginPage.dart';
import 'package:mr_botton_navigation/Pages/SignUpPage.dart';
import 'package:mr_botton_navigation/Useful.dart';

class SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _register = false;

  @override
  void initState() {
    super.initState();
  }

  void stop() {
    setState(() {
      _register = false;
    });
  }

  Map buildSignUpObject(String name, String email, String phone, String country,
      String region, String password, String confirmPassword) {
    Map signUp = {
      "name": name,
      "email": email,
      "phone": phone,
      "country": country,
      "region": region,
      "password": password,
      "confirmPassword": confirmPassword
    };
    print(
        "name $name; email $email; phone $phone ; country $country ; region $region ; password $password ; confirmPassword $confirmPassword");
    return signUp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomPadding: true,
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
              child: _register
                  ? CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.cyan))
                  : null),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                  child: ListView(
                    children: <Widget>[
                      new Text(
                        "YesBanana",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                      new Padding(padding: EdgeInsets.only(top: 12.0)),
                      new Form(
                        child: new Theme(
                          data: new ThemeData(
                            brightness: Brightness.dark,
                            primarySwatch: Colors.cyan,
                            cursorColor: Colors.cyan,
                            inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan),
                              ),
                            ),
                          ),
                          child: new Column(
                            children: <Widget>[
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText:
                                        "Entrer votre nom(minimum 2 caractères)"),
                                keyboardType: TextInputType.text,
                                controller: _nameController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Entrer votre email"),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText:
                                        "Entrer votre numéro de téléphone"),
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Entrer votre pays"),
                                keyboardType: TextInputType.text,
                                controller: _countryController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Entrer votre region"),
                                keyboardType: TextInputType.text,
                                controller: _regionController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText:
                                        "Entrer votre mot de passe(minimum 6 caractères)"),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: _passwordController,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Confirmer votre mot de passe"),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                controller: _confirmPasswordController,
                              ),
                              new Padding(padding: EdgeInsets.only(top: 15.0)),
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
                                    _register = true;
                                    print("Circular Progress running");
                                  });
                                  HttpRequest.fetchJson(
                                          Const.SERVER_URL_REGISTER,
                                          buildSignUpObject(
                                              _nameController.text,
                                              _emailController.text,
                                              _phoneController.text,
                                              _countryController.text,
                                              _regionController.text,
                                              _passwordController.text,
                                              _confirmPasswordController.text))
                                      .then((response) {
                                    setState(() {
                                      _register = false;
                                    });
                                    Map body = json.decode(response.body);

                                    print(body);
                                    if (body["status"] == "true") {
                                      print("everything is ok");
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) => LoginPage(
                                                  text:
                                                      "Inscription reussite.")));
                                    } else {
                                      Useful.printMessage(
                                          "Veuillez verifier vos les informations entrées.");
                                    }
                                  }).catchError((error) {
                                    setState(() {
                                      _register = false;
                                      print("It's false");
                                    });
                                    Useful.printMessage(
                                        "Problème de connectivité. veuillez Réessayer.");
                                    return print("error");
                                  });
                                },
                                child: new Text("S'inscrire",
                                    style: new TextStyle(
                                      color: Colors.white,
                                    )),
                                splashColor: Colors.red,
                              ),
                              new Padding(padding: EdgeInsets.only(top: 15.0)),
                              new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text("Déja sur Yesbanana?",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    InkWell(
                                      child: Center(
                                        child: const Text(
                                          " Se Connecter",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


            ),
          )
        ],
      ),
    );
  }
}
