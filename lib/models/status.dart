class Status {
  int? id;
  String? name;

  Status({this.id, this.name});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(id: json["id"], name: json["name"]);
  }
}
