import 'package:flutter/material.dart';
import 'package:pit_stop/TypeFood.dart';
import './LunchRequest.dart';
import './AppInformation.dart';

class CardPage extends StatefulWidget {
  final AppInformation appInfo;

  CardPage(this.appInfo);

  CardPageState createState() => new CardPageState();
}

class CardPageState extends State<CardPage> {
  final myController = TextEditingController();
  void onPressedConfirm(int card,context) {
    widget.appInfo.card = card;
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) => new typeFood(widget.appInfo, )));
  }

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
          TextFormField(
            controller: myController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Comanda",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                )),
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: 40,
            width: 160,
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
                      "Confirmar",
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
                onPressed: () => {
                  onPressedConfirm(int.parse(myController.text), context)
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
