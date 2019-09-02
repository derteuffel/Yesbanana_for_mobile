

import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/EducationPrimairePage.dart';
import 'package:mr_botton_navigation/Pages/EducationSecondairePage.dart';
import 'package:mr_botton_navigation/Pages/Educationpage.dart';

class EducationpageState extends State<Educationpage>{
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EducationBody(),
    );
  }

}

//This represents the Body. We show GridView in Body
class EducationBody extends StatelessWidget {

  //Create and Return GridView filled with our data
  Widget createGridView(BuildContext context) {
    var spacecrafts = ["Education primaire","Education secondaire"];
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
                  top: 30,
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
                              return new EducationPrimairePage(context);
                            else
                              return new EducationSecondairePage(context);
                          }));
                        },
                      ),
                    ),
                  ),
                )
              ],
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



