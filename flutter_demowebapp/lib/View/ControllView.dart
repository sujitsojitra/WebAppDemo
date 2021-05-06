
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../DrawerPage.dart';

class ControllView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ControllView();
  }

}

class _ControllView extends State<ControllView>{
  CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: currentDate,
        helpText: 'Select Birth date', // Can be used as title
        cancelText: 'Not valid',
        confirmText: 'Birthday',
    );

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
  String format="Month";
  @override
  Widget build(BuildContext context) {
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
      body:SingleChildScrollView(child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 10,
              percent: 0.8,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
          ElevatedButton(child: Text(format), onPressed:()=> {
            setState(() {
              var formate=_controller.calendarFormat;
              if(formate==CalendarFormat.week) {
                format="Week";
                _controller.setCalendarFormat(CalendarFormat.month);
              }
              else if(formate==CalendarFormat.month){
                format="Month";
                _controller.setCalendarFormat(CalendarFormat.week);
              }
            })
          }),
          // formatButtonDecoration: BoxDecoration(
          //   color: Theme.of(context).primaryColor,
          //   borderRadius: BorderRadius.circular(20.0),
          // ),
          TableCalendar(
            initialCalendarFormat: CalendarFormat.week,
            calendarStyle: CalendarStyle(
                todayColor: Colors.orange,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonVisible: false,
            ),
            availableCalendarFormats: const {
              CalendarFormat.month: '',
              CalendarFormat.week: '',
            },
            // daysOfWeekStyle: DaysOfWeekStyle(
            //   weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
            // ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected:(date, events,event) {
              print(date.toString());
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            calendarController: _controller,
          ),
          // Text(currentDate.toString()),
          // SizedBox(
          //   height: 20.0,
          // ),
          // ElevatedButton(
          //   onPressed: () => _selectDate(context),
          //   child: Text('Select date'),
          // ),
        ],
      ),),
    );
  }
}