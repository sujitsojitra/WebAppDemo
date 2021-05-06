import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_demowebapp/View/AuthonticateView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

import 'CommonControll/CustomDialogBox.dart';
import 'Constant/AppColor.dart';
import 'DrawerPage.dart';
import 'ThemePickerCustomDialog.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _settingPage();
  }
}

class _settingPage extends State<SettingPage> {
  @override
  void initState() {
    _asyncMethod();
    // TODO: implement initState
    super.initState();
  }
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }
  _asyncMethod() async {
    List<BiometricType> availableBiometrics;
    availableBiometrics = await auth.getAvailableBiometrics();
    canCheckBiometrics = await auth.canCheckBiometrics;
    print(canCheckBiometrics);
    setState(() {
    });
  }

  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool canCheckBiometrics=false;
  bool authenticated = false;
  Future<void> _authenticate() async {

    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      print("Check=$canCheckBiometrics");
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'For open application authentication required',
          useErrorDialogs: true,
          stickyAuth: true);
      if (!mounted) return;
      setState(() {
        _authorized = authenticated ? 'Authorized' :
        showDialog(context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "App is locked ",
                descriptions: "For your security, You can only use app when it's unlocked",
                OK: "Unlock",
                Cancle: "Cancle",
                onPress: (){

                  //SystemNavigator.pop();
                  print("Execute");
                },
              );
            }
        );
      });
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final themeMode = ThemeModeHandler.of(context).themeMode;
    print(themeMode.toString());
    return Scaffold(
      appBar: AppBar(
        title: Center( child: Text('Settings',textAlign: TextAlign.center),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.transparent,
            ),
          )
        ],
      ),
      drawer: DrawerPage(),
      body: Column(
        children: [
          SizedBox(height: 15,),
          GestureDetector(
            child:Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10,right: 10),
              shape: Border(left: BorderSide(color: AppColor.DARK_BLUE, width: 6)),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10,),
                    Text('Tap to set Theme',style: Theme.of(context).textTheme.bodyText1,),
                  ],),
                padding: EdgeInsets.all(15),
              ),
            ),
            onTap: () => _selectThemeMode(context),
          ),
          SizedBox(height: 15,),
          canCheckBiometrics?
          GestureDetector(
            child:Card(
              elevation: 5,
              margin: EdgeInsets.only(left: 10,right: 10),
              shape: Border(left: BorderSide(color: AppColor.DARK_BLUE, width: 6)),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 10,),
                    Text('Tap to set finger print',style: Theme.of(context).textTheme.bodyText1,),
                    Spacer(),
                    Switch(
                      value: authenticated,
                      onChanged: toggleSwitch,
                      activeColor: AppColor.DARK_BLUE,
                    ),
                  ],),
                padding: EdgeInsets.only(left: 15),
              ),
            ),
            onTap: () => {
              _authenticate()
              //Get.to(AuthonticateView())
            },
          ):Container(),

        ],
      ),
    );
  }

  void _selectThemeMode(BuildContext context) async {
    final newThemeMode = await showThemePickerCustomDialog(context: context);

  }
}

