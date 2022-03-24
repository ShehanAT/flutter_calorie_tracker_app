import 'package:calorie_tracker_app/src/services/database.dart';
import 'package:calorie_tracker_app/src/services/database.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerSingleton<DatabaseService>(DatabaseService(
      uid: "calorie-tracker-b7d17", currentDate: DateTime.now()));
}
