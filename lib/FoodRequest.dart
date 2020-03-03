import './Food.dart';

class FoodRequest{
  Food food;
  int id;
  int idRequest;
  int status;
  String obs;
  FoodRequest(Food food, int id, int idRequest, int status, String obs) {
    this.food = food;
    this.id = id;
    this.idRequest = idRequest;
    this.status = status;
    this.obs = obs;
  }
}
