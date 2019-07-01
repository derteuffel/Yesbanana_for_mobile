
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/BibliothequeSearchLivrePage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';
var _list=[];
class BibliothequeSearchLivrePageState extends State<BibliothequeSearchLivrePage>{
  int index = 0;
  var _livreUrl= Const.SERVER_URL_LIVRE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Rechercher un livre'),
      ),
      body: BibliothequeSearchLivreBody(),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    HttpRequest.getJson(_livreUrl)
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
class BibliothequeSearchLivreBody extends StatelessWidget {

  //Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
    var spacecrafts = [
        "James Web",
        "Enterprise",
        "Hubble",
        "Kepler",
        "Juno",
        "Casini",
        "Columbia",
        "Challenger",
        "Huygens",
        "Galileo",
        "Apollo",
        "Spitzer",
        "WMAP",
        "Swift",
        "Atlantis"
      ];
      return new GridView.builder(
        itemCount: _list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                        _list[index]["couverture"]==null?"https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg" : Const.SERVER_URL+ _list[index]["couverture"],
                        fit: BoxFit.cover
                    )
                ),
                Positioned(
                    left: 10.5,
                    bottom: 15,
                    right:10.5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(_list[index]["title"]==null?"Non définie" : _list[index]["title"],
                                  style: new TextStyle(fontSize: 22, color: Colors.white)),
                              new Text(_list[index]["auteur"]==null?"Non définie" : _list[index]["auteur"],
                                  style: new TextStyle(fontSize: 16, color: Colors.white))
                            ],
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        },
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


