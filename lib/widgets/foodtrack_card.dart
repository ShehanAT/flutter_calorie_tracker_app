import 'package:calorie_tracker_app/routes/route_constants.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calorie_tracker_app/helpers/colors.dart';

class FoodTrackCard extends StatelessWidget {
  const FoodTrackCard({required this.foodTrackTask, Key? key})
      : super(key: key);
  final FoodTrackTask foodTrackTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.VIEW_FOODTRACK,
                  arguments: foodTrackTask);
            },
            child: Card(
                elevation: 4.0,
                color: AppTheme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.border_color,
                          size: 18.0,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          foodTrackTask.food_name.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(foodTrackTask.food_name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ))
                  ]),
                ))));
  }
}
