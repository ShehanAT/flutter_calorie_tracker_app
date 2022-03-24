import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:calorie_tracker_app/src/page/day-view/day-view.dart';
import 'package:calorie_tracker_app/src/page/settings/settings_screen.dart';
import 'package:calorie_tracker_app/widgets/foodtrack_card.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'src/page/history/history_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:calorie_tracker_app/src/providers/theme_notifier.dart';
import 'package:calorie_tracker_app/src/services/shared_preference_service.dart';
import 'package:calorie_tracker_app/helpers/theme.dart';
import 'package:calorie_tracker_app/helpers/colors.dart';
import 'package:calorie_tracker_app/routes/router.dart';
import 'package:calorie_tracker_app/src/model/food_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:settings_ui/settings_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesService().init();
  runApp(CalorieTrackerApp());
}

class CalorieTrackerApp extends StatefulWidget {
  @override
  _CalorieTrackerAppState createState() => _CalorieTrackerAppState();
}

class _CalorieTrackerAppState extends State<CalorieTrackerApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  late Widget homeWidget;
  late bool signedIn;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  void checkFirstSeen() {
    final bool _firstLaunch = true;

    if (_firstLaunch) {
      homeWidget = Homepage();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkThemeProvider>(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder:
            (BuildContext context, DarkThemeProvider value, Widget? child) {
          return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: (_, Widget? child) => ScrollConfiguration(
                      behavior: MyBehavior(), child: child!),
                  theme: themeChangeProvider.darkTheme ? darkTheme : lightTheme,
                  home: homeWidget,
                  onGenerateRoute: RoutePage.generateRoute));
        },
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            // Navigate back to homepage
          },
          child: const Text('Go Back!'),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<Homepage> with SingleTickerProviderStateMixin {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = 'foodTrack';
  List<FoodTrackTask> foodTrackList = <FoodTrackTask>[];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late Query foodTrackQuery;
  @override
  void initState() {
    super.initState();
    _database.ref().child(nodeName).onChildAdded.listen(_childAdded);

    foodTrackQuery = _database.ref().child('foodTrack');
  }

  void _childAdded(dynamic event) {
    DateTime now = DateTime.now();

    setState(() {});
  }

  void _childRemoves(dynamic event) {
    final FoodTrackTask deletedFoodTrackTask =
        foodTrackList.singleWhere((FoodTrackTask foodtrackTask) {
      return foodtrackTask == event.snapshot.key;
    });

    setState(() {
      foodTrackList.removeAt(foodTrackList.indexOf(deletedFoodTrackTask));
    });
  }

  void _childChanged(dynamic event) {
    final FoodTrackTask changedFoodTrackTask =
        foodTrackList.singleWhere((FoodTrackTask foodTrackTask) {
      return foodTrackTask.id == event.snapshot.key;
    });
    setState(() {
      foodTrackList[foodTrackList.indexOf(changedFoodTrackTask)] =
          FoodTrackTask.fromSnapshot(event.snapshot);
    });
  }

  void onClickHistoryScreenButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HistoryScreen()));
  }

  void onClickSettingsScreenButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  void onClickDayViewScreenButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DayViewScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Flutter Calorie Tracker App",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: new Column(
          children: <Widget>[
            new ListTile(
                leading: const Icon(Icons.food_bank),
                title: new Text("Welcome To Calorie Tracker App!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            new ElevatedButton(
                onPressed: () {
                  onClickDayViewScreenButton(context);
                },
                child: Text("Day View Screen")),
            new ElevatedButton(
                onPressed: () {
                  onClickHistoryScreenButton(context);
                },
                child: Text("History Screen")),
            new ElevatedButton(
                onPressed: () {
                  onClickSettingsScreenButton(context);
                },
                child: Text("Settings Screen")),
          ],
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
