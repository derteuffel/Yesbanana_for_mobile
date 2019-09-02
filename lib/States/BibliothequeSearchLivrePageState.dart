
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mr_botton_navigation/Pages/BibliothequeSearchLivrePage.dart';
import 'package:mr_botton_navigation/Const.dart';
import 'package:mr_botton_navigation/HttpRequest.dart';
var _list=new List();
String _searchText="";
var _filteredElements=new List();
class BibliothequeSearchLivrePageState extends State<BibliothequeSearchLivrePage>{
  int index = 0;
  var _livreUrl= Const.SERVER_URL_LIVRE;
  Widget _appBarText= new Text("Bibliotheque");
  var titles=new List();



  // controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests


  Icon search=new Icon(Icons.search);


  BibliothequeSearchLivrePageState(){

    _filter.addListener((){
      if(_filter.text.isEmpty){
        setState(() {
          _searchText="";
          _filteredElements=_list;
        });
      }else{
        setState(() {
          _searchText=_filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: _appBarText,
        leading: new IconButton(icon: search, onPressed: _searchPressed),
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
        _filteredElements=_list;
      });
    }).catchError((error) {
      print("Error");
      print(error);


    });
  }

  void _searchPressed() {
    setState(() {
      if (this.search.icon == Icons.search) {
        this.search = new Icon(Icons.close);
        this._appBarText = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Search...'
          ),
        );
      } else {
        this.search = new Icon(Icons.search);
        this._appBarText = new Text('Bibliotheque');
        _filteredElements = _list;
        _filter.clear();
      }
    });
  }

}


//This represents the Body. We show GridView in Body
class BibliothequeSearchLivreBody extends StatelessWidget {

  //Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
    if(!(_searchText.isEmpty)){
      print(_filteredElements);
      print("je suis la");
      List tempList=new List();
      for(int i= 0; i<_filteredElements.length; i++){
        if(_filteredElements[i]['title'].toString().toLowerCase().contains(_searchText.toLowerCase())){
          tempList.add(_filteredElements[i]);
        }
      }
      _filteredElements=tempList;
    }else{
      _filteredElements=_list;
    }
      return new GridView.builder(
        itemCount: _filteredElements.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                        _filteredElements[index]["couverture"]==null?"https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg" : Const.SERVER_URL+ _filteredElements[index]["couverture"],
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
                              new Text(_filteredElements[index]["title"]==null?"Non définie" : _filteredElements[index]["title"],
                                  style: new TextStyle(fontSize: 22, color: Colors.white)),
                              new Text(_filteredElements[index]["auteur"]==null?"Non définie" : _filteredElements[index]["auteur"],
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


