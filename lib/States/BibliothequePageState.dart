

import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/BibliothequeSearchFacultyPage.dart';
import 'package:mr_botton_navigation/Pages/BibliothequeSearchLivrePage.dart';
import 'package:mr_botton_navigation/Pages/BibliothequeStudentWorkPage.dart';
import 'package:mr_botton_navigation/Pages/BibliothequeSyllabusPage.dart';
import 'package:mr_botton_navigation/Pages/Bibliothequepage.dart';

class BibliothequepageState extends State<Bibliothequepage>{
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BibliothequeBody(),
    );
  }
}

//This represents the Body. We show GridView in Body
class BibliothequeBody extends StatelessWidget {
BibliothequeBody({this.index,this.callback});
  final int index;
  final Function(int) callback;
    int itemId;


//Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
    var spacecrafts = ["Recherche un Livre","Rechercher un sujet","Syllabus","Travaux des étudiants"];
    var number=[1,2,3,4];

    return new GridView.builder(
        itemCount: spacecrafts.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: new EdgeInsets.only(top: 55, left: 5,right: 5),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 10,
                  child: Card(
                    elevation: 12,
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(150)),
                    child: Container(
                      width: 130,
                      height: 130,
                      padding: new EdgeInsets.fromLTRB(1.0, 40, 1.0, 45),
                      child: ListTile(title: Text(spacecrafts[index],
                        style: TextStyle(fontSize: 12.0, color: Colors.white,
                      ),
                        textAlign: TextAlign.center,
                      ),
                        onTap: (){
                          Navigator.of(context)
                              .push(MaterialPageRoute<Null>(builder: (BuildContext context){

                            print("je suis la");
                            print(index);
                            if(index==0)
                              return new BibliothequeSearchLivrePage(context);
                            else if(index==1)
                              return new BibliothequeSearchFacultyPage(context);
                            else if(index==2)
                              return new BibliothequeSyllabusPage(context);
                            else
                              return new BibliothequeStudentWorkPage(context);
                          }));
                        },
                      ),
                    ),
                  ),
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


