class Food{
  String name;
  int id;
  String value;
  int type;

  Food(String food, int id, String value, int type){
    this.name = food;
    this.id = id;
    this.value = value;
    this.type = type;
  }

  Food.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'id': id,
      };
}