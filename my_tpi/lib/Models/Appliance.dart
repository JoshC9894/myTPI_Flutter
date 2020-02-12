class Appliance {
  String id;
  String name;
  String date;

  Appliance({this.id, this.name, this.date});

  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(id: json['id'], name: json['name'], date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date
    };
  }
}
