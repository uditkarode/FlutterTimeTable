import 'package:flutter/material.dart';
import 'package:time_table/SizeConfig.dart';
import 'package:time_table/utils.dart';
import 'TodayText.dart';
import 'ActiveTime.dart';
import 'CurrentPeriod.dart';
import 'RemainingPeriods.dart';

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
                      GestureDetector(
                          onTap: () {
                            asyncDayChooser(context);
                          },
                          child: TodayText())
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
                      children: <Widget>[CurrentPeriod()],
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