import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:calorie_tracker_app/src/services/database.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:calorie_tracker_app/src/model/food-track-entry.dart';

class DateTimeChart extends StatefulWidget {
  @override
  _DateTimeChart createState() => _DateTimeChart();
}

class _DateTimeChart extends State<DateTimeChart> {
  List<charts.Series<FoodTrackEntry, DateTime>>? resultChartData = null;
  DatabaseService databaseService = new DatabaseService(
      uid: "calorie-tracker-b7d17", currentDate: DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllFoodTrackData();
  }

  void getAllFoodTrackData() async {
    Stream<List<FoodTrackTask>> result = databaseService.foodTracks;
    List<dynamic> foodTrackResults =
        await databaseService.getAllFoodTrackData();
    List<FoodTrackEntry> foodTrackEntries = [];

    for (var foodTrack in foodTrackResults) {
      if (foodTrack["createdOn"] != null) {
        foodTrackEntries.add(FoodTrackEntry(
            foodTrack["createdOn"].toDate(), foodTrack["calories"]));
      }
    }
    populateChartWithEntries(foodTrackEntries);
  }

  void populateChartWithEntries(List<FoodTrackEntry> foodTrackEntries) async {
    Map<String, int> caloriesByDateMap = new Map();
    if (foodTrackEntries != null) {
      var dateFormat = DateFormat("yyyy-MM-dd");
      for (var foodEntry in foodTrackEntries) {
        var trackedDateStr = foodEntry.date;
        DateTime dateNow = DateTime.now();
        var trackedDate = dateFormat.format(trackedDateStr);
        if (caloriesByDateMap.containsKey(trackedDate)) {
          caloriesByDateMap[trackedDate] =
              caloriesByDateMap[trackedDate]! + foodEntry.calories;
        } else {
          caloriesByDateMap[trackedDate] = foodEntry.calories;
        }
      }
      List<FoodTrackEntry> caloriesByDateTimeMap = [];
      for (var foodEntry in caloriesByDateMap.keys) {
        DateTime entryDateTime = DateTime.parse(foodEntry);
        caloriesByDateTimeMap.add(
            new FoodTrackEntry(entryDateTime, caloriesByDateMap[foodEntry]!));
      }

      caloriesByDateTimeMap.sort((a, b) {
        int aDate = a.date.microsecondsSinceEpoch;
        int bDate = b.date.microsecondsSinceEpoch;

        return aDate.compareTo(bDate);
      });
      setState(() {
        resultChartData = [
          new charts.Series<FoodTrackEntry, DateTime>(
              id: "Food Track Entries",
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (FoodTrackEntry foodTrackEntry, _) =>
                  foodTrackEntry.date,
              measureFn: (FoodTrackEntry foodTrackEntry, _) =>
                  foodTrackEntry.calories,
              labelAccessorFn: (FoodTrackEntry foodTrackEntry, _) =>
                  '${foodTrackEntry.date}: ${foodTrackEntry.calories}',
              data: caloriesByDateTimeMap)
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (resultChartData != null) {
      return Scaffold(
        body: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Caloric Intake By Date Chart"),
            new Padding(
                padding: new EdgeInsets.all(32.0),
                child: new SizedBox(
                  height: 500.0,
                  child:
                      charts.TimeSeriesChart(resultChartData!, animate: true),
                ))
          ],
        )),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
