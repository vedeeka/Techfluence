import 'package:techfluence/pages/scheduler.dart';

String globalEmail = "";
String backendBaseString = "hackathons/techfluence/companies";

class InventoryClass {
  InventoryClass();
  Map<String, dynamic> inventory = {
    'name': '',
    'description': '',
    'tags': [],
    'status': 'available',
  };
}

List<MaintenanceTask> maintenanceTasks = [
  MaintenanceTask(
      equipment: 'Generator',
      description: 'fix power leakage',
      scheduledDate: DateTime(2025, 3, 28)),
  MaintenanceTask(
      equipment: 'Server',
      description: 'Data security',
      scheduledDate: DateTime(2025, 4, 5))
];
