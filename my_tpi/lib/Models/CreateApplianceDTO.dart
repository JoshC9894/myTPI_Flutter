import 'dart:convert';

class CreateApplianceDTO {
  DateTime date;
  String assetNumber;
  String serialNumber;
  int typeId;

  CreateApplianceDTO({this.date, this.assetNumber, this.serialNumber, this.typeId});

  String toJson() {
    return json.encode({
      'inspectionDate': date.toString(),
      'assetNumber': assetNumber.isEmpty ? serialNumber : assetNumber,
      'serialNumber': serialNumber,
      'type': typeId
    });
  }
}