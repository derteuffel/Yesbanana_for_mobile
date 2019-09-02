
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_botton_navigation/Pages/EducationSecondairePage.dart';

class EducationSecondairePageState extends State<EducationSecondairePage>{
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Education Secondaire'),
      ),
      body: EducationSecondaireBody(),
    );
  }



}
//This represents the Body. We show GridView in Body
class EducationSecondaireBody extends StatelessWidget {

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
      itemCount: spacecrafts.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 8,
            color: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              height: 200,
              child: ListTile(
                title: Text(
                  spacecrafts[index],
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  textAlign: TextAlign.end,
                ),
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      child: new CupertinoAlertDialog(
                        title: new Column(
                          children: <Widget>[
                            new Text("GridView"),
                            new Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        content: new Text(spacecrafts[index]),
                        actions: <Widget>[
                          new FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: new Text("OK"))
                        ],
                      ));
                },
              ),
            ),
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