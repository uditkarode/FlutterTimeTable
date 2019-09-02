import 'package:flutter/material.dart';
import 'package:time_table/globals.dart';
import 'package:time_table/SizeConfig.dart';

class TodayText extends StatefulWidget {
  TodayState createState() => todayState;
}

// -----------------------------------------------------------------------------

class TodayState extends State<TodayText> {
  void refresh(String day) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      today,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color(0xffB3E5FC),
          fontSize: SizeConfig.safeBlockHorizontal * 10),
    );
  }
}