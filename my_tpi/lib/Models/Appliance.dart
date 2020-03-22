import 'package:my_tpi/Helpers/ApplianceTypeHelper.dart';

class Appliance {
  String id;
  String assetNumber;
  String serialNumber;
  DateTime date;
  ApplianceType type;
  List<ApplianceSection> sections;

  Appliance(
      {this.id,
      this.assetNumber,
      this.serialNumber,
      this.date,
      this.type,
      this.sections});

  factory Appliance.fromJson(Map<String, dynamic> json) {
    var sectionsList = json['sections'] as List;
    return Appliance(
        id: json['id'],
        assetNumber: json['assetNumber'],
        serialNumber: json['serialNumber'],
        type: ApplianceTypeHelper.fromInt(json['type']),
        date: DateTime.parse(json['inspectionDate']),
        sections: sectionsList.map(($0) => ApplianceSection.fromJson($0)).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'assetNumber': assetNumber,
      'date': date.toString(),
    };
  }
}

class ApplianceSection {
  int index;
  String title;
  String rowLink;

  ApplianceSection({this.index, this.title, this.rowLink});

  factory ApplianceSection.fromJson(Map<String, dynamic> json) {
    return ApplianceSection(
        index: json['index'], title: json['title'], rowLink: json['rows']);
  }
}
