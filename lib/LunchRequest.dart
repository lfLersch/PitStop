import 'package:flutter/material.dart';
import './AppInformation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './Extra.dart';

class nrLunch extends StatefulWidget {
  final AppInformation appInfo;
  final int type;

  nrLunch(this.appInfo, this.type);

  LunchState createState() => new LunchState();
}

class LunchState extends State<nrLunch> {
  @override
  nrLunch get widget => super.widget;
  bool checkboxValueCity = false;
  List<String> allCities = ['Calabresa', 'Cebola', 'Ovo Picado'];
  List<String> selectedCities = [];

  @override
  Widget build(BuildContext context) {
    /*void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: new Text("Adicionais"),
            content: ListView(
              children: widget.extras
                  .map((extra) => CheckboxListTile(
                        title: new Text(extra.name),
                        value: extra.state,
                        onChanged: (bool val) {
                          setState(() {
                            widget.extras[0].state = val;
                          });
                        },
                      ))
                  .toList(),
            ),
            actions: <Widget>[
              // define os botões na base do dialogo
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }*/

    void onTapLunch(int id) async {
      var url = "http://192.168.0.111/insertFoodRequest.php";
      http.Response response =
          await http.post(url, body: {'id_food': id.toString()});
      var dat = response.body.toString();
      showDialog(
          context: context,
          builder: (context) {
            return _MyDialog(
                cities: allCities,
                selectedCities: selectedCities,
                onSelectedCitiesListChanged: (cities) {
                  selectedCities = cities;
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
    this.cities,
    this.selectedCities,
    this.onSelectedCitiesListChanged,
  });

  final List<String> cities;
  final List<String> selectedCities;
  final ValueChanged<List<String>> onSelectedCitiesListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedCities = [];

  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ADICIONAIS',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.cities.length,
                itemBuilder: (BuildContext context, int index) {
                  final cityName = widget.cities[index];
                  return Container(
                    child: CheckboxListTile(
                        title: Text(cityName),
                        subtitle: Text("RS 2,00"),
                        value: _tempSelectedCities.contains(cityName),
                        onChanged: (bool value) {
                          if (value) {
                            if (!_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.add(cityName);
                              });
                            }
                          } else {
                            if (_tempSelectedCities.contains(cityName)) {
                              setState(() {
                                _tempSelectedCities.removeWhere(
                                    (String city) => city == cityName);
                              });
                            }
                          }
                          widget
                              .onSelectedCitiesListChanged(_tempSelectedCities);
                        }),
                  );
                }),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            //color: Color(0xFFfab82b),
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
