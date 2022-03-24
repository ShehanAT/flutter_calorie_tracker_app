import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:calorie_tracker_app/src/model/food_model.dart';
import 'package:calorie_tracker_app/component/iconpicker/icon_picker_builder.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:calorie_tracker_app/src/utils/charts/datetime_series_chart.dart';
import 'calorie-stats.dart';
import 'package:provider/provider.dart';
import 'package:calorie_tracker_app/src/services/database.dart';
import 'package:openfoodfacts/model/Product.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'question-alert.dart';
import 'dart:math';
import 'package:calorie_tracker_app/src/utils/theme_colors.dart';

class DayViewScreen extends StatefulWidget {
  DayViewScreen();

  @override
  State<StatefulWidget> createState() {
    return _DayViewState();
  }
}

class _DayViewState extends State<DayViewScreen> {
  String productName = 'Add Food';
  late Product newResult;
  double servingSize = 0;
  String dropdownValue = 'grams';
  DateTime _value = DateTime.now();
  DateTime today = DateTime.now();
  Color _rightArrowColor = Color(0xffC1C1C1);
  final _addFoodKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBack = true;
  DatabaseService databaseService = new DatabaseService(
      uid: "calorie-tracker-b7d17", currentDate: DateTime.now());

  late FoodTrackTask addFoodTrack;
  late String calorieAmount;

  @override
  void initState() {
    super.initState();
    addFoodTrack = FoodTrackTask(
        food_name: "",
        calories: 0,
        carbs: 0,
        protein: 0,
        fat: 0,
        mealTime: "",
        createdOn: _value,
        grams: 0);
    databaseService.getFoodTrackData("calorie-tracker-b7d17");
  }

  void resetFoodTrack() {
    addFoodTrack = FoodTrackTask(
        food_name: "",
        calories: 0,
        carbs: 0,
        protein: 0,
        fat: 0,
        mealTime: "",
        createdOn: _value,
        grams: 0);
  }

  void onClickBackButton() {}

  Widget _calorieCounter() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
              color: Colors.grey.withOpacity(0.5),
              width: 1.5,
            ))),
        height: 220,
        child: Row(
          children: <Widget>[
            CalorieStats(datePicked: _value),
          ],
        ),
      ),
    );
  }

  Widget _addFoodButton() {
    return IconButton(
      icon: Icon(Icons.add_box),
      iconSize: 25,
      color: Colors.white,
      onPressed: () async {
        // dynamic result = await _scan.barcodeScan();
        dynamic result = new ProductResult();
        // ProductQueryConfiguration configuration = ProductQueryConfiguration(
        //     barcode,
        //     language: OpenFoodFactsLanguage.ENGLISH,
        //     fields: [ProductField.ALL]);
        // ProductResult result =
        //     await OpenFoodAPIClient.getProduct(configuration);
        setState(() {
          // newResult = result.product!;
          // newResult = result.product;
          // productName = newResult.productName!;
        });
        _showFoodToAdd(context);
      },
    );
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _value,
      firstDate: new DateTime(2019),
      lastDate: new DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff5FA55A), //Head background
            // accentColor: const Color(0xFF5FA55A)//selection color
            //dialogBackgroundColor: Colors.white,//Background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _value = picked);
    _stateSetter();
  }

  void _stateSetter() {
    if (today.difference(_value).compareTo(Duration(days: 1)) == -1) {
      setState(() => _rightArrowColor = Color(0xffEDEDED));
    } else
      setState(() => _rightArrowColor = Colors.white);
  }

  checkFormValid() {
    if (addFoodTrack.calories != 0 &&
        addFoodTrack.carbs != 0 &&
        addFoodTrack.protein != 0 &&
        addFoodTrack.fat != 0 &&
        addFoodTrack.grams != 0) {
      return true;
    }
    return false;
  }

  _showFoodToAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(productName),
            content: _showAmountHad(),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context), // passing false
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () async {
                  if (checkFormValid()) {
                    Navigator.pop(context);
                    var random = new Random();
                    int randomMilliSecond = random.nextInt(1000);
                    addFoodTrack.createdOn = _value;
                    addFoodTrack.createdOn = addFoodTrack.createdOn
                        .add(Duration(milliseconds: randomMilliSecond));
                    databaseService.addFoodTrackEntry(addFoodTrack);
                    resetFoodTrack();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Invalid form data! All numeric fields must contain numeric values greater than 0"),
                      backgroundColor: Colors.white,
                    ));
                  }
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  Widget _showAmountHad() {
    return new Scaffold(
      body: Column(children: <Widget>[
        _showAddFoodForm(),
        _showUserAmount(),
        _showServingOrGrams()
      ]),
    );
  }

  Widget _showAddFoodForm() {
    return Form(
      key: _addFoodKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Name *", hintText: "Please enter food name"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the food name";
            }
            return null;
          },
          onChanged: (value) {
            addFoodTrack.food_name = value;

            // addFood.calories = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Calories *",
              hintText: "Please enter a calorie amount"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a calorie amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.calories = int.parse(value);
            } catch (e) {
              // return "Please enter numeric values"
              addFoodTrack.calories = 0;
            }

            // addFood.calories = value;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Carbs *", hintText: "Please enter a carbs amount"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a carbs amount";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              addFoodTrack.carbs = int.parse(value);
            } catch (e) {
              addFoodTrack.carbs = 0;
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Protein *",
              hintText: "Please enter a protein amount"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a calorie amount";
            }
            return null;
          },
          onChanged: (value) {
            try {
              addFoodTrack.protein = int.parse(value);
            } catch (e) {
              addFoodTrack.protein = 0;
            }
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Fat *", hintText: "Please enter a fat amount"),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a fat amount";
            }
            return null;
          },
          onChanged: (value) {
            try {
              addFoodTrack.fat = int.parse(value);
            } catch (e) {
              addFoodTrack.fat = 0;
            }
          },
        ),
      ]),
    );
  }

  Widget _showUserAmount() {
    return new Expanded(
      child: new TextField(
          maxLines: 1,
          autofocus: true,
          decoration: new InputDecoration(
              labelText: 'Serving *',
              hintText: 'eg. 100',
              contentPadding: EdgeInsets.all(0.0)),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            try {
              addFoodTrack.grams = int.parse(value);
            } catch (e) {
              addFoodTrack.grams = 0;
            }
            setState(() {
              servingSize = double.tryParse(value) ?? 0;
            });
          }),
    );
  }

  Widget _showDatePicker() {
    return Container(
      width: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_left, size: 25.0),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _value = _value.subtract(Duration(days: 1));
                _rightArrowColor = Colors.white;
              });
            },
          ),
          TextButton(
            // textColor: Colors.white,
            onPressed: () => _selectDate(),
            // },
            child: Text(_dateFormatter(_value),
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                )),
          ),
          IconButton(
              icon: Icon(Icons.arrow_right, size: 25.0),
              color: _rightArrowColor,
              onPressed: () {
                if (today.difference(_value).compareTo(Duration(days: 1)) ==
                    -1) {
                  setState(() {
                    _rightArrowColor = Color(0xffC1C1C1);
                  });
                } else {
                  setState(() {
                    _value = _value.add(Duration(days: 1));
                  });
                  if (today.difference(_value).compareTo(Duration(days: 1)) ==
                      -1) {
                    setState(() {
                      _rightArrowColor = Color(0xffC1C1C1);
                    });
                  }
                }
              }),
        ],
      ),
    );
  }

  String _dateFormatter(DateTime tm) {
    DateTime today = new DateTime.now();
    Duration oneDay = new Duration(days: 1);
    Duration twoDay = new Duration(days: 2);
    String month;

    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
      default:
        month = "Undefined";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Today";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Yesterday";
    } else {
      return "${tm.day} $month ${tm.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _showDatePicker(),
                  _addFoodButton(),
                ],
              ),
            )),
        body: StreamProvider<List<FoodTrackTask>>.value(
          initialData: [],
          value: new DatabaseService(
                  uid: "calorie-tracker-b7d17", currentDate: DateTime.now())
              .foodTracks,
          child: new Column(children: <Widget>[
            _calorieCounter(),
            Expanded(
                child: ListView(
              children: <Widget>[FoodTrackList(datePicked: _value)],
            ))
          ]),
        ));
  }

  Widget _showServingOrGrams() {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: DropdownButtonFormField(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0)),
            style: TextStyle(color: Colors.black),
            onChanged: (newValue) => setState(() {
              dropdownValue = newValue.toString();
            }),
            items: <String>['grams', 'servings']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    );
  }
}

class FoodTrackList extends StatelessWidget {
  final DateTime datePicked;
  FoodTrackList({required this.datePicked});

  @override
  Widget build(BuildContext context) {
    final DateTime curDate =
        new DateTime(datePicked.year, datePicked.month, datePicked.day);

    final foodTracks = Provider.of<List<FoodTrackTask>>(context);

    List findCurScans(List foodTrackFeed) {
      List curScans = [];
      foodTrackFeed.forEach((foodTrack) {
        DateTime scanDate = DateTime(foodTrack.createdOn.year,
            foodTrack.createdOn.month, foodTrack.createdOn.day);
        if (scanDate.compareTo(curDate) == 0) {
          curScans.add(foodTrack);
        }
        // curScans.add(foodTrack);
      });
      return curScans;
    }

    List curScans = findCurScans(foodTracks);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: curScans.length + 1,
      itemBuilder: (context, index) {
        if (index < curScans.length) {
          return FoodTrackTile(foodTrackEntry: curScans[index]);
        } else {
          return SizedBox(height: 5);
        }
      },
    );
  }
}

class FoodTrackTile extends StatelessWidget {
  final FoodTrackTask foodTrackEntry;
  DatabaseService databaseService = new DatabaseService(
      uid: "calorie-tracker-b7d17", currentDate: DateTime.now());

  FoodTrackTile({required this.foodTrackEntry});

  List macros = CalorieStats.macroData;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Color(0xff5FA55A),
        child: _itemCalories(),
      ),
      title: Text(foodTrackEntry.food_name,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w500,
          )),
      subtitle: _macroData(),
      children: <Widget>[
        _expandedView(context),
      ],
    );
  }

  Widget _itemCalories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(foodTrackEntry.calories.toStringAsFixed(0),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w500,
            )),
        Text('kcal',
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }

  Widget _macroData() {
    return Row(
      children: <Widget>[
        Container(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(CARBS_COLOR),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ' + foodTrackEntry.carbs.toStringAsFixed(1) + 'g    ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      )),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(PROTEIN_COLOR),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                      ' ' + foodTrackEntry.protein.toStringAsFixed(1) + 'g    ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      )),
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Color(FAT_COLOR),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(' ' + foodTrackEntry.fat.toStringAsFixed(1) + 'g',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
              Text(foodTrackEntry.grams.toString() + 'g',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget _expandedView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          expandedHeader(context),
          _expandedCalories(),
          _expandedCarbs(),
          _expandedProtein(),
          _expandedFat(),
        ],
      ),
    );
  }

  Widget expandedHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('% of total',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            )),
        IconButton(
            icon: Icon(Icons.edit),
            iconSize: 16,
            onPressed: () {
              // Navigator.push(
              //   context,

              //   MaterialPageRoute(builder: (context) => EditItem(scan: scan)),
              // );
            }),
        IconButton(
            icon: Icon(Icons.delete),
            iconSize: 16,
            onPressed: () async {
              print("Delete button pressed");
              databaseService.deleteFoodTrackEntry(foodTrackEntry);
              // Navigator.push(
              //   context,

              //   MaterialPageRoute(builder: (context) => EditItem(scan: scan)),
              // );
            }),
      ],
    );
  }

  Widget _expandedCalories() {
    double caloriesValue = 0;
    if (!(foodTrackEntry.calories / macros[0]).isNaN) {
      caloriesValue = foodTrackEntry.calories / macros[0];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: caloriesValue,
              backgroundColor: Color(0xffEDEDED),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff5FA55A)),
            ),
          ),
          Text('      ' + ((caloriesValue) * 100).toStringAsFixed(0) + '%'),
        ],
      ),
    );
  }

  Widget _expandedCarbs() {
    double carbsValue = 0;
    if (!(foodTrackEntry.carbs / macros[2]).isNaN) {
      carbsValue = foodTrackEntry.carbs / macros[2];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: carbsValue,
              backgroundColor: Color(0xffEDEDED),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFA5457)),
            ),
          ),
          Text('      ' + ((carbsValue) * 100).toStringAsFixed(0) + '%'),
        ],
      ),
    );
  }

  Widget _expandedProtein() {
    double proteinValue = 0;
    if (!(foodTrackEntry.protein / macros[1]).isNaN) {
      proteinValue = foodTrackEntry.protein / macros[1];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: proteinValue,
              backgroundColor: Color(0xffEDEDED),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFA8925)),
            ),
          ),
          Text('      ' + ((proteinValue) * 100).toStringAsFixed(0) + '%'),
        ],
      ),
    );
  }

  Widget _expandedFat() {
    double fatValue = 0;
    if (!(foodTrackEntry.fat / macros[3]).isNaN) {
      fatValue = foodTrackEntry.fat / macros[3];
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 10.0,
            width: 200.0,
            child: LinearProgressIndicator(
              value: (foodTrackEntry.fat / macros[3]),
              backgroundColor: Color(0xffEDEDED),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff01B4BC)),
            ),
          ),
          Text('      ' + ((fatValue) * 100).toStringAsFixed(0) + '%'),
        ],
      ),
    );
  }
}
