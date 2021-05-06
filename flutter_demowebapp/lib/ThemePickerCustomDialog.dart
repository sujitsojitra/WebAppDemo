import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';

import 'Constant/AppColor.dart';

const _themeModeOptions = [
  {'id': 0, 'label': 'System', 'value': ThemeMode.system, 'isSelected': true},
  {'id': 1, 'label': 'Light', 'value': ThemeMode.light, 'isSelected': false},
  {'id': 2, 'label': 'Dark', 'value': ThemeMode.dark, 'isSelected': false},
];

/// A `SimpleDialog` with `ThemeMode.values` as options.
class ThemePickerCustomDialog extends StatefulWidget {
  /// Creates a `ThemePickerDialog`.
  const ThemePickerCustomDialog({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ThemePickerCustomDialog();
  }
}

class _ThemePickerCustomDialog extends State<ThemePickerCustomDialog> {
  int selectedVal;
  @override
  void initState() {
    // TODO: implement initState
    selectedVal = 0;
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var mode = prefs.getString("ThemeMode");
      var ModeOfTheme = ThemeModeHandler.of(context).themeMode.toString();
      if (mode == "ThemeMode.light") {
        selectedVal = 1;
      } else if (mode == "ThemeMode.dark") {
        selectedVal = 2;
      } else {
        selectedVal = 0;
      }
      setState(() {});
    })();
  }
  // void _handleRadioValueChange2(int value) {
  //   setState(() {
  //
  //     switch (value) {
  //       case 0:
  //           print("System");
  //         break;
  //       case 1:
  //         print("Light");
  //         break;
  //       case 2:
  //         print("Dark");
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SimpleDialog(
      title: Center(
          child: const Text('Choose theme', style: TextStyle(fontSize: 22))),
      children: _themeModeOptions.map((option) {
        return SimpleDialogOption(
            onPressed: () async {
              setState(() {
                selectedVal = option['id'];
                print(selectedVal);
                ThemeModeHandler.of(context).saveThemeMode(option['value']);
              });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("ThemeMode", option['value'].toString());
              var d = prefs.getString("ThemeMode");
              print("Mode:" + d);
              //Navigator.pop(context, true);
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: option['id'],
                      groupValue: selectedVal,
                    ),
                    Text(
                      option['label'],
                    ),
                  ],
                )));
      }).toList(),
    );
  }
}

/// Displays a `SimpleDialog` with `ThemeMode.values` as options.
Future<ThemeMode> showThemePickerCustomDialog(
    {@required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (_) => ThemePickerCustomDialog(),
  );
}
