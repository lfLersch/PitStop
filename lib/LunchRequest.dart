import 'package:flutter/material.dart';
import './AppInformation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Food.dart';

class nrLunch extends StatefulWidget {
  final AppInformation appInfo;
  final int type;

  nrLunch(this.appInfo, this.type);

  LunchState createState() => new LunchState();
}

class LunchState extends State<nrLunch> {
  @override
  nrLunch get widget => super.widget;
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

      itemCount: widget.appInfo.lists[widget.type].length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = widget.appInfo.lists[widget.type][index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.id.toString()),
          trailing: Text(item.value.toString()),
          onTap: () => onTapLunch(item.id),
        );
      },
    ));
  }
}

class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.id,
    this.extras,
    this.selectedExtras,
    this.onSelectedExtrasListChanged,
  });
  final int id;
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
      var url = "http://192.168.0.111/insertFoodRequest.php";
      List<int> ids = new List();

      ids.add(widget.id);

      _tempSelectedExtras.forEach((food) =>
          ids.add(food.id)
      );

      var jSonExtras = jsonEncode(ids) ;
      http.Response response =
          await http.post(url, body: jSonExtras);

      var dat = response.body.toString();
      var oi = 9;
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
              //Navigator.pop(context);
             // Navigator.pop(context);
              Navigator.pop(context);
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
