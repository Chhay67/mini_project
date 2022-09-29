
class Beer{
  final int id;
  final String name;
  final String description;
  final String image_url;
  final int price;

  Beer({required this.id,required this.name,required this.description,
        required this.image_url,required this.price});

  factory Beer.fromJson(Map<String,dynamic> json) => Beer(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image_url: json["image_url"],
      price: json["target_fg"],
  );
  Map<String,dynamic> toJson() => {
    "id" : id,
    "name" : name,
    "description" : description,
     "image_url" : image_url,
    "target_fg" : price,
  };
}