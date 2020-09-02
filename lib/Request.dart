import './Food.dart';

class Request{
  var foodRequests;
  int id;
  num value;
  Request(int id) {
    this.id = id;
    this.value = 0;
    this.foodRequests = Map();
  }
}