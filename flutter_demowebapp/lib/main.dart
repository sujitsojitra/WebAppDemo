import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'Constant/AppColor.dart';
import 'MyManager.dart';
import 'View/HomePage.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  //runApp(MaterialApp(home: isLogin == null ? SocialLogin() : note_list()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      manager: MyManager(),
      builder: (ThemeMode themeMode) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          darkTheme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
            textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: 16),
              bodyText2: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ).apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            // other properties...
          ),
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: 16),
              bodyText2: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            ).apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
            backgroundColor:Colors.white,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color(0xFFD4D4D4)),
            brightness: Brightness.light,
            primarySwatch: AppColor.PrimaryColorDARK_BLUE,
            primaryColor: AppColor.PrimaryColorDARK_BLUE,
            accentColor: Color(0xFF0E7AC7),
            accentIconTheme: IconThemeData(color: AppColor.White),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Color(0xffffffff),
            ),
          ),
          home: HomePage(),
        );
      },
    );
  }
}

