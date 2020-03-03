import 'package:http/http.dart' as http;
import 'package:pit_stop/main.dart';
import './Food.dart';
import 'dart:convert';

class ServerCommunicator {
  String ip = 'http://192.168.0.110/';
  Future<http.Response> communicate(String request) async {
    switch (request) {
      case 'GetFood':
        var url = ip + "getfood.php";
        return await http.get(url);
        break;
      case 'GetFoodRequest':
        break;
    }
  }
}
