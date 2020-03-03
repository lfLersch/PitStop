import 'package:flutter/material.dart';
import './menu.page.dart';
import './AppInformation.dart';

class LoginPage extends StatelessWidget {
  AppInformation appInfo = AppInformation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo.png")
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Login",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  )),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3,1],
                    colors: [
                      Colors.deepOrange,
                      Colors.orangeAccent,
                    ],

                  ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                          "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,),
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
                      new MaterialPageRoute(builder: (context) => new HomePage(appInfo))),


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
