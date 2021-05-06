import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColor {
  static const Color AppBAr_BAR_END = Color(0xFF85C1E9);
  static const Color AppBAr_BAR_BEGIN = Color(0xFF3498DB);
  static const Color STATUS_BAR_COLOR = Color(0xFF3498DB);
  static const Color TITLE_BAR_COLOR = Color(0xFF4D1544);
  static const Color ACCENT_COLOR = Color(0xFF3498DB);
  static const Color ACCENT_COLOR_unselect = Color(0xFF6c6b6b);
  static const Color SCREEN_BG = Color(0xFFffffff);
  static const Color DIVIDER_COLOR = Color(0xFFBDBDBD);
  static const Color INTRO_TEXT_COLOR = Color(0xFF979797);
  static const Color SELECTED_DOT_COLOR = Color(0xFF4D1544);
  static const Color TEXT_COLOR = Color(0xFF85C1E9);
  static const Color SELECTED_ITEM_BG = Color(0x1De95737);
  static const Color MENU_ICON_COLOR = Color(0xFF4D1544);
  static const Color APP_GRAY = Color(0xFF9E9E9E);
  static const Color BOTTOM_NAVIGATION_SELECTED_COLOR = Color(0xFFffffff);
  static const Color TRANSPARENT_FLOATING_BG_COLOR = Color(0xBA4D1544);
  static const Color PROFILE_TEXT_COLOR = Color(0xFFAFAFAF);
  static const Color SETTINGS_TITLE_COLOR = Color(0xFF4D1544);
  static const Color SELECTED_LANGUAGE_COLOR = Color(0xFFB59EB2);
  static const Color COMMENT_DESCRIPTION_COLOR = Color(0xFF484848);
  static const Color COMMENT_BOX_COLOR = Color(0xFFEEF3FA);
  static const Color CARD_BG = Color(0xFFfbfbfc);

  static const Color LIGHT_BLUE = Color(0xFF85C1E9);
  static const Color DARK_BLUE = Color(0xFF3498DB);
  static const Color White = Color(0xFFfbfbfc);

  static const MaterialColor PrimaryColorDARK_BLUE = const MaterialColor(
    0xFF0E7AC7,
    const <int, Color>{
      50: const Color(0xFF0E7AC7),
      100: const Color(0xFF0E7AC7),
      200: const Color(0xFF0E7AC7),
      300: const Color(0xFF0E7AC7),
      400: const Color(0xFF0E7AC7),
      500: const Color(0xFF0E7AC7),
      600: const Color(0xFF0E7AC7),
      700: const Color(0xFF0E7AC7),
      800: const Color(0xFF0E7AC7),
      900: const Color(0xFF0E7AC7),
    },
  );

  static const MaterialColor PrimaryColorLight_BLUE = const MaterialColor(
    0xFF0E7AC7,
    const <int, Color>{
      50: const Color(0xFF60AFE9),
      100: const Color(0xFF60AFE9),
      200: const Color(0xFF60AFE9),
      300: const Color(0xFF60AFE9),
      400: const Color(0xFF60AFE9),
      500: const Color(0xFF60AFE9),
      600: const Color(0xFF60AFE9),
      700: const Color(0xFF60AFE9),
      800: const Color(0xFF60AFE9),
      900: const Color(0xFF60AFE9),
    },
  );


}
Widget getLoader(){
  return Image.asset(
    "assets/imgs/Loader.gif",
    height: 125.0,
    width: 125.0,
  );
}

//12 hr to string
String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

//string to 24 hr
TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.Hm(); //"24:00"
  return TimeOfDay.fromDateTime(format.parse(tod));
}
//24 hr to string
String formatTimeOfDay24Hr(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.Hm(); //"24:00"
  return format.format(dt);
}

//12 hr string to 24 string
String stringToTimeOfDay24(String tod) {
  DateTime date= DateFormat.jm().parse(tod);
  return DateFormat("HH:mm").format(date);
}
