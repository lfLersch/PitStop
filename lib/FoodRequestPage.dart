import 'package:flutter/material.dart';
import './AppInformation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Food.dart';
import 'Request.dart';
import 'TypeFood.dart';

class FoodRequestPage extends StatefulWidget {
  final AppInformation appInfo;
  final Request request;

  FoodRequestPage(this.appInfo, this.request);

  FoodRequestState createState() => new FoodRequestState();
}

class FoodRequestState extends State<FoodRequestPage> {
  @override
  FoodRequestPage get widget => super.widget;
  bool checkboxValueExtra = false;
  List<Food> selectedExtras = [];

  @override
  Widget build(BuildContext context) {
    void onTapLunch(int id){
      showDialog(
          context: context,
          builder: (context) {
            return _MyDialog(
                id: id,
                card: widget.appInfo.card,
                extras: widget.appInfo.lists[5],
                selectedExtras: selectedExtras,
                onSelectedExtrasListChanged: (extras) {
                  selectedExtras = widget.appInfo.lists[5];
                });
          });
      //Navigator.pop(context);
      //Navigator.pop(context);
    }

    return Scaffold(
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.

          itemCount: widget.request.foodRequests.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.

          itemBuilder: (context, index) {
            //String key = widget.request.foodRequests.elementAt(index);
            var key =  widget.request.foodRequests.keys.elementAt(index);
            var item = widget.request.foodRequests[key];
            var value = item.food.value;
            var adicionais  = '';
            for(var r in widget.request.foodRequests[key].extras){
              adicionais = adicionais + r.name + '/';
              value += r.value;
            }
            return ListTile(
              title: Text(item.food.name),
              subtitle: Text(adicionais),
              trailing: Text('R\$ ' + value.toString()),
              //onTap: () => onTapLunch(item.id),
            );
          },
        ),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(
                    Icons.add
                ),
                onPressed: () {
                  widget.appInfo.card = widget.request.id;
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) => new typeFood(widget.appInfo, )));
                },
                heroTag: null,
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                child: Icon(
                    Icons.attach_money
                ),
                backgroundColor: Colors.green,
                onPressed: () => {},
                heroTag: null,
              )
            ]
        )

    );
  }
}

class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.id,
    this.card,
    this.extras,
    this.selectedExtras,
    this.onSelectedExtrasListChanged,
  });
  final int id;
  final int card;
  final List<Food> extras;
  final List<Food> selectedExtras;
  final ValueChanged<List<Food>> onSelectedExtrasListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<Food> _tempSelectedExtras = [];

  @override
  void initState() {
    _tempSelectedExtras = widget.selectedExtras;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onTapDialog () async{
      var url = "http://192.168.0.110/insertFoodRequest.php";
      List<int> ids = new List();

      ids.add(widget.id);
      ids.add(widget.card);

      _tempSelectedExtras.forEach((food) =>
          ids.add(food.id)
      );

      var jSonExtras = jsonEncode(ids) ;
      http.Response response =
      await http.post(url, body: jSonExtras);

      var dat = response.body.toString();
      var t = dat;

    }
    return Dialog(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ADICIONAIS',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.extras.length,
                itemBuilder: (BuildContext context, int index) {
                  final extra = widget.extras[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(extra.name),
                        subtitle: Text(extra.value.toString()),
                        value: _tempSelectedExtras.contains(extra),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedExtras.contains(extra)) {
                              setState(() {
                                _tempSelectedExtras.add(extra);
                              });
                            }
                          } else {
                            if (_tempSelectedExtras.contains(extra)) {
                              setState(() {
                                _tempSelectedExtras.removeWhere(
                                        (Food e) => e == extra);
                              });
                            }
                          }
                          //widget.onSelectedExtrasListChanged(_tempSelectedExtras);
                        }),
                  );
                }),
          ),
          RaisedButton(
            onPressed: () {
             // Navigator.pop(context);
            //  Navigator.pop(context);
             // Navigator.pop(context);
              onTapDialog();
            },
            color: Colors.indigo,
            child: Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],

      ),
    );
  }
}
