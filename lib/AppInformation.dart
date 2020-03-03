import 'package:http/http.dart' as http;
import 'package:pit_stop/main.dart';
import './Food.dart';
import 'dart:convert';
import './ServerCommunicator.dart';

class AppInformation{
  var lists;//lista contém todos alimentos, outras listas por id do tipo de comida
  ServerCommunicator serverCommunicator = ServerCommunicator();

  AppInformation(){
    createFoodList();
  }

  Future<String> createFoodList() async{
    lists = Map();
    lists[0] = Map();
    for(int i = 1; i < 6; i++)
      lists[i] = new List<Food>();

    var url = "http://192.168.0.111/getfood.php";
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    for (var r in data) {
      int type = int.parse(r['type']);
      var id = int.parse(r['id']);
      var f = Food(r['name'].toString(), id, r['value'].toString(), type);
      lists[0][id] = f;//,int.parse(r['value'].toString())));
      lists[type].add(f);

    }
  return Future.value("Data download successfully");;
  }


}
