import 'package:flutter/material.dart';
import '../DrawerPage.dart';
import 'BarChartView.dart';
import 'LineChartView.dart';

class ChartView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChartView();
  }
}

class _ChartView extends State<ChartView> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    BarChartView(),
    LineChartView(),
    Center(child: Text("2")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Chart', textAlign: TextAlign.center),
        ),
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
      body: tabItems.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "Bar Chart",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.multiline_chart),
                label:"Line Chart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Test",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }


}
