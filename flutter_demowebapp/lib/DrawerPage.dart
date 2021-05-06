
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demowebapp/View/AudioPlayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_demowebapp/SettingPage.dart';
import 'package:flutter_demowebapp/View/AddEntry.dart';
import 'package:flutter_demowebapp/View/ChartView.dart';
import 'package:flutter_demowebapp/View/HomePage.dart';
import 'package:flutter_demowebapp/View/ProfilePage.dart';
import 'package:flutter_demowebapp/widgets/DrawerTile.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

import 'View/ControllView.dart';
import 'View/VideoPlayerPage.dart';
import 'View/login_view.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _drawerPage();
  }
}

class _drawerPage extends State<DrawerPage>{
  static String currentPage="Home";
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Drawer(
        child: Container(
          color: theme.primaryColor,
          child: Column(children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.85,
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Image.asset("assets/imgs/now-logo.png"),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: IconButton(
                              icon: Icon(Icons.menu,
                                  color: Colors.white,
                                  size: 24.0),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.only(top: 36, left: 8, right: 16),
                children: [
                  DrawerTile(
                      icon: FontAwesomeIcons.home,
                      onTap: () {
                        if (currentPage != "Home")
                         { currentPage="Home";
                        Get.off(HomePage());}
                        else{
                          Navigator.of(context).pop();
                        }
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      iconColor:theme.accentIconTheme.color,
                      title: "Home",
                      isSelected: currentPage == "Home" ? true : false),
                  DrawerTile(
                      icon: FontAwesomeIcons.solidChartBar,
                      onTap: () {
                        if (currentPage != "Chart")
                          currentPage="Chart";
                        Get.off(ChartView());
                      },
                      iconColor: theme.accentIconTheme.color,
                      title: "Chart",
                      isSelected: currentPage == "Chart" ? true : false),
                  DrawerTile(
                      icon: FontAwesomeIcons.newspaper,
                      onTap: () {
                        if (currentPage != "Add")
                          currentPage="Add";
                          Get.off(AddEntry());
                      },
                      iconColor: theme.accentIconTheme.color,
                      title: "Add",
                      isSelected: currentPage == "Add" ? true : false),
                  DrawerTile(
                      icon: FontAwesomeIcons.user,
                      onTap: () {
                        if (currentPage != "Profile")
                        {
                        currentPage="Profile";
                        Get.off(ProfilePage());
                        }

                      },
                      iconColor:theme.accentIconTheme.color,
                      title: "Profile",
                      isSelected: currentPage == "Profile" ? true : false),
                  DrawerTile(
                      icon: FontAwesomeIcons.fileInvoice,
                      onTap: () {
                        if (currentPage != "AudioPlayer")
                          {
                          currentPage="AudioPlayer";
                          Get.off(AudioPlayerPage());}
                      },
                      iconColor: theme.accentIconTheme.color,
                      title: "AudioPlayer",
                      isSelected: currentPage == "AudioPlayer" ? true : false),
                  DrawerTile(
                      icon: FontAwesomeIcons.cog,
                      onTap: () {
                        if (currentPage != "Settings")
                          {
                            currentPage="Settings";
                            Get.off(SettingPage());
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingPage()));
                          }
                        else{
                          Navigator.of(context).pop();
                        }
                      },
                      iconColor: theme.accentIconTheme.color,
                      title: "Settings",
                      isSelected: currentPage == "Settings" ? true : false),
                ],
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //       padding: EdgeInsets.only(left: 8, right: 16),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Divider(
            //               height: 4,
            //               thickness: 0,
            //               color: NowUIColors.white.withOpacity(0.8)),
            //           Padding(
            //             padding:
            //             const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
            //             child: Text("DOCUMENTATION",
            //                 style: TextStyle(
            //                   color: NowUIColors.white.withOpacity(0.8),
            //                   fontSize: 13,
            //                 )),
            //           ),
            //           DrawerTile(
            //               icon: FontAwesomeIcons.satellite,
            //               onTap: _launchURL,
            //               iconColor: NowUIColors.muted,
            //               title: "Getting Started",
            //               isSelected:
            //               currentPage == "Getting started" ? true : false),
            //         ],
            //
            //       )),
            // ),
          ]),
        ));
  }
}