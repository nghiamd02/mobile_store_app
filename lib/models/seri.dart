class Seri {
  final int? id;
  final String? name;
  final bool? status;

  Seri({this.id, this.name, this.status});

  factory Seri.fromJson(Map<String, dynamic> json) {
    return Seri(
        id: json["id"],
        name: json["name"],
        status: json["status"]
    );
  }
}
