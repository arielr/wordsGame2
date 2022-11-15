import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../model/settings_data.dart';

class SettingsScreen extends StatefulWidget {
  SettingsData settingsData;

  SettingsScreen(this.settingsData);

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreen();
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  late bool _enableTime;
  late int _timeoutSeconds;

  @override
  void initState() {
    _enableTime = widget.settingsData.enableTime;
    _timeoutSeconds = widget.settingsData.timeoutSeconds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(
              'Common',
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
                trailing: Icon(Icons.navigate_next),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  setState(() {
                    _enableTime = !_enableTime;
                  });
                  SettingsData.globalSettings.enableTime = _enableTime;
                },
                initialValue: _enableTime,
                // enabled: _enableTimer,
                leading: Icon(Icons.timer),
                title: Text('Enable timer'),
              ),
              SettingsTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_formatTime(_timeoutSeconds)),
                    Slider(
                      value: _timeoutSeconds.toDouble(),
                      max: 60 * 5,
                      min: 5,
                      label: _timeoutSeconds.toString(),
                      onChanged: _enableTime ? updateSecondsTimeout : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateSecondsTimeout(double newTimeout) {
    setState(() {
      _timeoutSeconds = newTimeout.toInt();
    });

    SettingsData.globalSettings.timeoutSeconds = _timeoutSeconds;
  }

  String _formatTime(int timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
