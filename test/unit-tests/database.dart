import "package:calorie_tracker_app/src/services/database.dart";
import "package:calorie_tracker_app/src/utils/constants.dart";
import 'package:flutter_test/flutter_test.dart';

void main() {
  DatabaseService databaseService;
  // DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());

  setUp(() {
    databaseService =
        DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());
  });

  group('testing DatabaseService', () {
    // databaseService =
    //     DatabaseService(uid: DATABASE_UID, currentDate: DateTime.now());

    test("DatabaseService.getAll should return list of foodTrack instances",
        () async {
      List<dynamic> getAllFoodTrackData =
          await databaseService.getAllFoodTrackData();

      print(getAllFoodTrackData);
      expect(getAllFoodTrackData == null, true);
    });
  });
}
