import 'package:flutter/material.dart';
import './FoodRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './TypeFood.dart';
import './AppInformation.dart';
import './Food.dart';

class HomePage extends StatelessWidget {
  final AppInformation appInfo;

  HomePage(this.appInfo);

  final List<FoodRequest> foodrequests = new List();

  Future<String> getData() async {
    var url = "http://192.168.0.111/getfood_request.php";
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    for (var r in data) {
      Food f = appInfo.lists[0][2];
      foodrequests.add(FoodRequest(appInfo.lists[0][int.parse(r['id_food'])], int.parse(r['id']),
          int.parse(r['id_request']), int.parse(r['status']), r['obs'].toString()));
    }

    return Future.value("Data download successfully");
  }

  Widget requestTemplate(foodrequest) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              foodrequest.food.name,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              foodrequest.idRequest.toString(),
              style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Scaffold(
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text("Luiz Lersch"),
                      accountEmail: Text("luiz@mail.com"),
                      /* currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: AssetImage("lalala"),
                ),

              ),*/
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/hamburguerBackground.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    ListTile(
                      title: Text("Novo Pedido"),
                      trailing: Icon(Icons.add),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => newRequest(appInfo))),
                    ),
                    ListTile(
                      title: Text("Pedidos"),
                      trailing: Icon(Icons.list),
                    ),
                    ListTile(
                      title: Text("Close"),
                      trailing: Icon(Icons.exit_to_app),
                      onTap: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
              body: ListView(
                children: foodrequests.map((foodrequest) => requestTemplate(foodrequest))
                    .toList(),
              ),
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
