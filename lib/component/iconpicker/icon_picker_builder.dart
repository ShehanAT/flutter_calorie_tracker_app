import 'package:flutter/material.dart';
import 'package:calorie_tracker_app/component/badge.dart';
import 'icon_picker.dart';

class IconPickerBuilder extends StatelessWidget {
  final IconData iconData;
  final ValueChanged<IconData> action;
  final Color highlightColor;

  IconPickerBuilder({
    required this.iconData,
    required this.action,
    required Color highlightColor,
  }) : this.highlightColor = highlightColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select an icon'),
              content: SingleChildScrollView(
                child: IconPicker(
                  currentIconData: iconData,
                  onIconChanged: action,
                  highlightColor: highlightColor,
                ),
              ),
            );
          },
        );
      },
      child: Badge(
        id: 'id',
        codePoint: iconData.codePoint,
        color: highlightColor,
        outlineColor: highlightColor,
        size: 24,
      ),
    );
  }
}
