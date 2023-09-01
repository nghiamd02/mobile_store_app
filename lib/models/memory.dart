class Memory {
  final int? id;
  final String? name;

  Memory({this.id,this.name,});

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
        id: json["id"],
        name: json["name"]
    );
  }
}
