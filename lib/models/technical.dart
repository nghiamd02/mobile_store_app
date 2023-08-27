import 'dart:convert';

class Technical {
  final int? id;
  final String? name;

  Technical({this.id,this.name,});

  factory Technical.fromJson(Map<String, dynamic> json) {
    return Technical(
        id: json["id"],
        name: json["name"]
    );
  }
}
