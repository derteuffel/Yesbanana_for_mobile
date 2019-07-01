
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/ColoniePage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';

var _list=[];
class ColoniepageState extends State<Coloniepage>{
  int index = 0;

  final _colonieUrl=Const.SERVER_URL_COLONIES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColonieBody(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    HttpRequest.getJson(_colonieUrl)
        .then((response) {
      print("Getting bourses");
      print(response.body);
      setState((){
        _list = json.decode(response.body);
      });
    }).catchError((error) {
      print("Error");
      print(error);


    });
  }

}

//This represents the Body. We show GridView in Body
class ColonieBody extends StatelessWidget {

  //Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
    var spacecrafts = ["Poupée","Nounours","Bourses","delai de vacances"];
    return new GridView.builder(
        itemCount: _list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              elevation: 2,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

             child: Stack(
               alignment: Alignment.bottomCenter,
               children: <Widget>[
                 Image.network(_list[index]["fichier"][0]==null?"https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg" : _list[index]["fichier"][0],
                 fit: BoxFit.cover,
                   height: 351,
                 ),
                 Container(
                   color: Colors.black.withOpacity(0.5),
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text(_list[index]["title"]==null?"Sans titre" : _list[index]["title"], style: TextStyle(fontSize: 24,color: Colors.white)),
                       Text(_list[index]["site"]==null?"Sans titre" : _list[index]["site"], style: TextStyle(fontSize: 20,color: Colors.white)),
                     ],
                   ),
                 ),
               ],
             ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: createGridView(context),
      ),
    );
  }
}