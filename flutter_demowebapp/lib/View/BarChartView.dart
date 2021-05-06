import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../DrawerPage.dart';

class BarChartView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BarChartView();
  }
}

class _BarChartView extends State<BarChartView> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 20;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 8.15, 8);
    final barGroup2 = makeGroupData(1, 8, 5);
    final barGroup3 = makeGroupData(2, 8, 5);
    final barGroup4 = makeGroupData(3, 8, 6);
    final barGroup5 = makeGroupData(4, 8, 0);
    final barGroup6 = makeGroupData(5, 8.30, 5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Card(
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Container(color: leftBarColor,width: 10,height: 10,),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Worked Hours',
                          style:
                          TextStyle(color: Color(0xff77839a), fontSize: 16),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(color: rightBarColor,width: 10,height: 10,),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Tracked Hours',
                          style:
                          TextStyle(color: Color(0xff77839a), fontSize: 16),
                        ),

                      ],)
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: BarChart(
                      BarChartData(
                        maxY: 12,
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (value) => const TextStyle(
                                color: Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            margin: 10,
                            getTitles: (double value) {
                              switch (value.toInt()) {
                                case 0:
                                  return 'Mo';
                                case 1:
                                  return 'Te';
                                case 2:
                                  return 'Wd';
                                case 3:
                                  return 'Tu';
                                case 4:
                                  return 'Fr';
                                case 5:
                                  return 'St';
                                default:
                                  return '';
                              }
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (value) => const TextStyle(
                                color: Color(0xff7589a2),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            margin: 15,
                            reservedSize: 8,
                            getTitles: (value) {
                              if (value == 0) {
                                return '0';
                              } else if (value == 1) {
                                return '1';
                              } else if (value == 2) {
                                return '2';
                              }
                              else if (value == 3) {
                                return '3';
                              }
                              else if (value == 4) {
                                return '4';
                              }
                              else if (value == 5) {
                                return '5';
                              }else if (value == 6) {
                                return '6';
                              } else if (value == 7) {
                                return '7';
                              }else if (value == 8) {
                                return '8';
                              }else if (value == 9) {
                                return '9';
                              }else if (value == 10) {
                                return '10';
                              }else if (value == 11) {
                                return '11';
                              }else if (value == 12) {
                                return '12';
                              }
                              else {
                                return '';
                              }
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),);
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

}