import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_table/SizeConfig.dart';
import 'dart:async';
import 'models.dart';

List<Period> timeTable = List();

DateTime collegeStart = DateTime.now();
DateTime collegeEnd = DateTime.now();
DateTime relativeEnding;

bool displayTimer = false;

_CurrentState currentPeriodState = _CurrentState();
CurrentPeriod indicator = CurrentPeriod();

void main() {
  collegeStart = DateTime(
      collegeStart.year, collegeStart.month, collegeStart.day, 10, 0, 0, 0, 0);
  collegeEnd = DateTime(
      collegeStart.year, collegeStart.month, collegeStart.day, 16, 40, 0, 0, 0);

  switch (DateFormat('EEEE').format(DateTime.now())){
    case "Monday":
      timeTable.add(Period("Chemistry", 50));
      timeTable.add(Period("BCEM", 50));
      timeTable.add(Period("English", 50));
      timeTable.add(Period("RECESS", 50));
      timeTable.add(Period("Chem/BCEM Lab", 100));
      timeTable.add(Period("Chem/BCEM Lab", 100));
      break;

    case "Tuesday":
      timeTable.add(Period("English", 50));
      timeTable.add(Period("Math", 50));
      timeTable.add(Period("BCEM", 50));
      timeTable.add(Period("RECESS", 50));
      timeTable.add(Period("PPS", 50));
      timeTable.add(Period("Chemistry", 50));
      timeTable.add(Period("Self Study", 100));
      break;

    case "Wednesday":
      timeTable.add(Period("Math", 50));
      timeTable.add(Period("Chemistry", 50));
      timeTable.add(Period("PPS", 50));
      timeTable.add(Period("RECESS", 50));
      timeTable.add(Period("English", 50));
      timeTable.add(Period("BCEM", 50));
      timeTable.add(Period("Self Study", 100));
      break;

    case "Thursday":
      timeTable.add(Period("PPS Lab", 100));
      timeTable.add(Period("Chemistry", 50));
      timeTable.add(Period("RECESS", 50));
      timeTable.add(Period("PPS", 50));
      timeTable.add(Period("Math", 50));
      timeTable.add(Period("Self Study", 100));
      break;

    case "Friday":
      timeTable.add(Period("BCEM", 50));
      timeTable.add(Period("PPS", 50));
      timeTable.add(Period("Math", 50));
      timeTable.add(Period("RECESS", 50));
      timeTable.add(Period("Chemistry", 50));
      timeTable.add(Period("English", 50));
      timeTable.add(Period("Language Lab", 100));
      break;

    case "Saturday":
      timeTable.add(Period("Math", 50));
      timeTable.add(Period("Workshop", 150));
      timeTable.add(Period("Self Study", 50));
      break;

    case "Sunday":
      timeTable.add(Period("Self Study", 14 * 60));
      break;
  }

  setupExactTimes();
  runApp(MaterialApp(home: Home(), theme: ThemeData(fontFamily: "ProductSans")));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xff212121),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        DateFormat('EEEE').format(DateTime.now()),
                        style:
                            TextStyle(color: Color(0xffB3E5FC), fontSize: SizeConfig.safeBlockHorizontal * 10),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Divider(
                      color: Colors.grey,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 13.5),
                  child: Center(
                    child: Column(
                      children: <Widget>[indicator],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.5),
                  child: Center(
                    child: Column(
                      children: <Widget>[ActiveTime()],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Divider(
                      color: Colors.grey,
                    )),
                Expanded(child: RemainingPeriods())
              ],
            ),
          ),
        ));
  }
}

String determinePeriod() {
  DateTime now = DateTime.now();
  if (now.compareTo(collegeStart) >= 0 && now.compareTo(collegeEnd) <= 0) {
    displayTimer = true;
    for (Period period in timeTable) {
      if (now.compareTo(period.startsAt) >= 0 &&
          now.compareTo(period.endsAt) <= 0) {
        relativeEnding = period.endsAt;
        return period.name;
      }
    }
  }

  return "TimeTable";
}

void setupExactTimes() {
  DateTime tmpTime = collegeStart;
  for (Period period in timeTable) {
    period.startsAt = tmpTime;
    tmpTime = tmpTime.add(Duration(minutes: period.lengthInMinutes));
    period.endsAt = tmpTime;
  }
}

class CurrentPeriod extends StatefulWidget {
  _CurrentState createState() => currentPeriodState;
}

class _CurrentState extends State<CurrentPeriod> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Text(determinePeriod(),
        style: TextStyle(
            color: Color(0xffDCEDC8),
            fontSize: SizeConfig.safeBlockHorizontal * 15));
  }
}

class RemainingPeriods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int actualCount = -1;
    return ListView.builder(
      itemCount: timeTable.length * 2,
      padding: EdgeInsets.all(2.5),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return Divider(color: Colors.grey);
        else
          actualCount++;
        return ListTile(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(timeTable[actualCount].name,
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6.5, color: Color(0xffDCEDC8))),
            RichText(
              textAlign: TextAlign.end,
              text: new TextSpan(
                style: new TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: SizeConfig.safeBlockHorizontal * 6.5,
                  color: Color(0xffFFF9C4),
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: DateFormat("hh:mm")
                          .format(timeTable[actualCount].startsAt)),
                  TextSpan(
                      text: '-',
                      style: TextStyle(fontSize: 25, color: Color(0xffFFCDD2))),
                  TextSpan(
                      text: DateFormat("hh:mm a")
                          .format(timeTable[actualCount].endsAt)),
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}

class ActiveTime extends StatefulWidget {
  @override
  _ActiveTimeState createState() => _ActiveTimeState();
}

class _ActiveTimeState extends State<ActiveTime> {
  String _timeString;

  @override
  void initState() {
    if (displayTimer) {
      _timeString =
          '~' + _formatDateTime(relativeEnding.difference(DateTime.now()));
      Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    } else {
      _timeString = "by Udit";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: TextStyle(color: Color(0xffFFCDD2), fontSize: SizeConfig.safeBlockHorizontal * 13),
    );
  }

  void _getTime() {
    DateTime now = DateTime.now();
    final String formattedDateTime =
        _formatDateTime(relativeEnding.difference(now));
    setState(() {
      _timeString = '~' + formattedDateTime;
    });
  }

  String _formatDateTime(Duration duration) {
    int hours = 0, minutes = 0, seconds = duration.inSeconds;
    String hoursStr, minutesStr, secondsStr;

    if (seconds > 60) minutes = seconds ~/ 60;
    if (minutes > 60) hours = minutes ~/ 60;

    seconds = seconds - 60 * minutes - 60 * 60 * hours;
    minutes = minutes - 60 * hours;

    if (seconds < 10)
      secondsStr = "0" + seconds.toString();
    else
      secondsStr = seconds.toString();
    if (minutes < 10)
      minutesStr = "0" + minutes.toString();
    else
      minutesStr = minutes.toString();
    if (hours < 10)
      hoursStr = "0" + hours.toString();
    else
      hoursStr = hours.toString();

    if (seconds == 0 && minutes == 0 && hours == 0)
      currentPeriodState.refresh();
    return hoursStr + ':' + minutesStr + ':' + secondsStr;
  }
}
