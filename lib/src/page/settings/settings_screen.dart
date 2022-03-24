import 'package:flutter/material.dart';
import 'package:calorie_tracker_app/src/model/food_track_task.dart';
import 'package:calorie_tracker_app/src/model/food_model.dart';
import 'package:calorie_tracker_app/component/iconpicker/icon_picker_builder.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen();

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBack = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // const IconData computer = IconData(0xe185, fontFamily: 'MaterialIcons');
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Settings',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          tiles: [
            SettingsTile(
              title: Text('Language',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              value: Text('English',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: Text('Environment',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              // subtitle: 'English',
              value: Text('Development',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.computer),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: Text('Environment',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              // subtitle: 'English',
              value: Text('Development',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          title: Text('Account',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          tiles: [
            SettingsTile(
                title: Text('Phone Number',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.local_phone)),
            SettingsTile(
                title: Text('Email',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.email)),
            SettingsTile(
                title: Text('Sign out',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.logout)),
          ],
        ),
        SettingsSection(
          title: Text('Misc',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          tiles: [
            SettingsTile(
                title: Text('Terms of Service',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.document_scanner)),
            SettingsTile(
                title: Text('Open source licenses',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.collections_bookmark)),
          ],
        )
      ],
    );
  }
}
