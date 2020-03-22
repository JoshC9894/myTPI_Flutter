enum ApplianceType { MOBILE_CRANE, MEWP, TOWER_CRANE, UNDEFINED }

class ApplianceTypeHelper {
  static List<ApplianceType> appliances = [
    ApplianceType.MOBILE_CRANE,
    ApplianceType.MEWP,
    ApplianceType.TOWER_CRANE
  ];

  static String getDescription(ApplianceType type) {
    switch (type) {
      case ApplianceType.MOBILE_CRANE:
        return "Mobile Crane";
      case ApplianceType.MEWP:
        return "Mobile Elevation Work Platform";
      case ApplianceType.TOWER_CRANE:
        return "Tower Crane";
      default:
        return "";
    }
  }

  static int getRawValueFromString(String description) {
    switch (description) {
      case "Mobile Crane":
        return 0;
      case "Mobile Elevation Work Platform":
        return 1;
      case "Tower Crane":
        return 2;
      default:
        return -1;
    }
  }

  static int rawValue(ApplianceType type) {
    switch (type) {
      case ApplianceType.MOBILE_CRANE:
        return 0;
      case ApplianceType.MEWP:
        return 1;
      case ApplianceType.TOWER_CRANE:
        return 2;
      default:
        return -1;
    }
  }

  static ApplianceType fromInt(int id) {
    switch (id) {
      case 0:
        return ApplianceType.MOBILE_CRANE;
      case 1:
        return ApplianceType.MEWP;
      case 2:
        return ApplianceType.TOWER_CRANE;
      default:
        return ApplianceType.UNDEFINED;
    }
  }
}
