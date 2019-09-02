

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/Boursepage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';
import 'package:mr_botton_navigation/main.dart';

var _list=[];
class BoursePageState extends State<Boursepage>{
  int index = 0;
  final _bourseUrl = Const.SERVER_URL_BOURSE;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BourseBody(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    HttpRequest.getJson(_bourseUrl)
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
class BourseBody extends StatelessWidget {

  //Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
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
                        child:new  Text(_list[index]["title"]==null?"Sans titre" : _list[index]["title"],
                          style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child:new Text(_list[index]["link"],
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text("Ouvrir",
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