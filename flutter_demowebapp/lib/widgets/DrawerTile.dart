


import 'package:flutter/material.dart';
import 'package:flutter_demowebapp/Constant/AppColor.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final bool isSelected;
  final Color iconColor;

  DrawerTile(
      {this.title,
        this.icon,
        this.onTap,
        this.isSelected = false,
        this.iconColor = AppColor.White});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(top: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: isSelected
                        ? Colors.black.withOpacity(0.07)
                        : Colors.transparent,
                    offset: Offset(0, 0.5),
                    spreadRadius: 3,
                    blurRadius: 10)
              ],
              color: isSelected ? Colors.white.withOpacity(0.8) : theme.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            children: [
              Icon(icon,
                  size: 18,
                  color: isSelected
                      ? theme.primaryColor
                      : Colors.white),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: isSelected
                            ? theme.primaryColor
                            : Colors.white)),
              )
            ],
          )),
    );
  }
}