import 'package:flutter/material.dart';
import 'package:my_tpi/Models/Appliance.dart';
import 'package:my_tpi/Models/CreateApplianceDTO.dart';
import 'package:my_tpi/Services/ApplianceService.dart';

abstract class IApplicationProvider extends ChangeNotifier {
  Future<Appliance> createNewInspection(CreateApplianceDTO dto);
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
  Future<Appliance> createNewInspection(CreateApplianceDTO dto) async {
    final inspection = await _service.createInspection(dto);
    _inspections.add(inspection);
    notifyListeners();
    return inspection;
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
