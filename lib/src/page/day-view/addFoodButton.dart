import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';

class AddFoodButtonWidget extends StatefulWidget {
  @override
  _AddFoodButtonWidget createState() => _AddFoodButtonWidget();
}

class _AddFoodButtonWidget extends State<AddFoodButtonWidget> {
  late FoodTrackTask addFoodTrack;
  final _addFoodKey = GlobalKey<FormState>();

  Widget _addFoodButton() {
    return IconButton(
      key: Key('add_food_modal_button'),
      icon: Icon(Icons.add_box),
      iconSize: 25,
      color: Colors.white,
      onPressed: () async {
        setState(() {});
        _showFoodToAdd(context);
      },
    );
  }

  _showFoodToAdd(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Add Food Modal"),
              content: new Scaffold(
                body: Column(children: <Widget>[new Text("Add Food Modal")]),
                key: Key("add_food_modal"),
                // actions: <Widget>[],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Row(
      children: [_addFoodButton()],
    )));
  }
}
