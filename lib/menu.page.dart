import 'package:flutter/material.dart';
import 'package:pit_stop/CardPage.dart';
import 'package:pit_stop/FoodRequestPage.dart';
import './FoodRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './TypeFood.dart';
import './AppInformation.dart';
import './Food.dart';
import 'Request.dart';

class HomePage extends StatelessWidget {
  final AppInformation appInfo;

  HomePage(this.appInfo);

  var requests = Map();

  Future<String> getData() async {
    var url = "http://192.168.0.110/getfood_request.php";
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    for (var r in data) {
      Food f = appInfo.lists[0][2];
      int requestIndex = int.parse(r['request']);
      if (requests[requestIndex] == null) {
        requests[requestIndex] = Request(requestIndex);
      }
      if(requests[requestIndex].foodRequests[r['id_food_request']] == null) {
        requests[requestIndex].foodRequests[r['id_food_request']] =
            FoodRequest(appInfo.lists[0][int.parse(r['id_food'])]);
        requests[requestIndex].value += appInfo.lists[0][int.parse(r['id_food'])].value;
      }
      if (r['id_extra'] != "") {
        requests[requestIndex].foodRequests[r['id_food_request']].extras.add(
            appInfo.lists[0][int.parse(r['id_extra'])]);
        requests[requestIndex].value += appInfo.lists[0][int.parse(r['id_extra'])].value;
      }
    }

    return Future.value("Data download successfully");
  }

  Widget requestTemplate(request, context) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: new InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FoodRequestPage(appInfo, request))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              request.id.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'R\$ ' + request.value.toString(),
              style: TextStyle(fontSize: 14.0, color: Colors.blueGrey),
            )
          ],
        ),
      ),
    ));
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
                          builder: (context) => CardPage(appInfo))),
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
                children: requests.values.toList().map((Request) => requestTemplate(Request,context))
                    .toList(),


              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(
                    Icons.add
                ),
                onPressed: () {
                  //...
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CardPage(appInfo)));
                },
                heroTag: null,
              ),
            ); // snapshot.data  :- get your object which is pass from your downloadData() function
        }
      },
    );
  }
}
