
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/BibliothequeSearchFacultyPage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';

var _list=[];
class BibliothequeSearchFacultyPageState extends State<BibliothequeSearchFacultyPage>{
  int index = 0;
  final _thesesUrl=Const.SERVER_URL_THESES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Rechercher un livre par faculté'),
      ),
      body: BibliothequeSearchFacultyBody(),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    HttpRequest.getJson(_thesesUrl)
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
class BibliothequeSearchFacultyBody extends StatelessWidget {

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
    return new ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(_list[index]["student"]==null?"Non définie" : _list[index]["student"],
                          style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(_list[index]["subject"]==null?"Non définie" : _list[index]["subject"],
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("theseDate",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.chevron_right,
                            size: 35.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
            ],
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