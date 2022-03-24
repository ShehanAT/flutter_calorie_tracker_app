import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:calorie_tracker_app/src/services/question_controller.dart';

class QuestionAlert extends StatefulWidget {
  final List value;
  QuestionAlert({required this.value});

  @override
  _QuestionAlertState createState() => _QuestionAlertState();
}

class _QuestionAlertState extends State<QuestionAlert> {
  late bool pressable;
  late QuestionController _question;
  late List<int> choices;
  List<Color> colors = [
    Color(0xffFA5457),
    Color(0xffFA3925),
    Color(0xff01C2BC),
    Color(0xffF6D51F)
  ];

  void initState() {
    super.initState();
    pressable = true;
    _question = QuestionController(correctValue: widget.value[0]);
    choices = _question.getChoices(widget.value[0]);
  }

  void disableButton() {
    setState(() {
      pressable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How ' + widget.value[1] + ' in this?'),
      content: choiceBox(_question, choices),
    );
  }

  Widget choiceBox(QuestionController question, List<int> choices) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 70,
              width: 100,
              child: TextButton(
                child: Text(choices[0].toString() + widget.value[2]),
                style: TextButton.styleFrom(backgroundColor: colors[0]),
                onPressed: () {
                  pressable ? checker(choices[0], choices, question) : null;
                },
              ),
            ),
            SizedBox(
              height: 70,
              width: 100,
              child: TextButton(
                child: Text(choices[1].toString() + widget.value[2]),
                style: TextButton.styleFrom(backgroundColor: colors[1]),
                onPressed: () {
                  pressable ? checker(choices[1], choices, question) : null;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 70,
              width: 100,
              child: TextButton(
                child: Text(choices[2].toString() + widget.value[2]),
                style: TextButton.styleFrom(backgroundColor: colors[2]),
                onPressed: () {
                  pressable ? checker(choices[2], choices, question) : null;
                },
              ),
            ),
            SizedBox(
              height: 70,
              width: 100,
              child: TextButton(
                child: Text(choices[3].toString() + widget.value[2]),
                style: TextButton.styleFrom(backgroundColor: colors[3]),
                onPressed: () {
                  pressable ? checker(choices[3], choices, question) : null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> checker(
      int pressed, List<int> choices, QuestionController question) async {
    // int correctPos = await question.checkAnswer(pressed, choices);
    int correctPos = 0;
    setState(() {
      colors[correctPos] = Color(0xff5FA55A);
    });
    for (int i = 0; i < 4; i++) {
      if (i != correctPos) {
        setState(() {
          colors[i] = Colors.grey;
        });
      }
    }
    disableButton();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
