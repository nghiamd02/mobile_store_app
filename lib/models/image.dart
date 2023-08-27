class Image {
  final int? id;
  final String? name;

  Image({this.id,this.name,});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
        id: json["id"],
        name: json["name"]
    );
  }
}
