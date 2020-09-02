class Food{
  String name;
  int id;
  num value;
  int type;
  Food(String food, int id, num value, int type){
    this.name = food;
    this.id = id;
    this.value = value;
    this.type = type;
    //this.valui = value.substring(2,value.length-1) as num;
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