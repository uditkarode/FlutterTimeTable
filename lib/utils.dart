import 'package:flutter/material.dart';
import 'package:time_table/SizeConfig.dart';
import 'globals.dart';
import 'models.dart';


void assignTimeTable(String currentDay) {
  timeTable.clear();
  switch (currentDay) {

case "Monday":
      timeTable.add(Period("SEPM", 50));
      timeTable.add(Period("AIES", 50));
      timeTable.add(Period("CNS", 50));
      timeTable.add(Period("IOT", 50));
      timeTable.add(Period("Recess", 50));
      timeTable.add(Period("CD", 50));
      timeTable.add(Period("TCSS", 100));
      break;

    case "Tuesday":
      timeTable.add(Period("CNS", 50));
      timeTable.add(Period("IOT", 50));
      timeTable.add(Period("AIES", 50));
      timeTable.add(Period("SEPM", 50));
      timeTable.add(Period("Recess", 50));
      timeTable.add(Period("Android LAB", 150));
      break;

    case "Wednesday":
      timeTable.add(Period("AIES", 50));
      timeTable.add(Period("SEPM LAB", 150));
      timeTable.add(Period("Recess", 50));
      timeTable.add(Period("CNS", 50));
      timeTable.add(Period("SEPM", 50));
      timeTable.add(Period("CD", 50));
      break;

    case "Thursday":
      timeTable.add(Period("CD", 50));
      timeTable.add(Period("IOT", 50));
      timeTable.add(Period("AIES", 50));
      timeTable.add(Period("CNS", 50));
      timeTable.add(Period("Recess", 50));
      timeTable.add(Period("AIES LAB", 150));
      break;

    case "Friday":
      timeTable.add(Period("CD", 50));
      timeTable.add(Period("SEPM", 50));
      timeTable.add(Period("IOT", 50));
      timeTable.add(Period("CNS", 50));
      timeTable.add(Period("Recess", 50));
      timeTable.add(Period("IOT LAB", 150));
      break;

    case "Saturday":
      timeTable.add(Period("IOT", 50));
      timeTable.add(Period("CD", 50));
      timeTable.add(Period("SEPM", 50));
      timeTable.add(Period("AIES", 50));
      timeTable.add(Period("LIBRARY", 50));

      break;

    case "Sunday":
      timeTable.add(Period("Fun-day", 14 * 50));
      break;

  }
  setupExactTimes();
}

// -----------------------------------------------------------------------------

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

// -----------------------------------------------------------------------------

void setupExactTimes() {
  DateTime tmpTime = collegeStart;
  for (Period period in timeTable) {
    period.startsAt = tmpTime;
    tmpTime = tmpTime.add(Duration(minutes: period.lengthInMinutes));
    period.endsAt = tmpTime;
  }
}

// -----------------------------------------------------------------------------

Future asyncDayChooser(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose day',
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                  fontWeight: FontWeight.bold)),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                assignTimeTable('Monday');
                todayState.refresh('Monday');
                Navigator.pop(context);
                remainingState.refresh();
              },
              child: Text('Monday',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
            ),
            SimpleDialogOption(
              onPressed: () {
                assignTimeTable('Tuesday');
                todayState.refresh('Tuesday');
                Navigator.pop(context);
                remainingState.refresh();
              },
              child: Text('Tuesday',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
            ),
            SimpleDialogOption(
              onPressed: () {
                assignTimeTable('Wednesday');
                todayState.refresh('Wednesday');
                Navigator.pop(context);
                remainingState.refresh();
              },
              child: Text('Wednesday',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
            ),
            SimpleDialogOption(
              onPressed: () {
                assignTimeTable('Thursday');
                todayState.refresh('Thursday');
                Navigator.pop(context);
                remainingState.refresh();
              },
              child: Text('Thursday',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
            ),
            SimpleDialogOption(
              onPressed: () {
                assignTimeTable('Friday');
                todayState.refresh('Friday');
                Navigator.pop(context);
                remainingState.refresh();
              },
              child: Text('Friday',
                  style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5)),
            ),
            SimpleDialogOption(
                onPressed: () {
                  assignTimeTable('Saturday');
                  todayState.refresh('Saturday');
                  Navigator.pop(context);
                  remainingState.refresh();
                },
                child: Text('Saturday',
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5.5))),
          ],
        );
      });
}
