import 'package:flutter/material.dart';
import 'package:my_tpi/Models/Appliance.dart';
import 'package:my_tpi/Services/ApplianceService.dart';

abstract class IApplicationProvider extends ChangeNotifier {
  Future<void> createNewInspection(String text);
  Future<void> updateInspectionList();
  Future<void> deleteInspection(String id);
  List<Appliance> get inspections;
}

class ApplianceProvider extends IApplicationProvider {
  IApplianceService _service;
  List<Appliance> _inspections;

  ApplianceProvider() {
    _service = ApplianceService();
    notifyListeners();
  }

  List<Appliance> get inspections {
    if (_inspections == null) {
      updateInspectionList();
      return null;
    }
    return _inspections;
  }

  @override
  Future<void> createNewInspection(String text) async {
    final model = Appliance(name: text, date: DateTime.now().toString());
    final inspection = await _service.createInspection(model);
    _inspections.add(inspection);
    notifyListeners();
  }

  @override
  Future<void> updateInspectionList() async {
    _inspections = await _service.getInspections();
    notifyListeners();
  }

  @override
  Future<void> deleteInspection(String id) async {
    await _service.deleteInspection(id);
    _inspections.removeWhere(($0) => $0.id == id);
    notifyListeners();
  }
}
