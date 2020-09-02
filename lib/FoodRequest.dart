import './Food.dart';

class FoodRequest{
  Food food;
  List<Food> extras;
  int id;
  int idRequest;
  int status;
  String obs;
  FoodRequest(Food food) {
    this.food = food;
    this.extras = new List<Food>();
  }
}
