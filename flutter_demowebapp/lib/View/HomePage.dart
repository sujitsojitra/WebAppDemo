import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_demowebapp/Constant/AppColor.dart';
import 'package:flutter_demowebapp/controller/home_controller.dart';
import 'package:http/http.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import '../DrawerPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with WidgetsBindingObserver{
  final LocalAuthentication auth = LocalAuthentication();
  final HomeController _homeController = Get.put(HomeController());

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var mode=prefs.getString("ThemeMode");
      if(mode=="ThemeMode.light"){
        ThemeModeHandler.of(context).saveThemeMode(ThemeMode.light);
      }
      else if(mode=="ThemeMode.dark")
      {
        ThemeModeHandler.of(context).saveThemeMode(ThemeMode.dark);
      }
      else{
        ThemeModeHandler.of(context).saveThemeMode(ThemeMode.system);
      }
    })();
    //WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height-100) / 2;
    final double itemWidth = size.width / 2;
    final themeMode = ThemeModeHandler.of(context).themeMode;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      body:
      Container(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child:
              Obx(
                    () => (
                        _homeController.isLoading.value)
                    ?
                    Shimmer.fromColors(
                      enabled: _homeController.isLoading.value,
                        baseColor: Colors.black26,
                        highlightColor: Colors.black12,
                        child:
                        Column(
                          children: [
                          Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.list),
                            onPressed: () {
                            },
                          ),
                        ),
                        Expanded(child:
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: List.generate(8,
                                  (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  color: theme.cardColor,
                                  borderOnForeground: true,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child:
                                        Image.asset(
                                          "assets/imgs/Road.jpeg",
                                          fit: BoxFit.fill,
                                          width: itemWidth,
                                          height: MediaQuery.of(context).size.height * 0.40,
                                        ),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text(
                                          "Testing data",
                                        ),
                                        subtitle: Text(
                                          "",
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                        )
                          ]
                        )
                    )
                    : Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.list),
                        onPressed: () {
                          _homeController.isGrid.value =
                          !_homeController.isGrid.value;
                          print(_homeController.isGrid.value);
                        },
                      ),
                    ),
                    (_homeController.isGrid.value)
                        ? Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: List.generate(
                              _homeController.userListData.length,
                                  (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  color: theme.cardColor,
                                  borderOnForeground: true,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child:
                                        Image.asset(
                                          "assets/imgs/Road.jpeg",
                                          fit: BoxFit.fill,
                                          width: itemWidth,
                                          height: MediaQuery.of(context).size.height * 0.40,
                                        ),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                        title: Text(
                                          (_homeController
                                              .userListData[index]
                                              .username !=
                                              null)
                                              ? _homeController
                                              .userListData[index]
                                              .username
                                              : "",
                                        ),
                                        subtitle: Text(
                                          (_homeController
                                              .userListData[index]
                                              .email !=
                                              null
                                              ? _homeController
                                              .userListData[index].email
                                              : ""),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ))
                        : Expanded(
                      child: ListView.builder(
                        itemCount:
                        _homeController.userListData.length,
                        itemBuilder: (context, index) {
                          final item = _homeController.userListData[index];
                          return Dismissible(
                              key: Key(item.id.toString()),
                            onDismissed: (direction) {
                              // Remove the item from the data source.
                              setState(() {
                                _homeController.userListData.removeAt(index);
                              });

                              // Then show a snackbar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text("$item dismissed")));
                            },
                              child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0),
                            ),
                            color: theme.cardColor,
                            borderOnForeground: true,
                            margin: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/imgs/Road.jpeg",
                                  fit: BoxFit.fill,
                                  width: size.width,
                                  height: MediaQuery.of(context).size.height * 0.20,
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                  title: Text(
                                    (_homeController
                                        .userListData[index]
                                        .username !=
                                        null)
                                        ? _homeController
                                        .userListData[index]
                                        .username
                                        : "",
                                  ),
                                  subtitle: Text(
                                    (_homeController
                                        .userListData[index]
                                        .email !=
                                        null
                                        ? _homeController
                                        .userListData[index].email
                                        : ""),
                                  ),
                                )
                              ],
                            ),
                          ),
                              background: Container(color: Colors.red,
                              child: Center(child: Icon(Icons.delete_rounded,color: Colors.white,),),),
                          ) ;
                        }
                      ),
                    ),
                  ],
                 ),
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerPage(),
    );
  }
}
