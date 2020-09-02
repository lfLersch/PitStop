import 'package:flutter/material.dart';
import './LunchRequest.dart';
import './AppInformation.dart';

class typeFood extends StatelessWidget {
  final AppInformation appInfo;
  const typeFood(this.appInfo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 180,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.indigo,
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Xis",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      /*Container(
                        child: SizedBox(
                          child: Image.asset("caminho"),
                          height: 20,
                          width: 20,
                        ),
                      )*/
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) => new nrLunch(appInfo, 1))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Hamburguers",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      /*Container(
                        child: SizedBox(
                          child: Image.asset("caminho"),
                          height: 20,
                          width: 20,
                        ),
                      )*/
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) => new nrLunch(appInfo, 2))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Bebidas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      /*Container(
                        child: SizedBox(
                          child: Image.asset("caminho"),
                          height: 20,
                          width: 20,
                        ),
                      )*/
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) => new nrLunch(appInfo, 3))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Outros",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      /*Container(
                        child: SizedBox(
                          child: Image.asset("caminho"),
                          height: 20,
                          width: 20,
                        ),
                      )*/
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) => new nrLunch(appInfo, 4))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
