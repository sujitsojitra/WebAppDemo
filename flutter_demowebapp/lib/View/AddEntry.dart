import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_demowebapp/Constant/AppColor.dart';
import '../DrawerPage.dart';

class AddEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEntry();
  }
}

class _AddEntry extends State<AddEntry> {
  String _chosenValue;
  List<String> itemList = [
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP'
  ];


  DateTime currentDate = DateTime.now();
  DateTime meetingDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2015),
      lastDate: currentDate,
      helpText: 'Select Worked date',
      // Can be used as title
      cancelText: 'Not valid',
      confirmText: 'Worked date',
    );

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
  }

  Future<void> _selectMeetingDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: meetingDate,
      firstDate: meetingDate,
      lastDate: DateTime(2025),
      helpText: 'Select Meeting date',
      // Can be used as title
      cancelText: 'Not valid',
      confirmText: 'Meeting date',
    );

    if (pickedDate != null && pickedDate != meetingDate)
      setState(() {
        meetingDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
  }

  TimeOfDay selectedInTime = TimeOfDay.now();
  TimeOfDay selectedOutTime = TimeOfDay.now();
  TimeOfDay selectedBreakInTime = TimeOfDay.now();
  TimeOfDay selectedBreakOutTime = TimeOfDay.now();
  TimeOfDay selectedWorkedTime = TimeOfDay.now();
  TimeOfDay selectedTrackedTime = TimeOfDay.now();

  Future<void> _selectInTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedInTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedInTime=picked_s;
        inTimeController.text = formatTimeOfDay(picked_s);
      });
  }

  Future<void> _selectOutTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedOutTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedOutTime=picked_s;
        outTimeController.text = formatTimeOfDay(picked_s);
      });
  }

  Future<void> _selectBreakInTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedBreakInTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedBreakInTime=picked_s;
        breakInTimeController.text = formatTimeOfDay(picked_s);
      });
  }

  Future<void> _selectBreakOutTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedBreakOutTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedBreakOutTime=picked_s;
        breakOutTimeController.text = formatTimeOfDay(picked_s);
      });
  }

  Future<void> _selectWorkedTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedWorkedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedWorkedTime=picked_s;
        workedTimeController.text = formatTimeOfDay24Hr(picked_s);
      });
  }

  Future<void> _selectTrackedTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTrackedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child,
          );
        });

    if (picked_s != null)
      setState(() {
        selectedTrackedTime=picked_s;
        trackedTimeController.text = formatTimeOfDay24Hr(picked_s);
      });
  }

  @override
  void initState() {
    // TODO: implement initState

    dateController.text = DateFormat('dd-MM-yyyy').format(currentDate);
    meetingDateController.text= DateFormat('dd-MM-yyyy').format(currentDate);
    TimeOfDay _startTime =
        TimeOfDay(hour: int.parse("10"), minute: int.parse("00"));
    selectedInTime = _startTime;
    inTimeController.text = formatTimeOfDay(selectedInTime);

    TimeOfDay _outTime =
        TimeOfDay(hour: int.parse("19"), minute: int.parse("00"));
    selectedOutTime = _outTime;
    outTimeController.text = formatTimeOfDay(selectedOutTime);

    TimeOfDay _breakInTime =
    TimeOfDay(hour: int.parse("13"), minute: int.parse("15"));
    selectedBreakInTime = _breakInTime;
    breakInTimeController.text = formatTimeOfDay(selectedBreakInTime);

    TimeOfDay _breakOutTime =
    TimeOfDay(hour: int.parse("14"), minute: int.parse("00"));
    selectedBreakOutTime = _breakOutTime;
    breakOutTimeController.text = formatTimeOfDay(selectedBreakOutTime);

    TimeOfDay _workedTime =
    TimeOfDay(hour: int.parse("08"), minute: int.parse("00"));
    selectedWorkedTime = _workedTime;
    workedTimeController.text = formatTimeOfDay24Hr(_workedTime);

    TimeOfDay _trackedTime =
    TimeOfDay(hour: int.parse("00"), minute: int.parse("00"));
    selectedTrackedTime = _trackedTime;
    trackedTimeController.text = formatTimeOfDay24Hr(_trackedTime);

    super.initState();
  }

  // GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();
  final dateController = TextEditingController();
  final inTimeController = TextEditingController();
  final outTimeController = TextEditingController();
  final meetingDateController = TextEditingController();
  final breakInTimeController = TextEditingController();
  final breakOutTimeController = TextEditingController();
  final workedTimeController = TextEditingController();
  final trackedTimeController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Add', textAlign: TextAlign.center),
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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Project Name",
                    style: TextStyle(color: AppColor.DARK_BLUE)),
                SizedBox(
                  height: 5,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _chosenValue,
                  style: Theme.of(context).textTheme.bodyText1,
                  items: itemList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a langauage",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Client Name",
                    style: TextStyle(color: AppColor.DARK_BLUE)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Natrix Software",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Worked Date",
                    style: TextStyle(color: AppColor.DARK_BLUE)),
                IntrinsicWidth(
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        //prefixIcon: Icon(Icons.date_range_sharp),
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 35,
                          minWidth: 35,
                        ),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: AppColor.DARK_BLUE),
                        hintText: 'Pick your Worked Date'),
                    onTap: () async {
                      _selectDate(context);
                      //dateController.text = currentDate.toString().substring(0,10);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('In Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: AppColor.DARK_BLUE)),
                    Expanded(
                        child: Text('Out Time',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: AppColor.DARK_BLUE))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IntrinsicWidth(
                        child: TextField(
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: inTimeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              //prefixIcon: Icon(Icons.date_range_sharp),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 35,
                                minWidth: 35,
                              ),
                              prefixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.DARK_BLUE,
                              ),
                              hintText: 'In Time'),
                          onTap: () async {
                            _selectInTime(context);
                            //dateController.text = currentDate.toString().substring(0,10);
                          },
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.end,
                        readOnly: true,
                        controller: outTimeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            //prefixIcon: Icon(Icons.date_range_sharp),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 35,
                              minWidth: 35,
                            ),
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: AppColor.DARK_BLUE,
                            ),
                            hintText: 'Out'),
                        onTap: () async {
                          _selectOutTime(context);
                          //dateController.text = currentDate.toString().substring(0,10);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('Break In Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: AppColor.DARK_BLUE)),
                    Expanded(
                        child: Text('Break Out Time',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: AppColor.DARK_BLUE))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IntrinsicWidth(
                        child: TextField(
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: breakInTimeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              //prefixIcon: Icon(Icons.date_range_sharp),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 35,
                                minWidth: 35,
                              ),
                              prefixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.DARK_BLUE,
                              ),
                              hintText: 'Break In Time'),
                          onTap: () async {
                            _selectBreakInTime(context);
                            //dateController.text = currentDate.toString().substring(0,10);
                          },
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.end,
                        readOnly: true,
                        controller: breakOutTimeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            //prefixIcon: Icon(Icons.date_range_sharp),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 35,
                              minWidth: 35,
                            ),
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: AppColor.DARK_BLUE,
                            ),
                            hintText: 'B Out'),
                        onTap: () async {
                          _selectBreakOutTime(context);
                          //dateController.text = currentDate.toString().substring(0,10);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Text('Worked Hours',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: AppColor.DARK_BLUE)),
                    Expanded(
                        child: Text('Tracked Hours',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: AppColor.DARK_BLUE))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IntrinsicWidth(
                        child: TextField(
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: workedTimeController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              //prefixIcon: Icon(Icons.date_range_sharp),
                              prefixIconConstraints: BoxConstraints(
                                minHeight: 35,
                                minWidth: 35,
                              ),
                              prefixIcon: Icon(
                                Icons.access_time,
                                color: AppColor.DARK_BLUE,
                              ),
                              hintText: 'Break In Time'),
                          onTap: () async {
                            _selectWorkedTime(context);
                            //dateController.text = currentDate.toString().substring(0,10);
                          },
                        ),
                      ),
                    ),
                    IntrinsicWidth(
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.end,
                        readOnly: true,
                        controller: trackedTimeController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            //prefixIcon: Icon(Icons.date_range_sharp),
                            prefixIconConstraints: BoxConstraints(
                              minHeight: 35,
                              minWidth: 35,
                            ),
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: AppColor.DARK_BLUE,
                            ),
                            hintText: 'B Out'),
                        onTap: () async {
                          _selectTrackedTime(context);
                          //dateController.text = currentDate.toString().substring(0,10);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Task Description",
                    style: TextStyle(color: AppColor.DARK_BLUE)),
                // SizedBox(height: 10),
                // FlutterSummernote(
                //   height: 250,
                //   hint: "Enter task description...",
                //   key: _keyEditor,
                //   hasAttachment: false,
                //   customToolbar: """
                //   [
                //     ['style', ['bold', 'italic', 'underline']],
                //     ['para', ['ul', 'ol', 'paragraph']],
                //     ['insert', ['link']]
                //   ]
                // """,
                // ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: toggleSwitch,
                      activeColor: AppColor.DARK_BLUE,
                    ),
                    Text(
                      "Need Meeting?",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                (isSwitched)
                    ? Padding(padding: EdgeInsets.only(left: 30),child: IntrinsicWidth(
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    readOnly: true,
                    controller: meetingDateController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        //prefixIcon: Icon(Icons.date_range_sharp),
                        prefixIconConstraints: BoxConstraints(
                          minHeight: 35,
                          minWidth: 35,
                        ),
                        prefixIcon: Icon(Icons.date_range_sharp,
                            color: AppColor.DARK_BLUE),
                        hintText: 'Pick your Meeting Date'),
                    onTap: () async {
                      _selectMeetingDate(context);
                      //dateController.text = currentDate.toString().substring(0,10);
                    },
                  ),
                ),)
                    : Container(),
                SizedBox(height: 10),
                Row(children: [ Expanded(child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 10),
                  onPressed: () async {
                    print("Project: "+_chosenValue);
                    // final _etEditor = await _keyEditor.currentState.getText();
                    //print("Description: "+_etEditor);
                    print("Worked Date: "+dateController.text);
                    print("In Time: "+ stringToTimeOfDay24(outTimeController.text));
                  },
                  child: Text("Add"),))],),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
    );
  }
}
